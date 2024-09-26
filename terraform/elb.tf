resource "aws_lb" "ecs_alb" {
  name               = "hackathon-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.ecs_subnet_public.id, aws_subnet.ecs_subnet_public_2.id]
}
