resource "aws_ecs_cluster" "hackathon_ecs_cluster" {
  name = "hackathon-ecs-cluster"
}

resource "aws_launch_template" "ecs_instance_template" {
  name_prefix   = "ecs-template-"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon ECS-optimized Amazon Linux 2 AMI
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.ecs_subnet_public.id
    security_groups             = [aws_security_group.ecs_instance_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }
}


