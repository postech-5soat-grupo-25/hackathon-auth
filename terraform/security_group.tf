resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 0
    to_port     = 50000
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

# Atualizando o grupo de segurança do ALB para permitir tráfego do API Gateway
resource "aws_security_group_rule" "allow_api_gateway_to_alb" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Para simplificação, ajuste conforme necessário
  security_group_id = aws_security_group.alb_sg.id
}

# Load balancer security group egress rule to ECS cluster security group.
resource "aws_security_group_rule" "sg_egress_rule_lb_to_ecs_cluster" {
  type	= "egress"
  description = "Target group egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}


resource "aws_security_group" "ecs_instance_sg" {
  name   = "ecs-instance-sg"
  vpc_id = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 0
    to_port     = 50000
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

resource "aws_security_group" "ecs_task_sg" {
  name   = "ecs-task-sg"
  vpc_id = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 0
    to_port     = 50000
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