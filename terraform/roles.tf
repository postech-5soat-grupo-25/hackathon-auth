resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_ecr_pull_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}



# PERMISSÃO PARA OS SERVIÇOS ACESSAREM O COGNITO

# Defina uma política de permissão para o Cognito
resource "aws_iam_policy" "cognito_policy" {
  name        = "CognitoFullAccessPolicy"
  description = "Permissão total para acessar o Cognito"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "cognito-identity:*",
          "cognito-idp:*",
          "cognito-sync:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}


# Anexe a política de Cognito ao role da task
resource "aws_iam_role_policy_attachment" "cognito_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.cognito_policy.arn
}