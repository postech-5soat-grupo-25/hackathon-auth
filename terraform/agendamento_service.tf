resource "aws_ecs_service" "agendamento_service" {
  name          = "agendamento-service"
  cluster       = aws_ecs_cluster.hackathon_ecs_cluster.id
  launch_type   = "FARGATE"
  desired_count = 1

  network_configuration {
    subnets          = [aws_subnet.ecs_subnet_public.id, aws_subnet.ecs_subnet_public_2.id]
    security_groups  = [aws_security_group.ecs_task_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hackathon_target_group.arn
    container_name   = "agendamento-app"
    container_port   = 80
  }

  task_definition = aws_ecs_task_definition.agendamento_task.id

  depends_on = [aws_lb_listener.ecs_listener]
}

resource "aws_cloudwatch_log_group" "agendamento_service_logs" {
  name              = "/ecs/agendamento-service"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "agendamento_task" {
  family                   = "agendamento"
  network_mode             = "awsvpc" # Usar o modo de rede awsvpc para Fargate
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Ajuste para Fargate, por exemplo: 256 CPU
  memory                   = "512" # Ajuste para Fargate, por exemplo: 512 MB de memória

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "agendamento-app"
      image     = "${aws_ecr_repository.agendamento_ecr.repository_url}:latest"
      essential = true

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/agendamento-service"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment = [
        {
          name  = "DB_HOST"
          value = "hackathon-db.cx6k4wiowwza.us-east-1.rds.amazonaws.com"
        },
        {
          name  = "DB_PORT"
          value = "5432"
        },
        {
          name  = "DB_USER"
          value = "mainuser"
        },
        {
          name  = "DB_PASSWD"
          value = "mainpassword"
        },
        {
          name  = "DB_NAME"
          value = "HackathonDb"
        }
      ]

      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ])
}


resource "aws_lb_target_group" "hackathon_target_group" {
  name        = "hackathon-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecs_vpc.id
  target_type = "ip" # Alterado para "ip" para compatibilidade com o awsvpc network mode

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hackathon_target_group.arn
  }
}