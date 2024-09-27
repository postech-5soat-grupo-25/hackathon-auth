resource "aws_ecr_repository" "agendamento_ecr" {
  name                 = "agendamento-service"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "usuarios_ecr" {
  name                 = "usuarios-service"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}