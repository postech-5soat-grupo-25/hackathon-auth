resource "aws_security_group" "ecs_task_usuarios_service" {
  name   = "ecs-task-usuarios-service"
  vpc_id = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "usuarios_service" {
  name            = "usuarios-service"
  cluster         = aws_ecs_cluster.hackathon_ecs_cluster.id
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [aws_subnet.ecs_subnet_public.id, aws_subnet.ecs_subnet_public_2.id]
    security_groups  = [aws_security_group.ecs_task_usuarios_service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.usuarios_service_target_group.arn
    container_name   = "usuarios-app"
    container_port   = 8080
  }

  task_definition = aws_ecs_task_definition.usuarios_task.id

  depends_on = [aws_lb_listener.ecs_listener]
}


resource "aws_cloudwatch_log_group" "usuario_service_logs" {
  name              = "/ecs/usuarios-service"
  retention_in_days = 1
}


resource "aws_ecs_task_definition" "usuarios_task" {
  family                   = "usuarios"
  network_mode             = "awsvpc"  # Usar o modo de rede awsvpc para Fargate
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"    # Ajuste para Fargate, por exemplo: 256 CPU
  memory                   = "1024"    # Ajuste para Fargate, por exemplo: 512 MB de memória

  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions    = jsonencode([
    {
      name  = "usuarios-app"
      image = "${aws_ecr_repository.usuarios_ecr.repository_url}:latest"
      essential = true
      cpu                      = 512
      memory                   = 1024

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/usuarios-service"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment = [
        {
          name  = "USERPOOL_ID"
          value = aws_cognito_user_pool.user_pool.id
        },
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "PORT"
          value = "8080"
        }
      ]

      portMappings = [{
        containerPort = 8080
        hostPort      = 8080
      }]
    }
  ])
}


resource "aws_lb_target_group" "usuarios_service_target_group" {
  name        = "usuarios-service-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecs_vpc.id
  target_type = "ip"   # Alterado para "ip" para compatibilidade com o awsvpc network mode

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_listener_rule" "another_listener_rule" {
  listener_arn = aws_lb_listener.ecs_listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.usuarios_service_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/usuarios-service/*"]
    }
  }
}