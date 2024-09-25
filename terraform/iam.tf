# IAM Role para a Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Anexa política gerenciada pela AWS para logs
resource "aws_iam_role_policy_attachment" "lambda_logs_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# IAM Policy personalizada para o Cognito
resource "aws_iam_policy" "lambda_cognito_policy" {
  name = "lambda-cognito-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminAddUserToGroup",
          "cognito-idp:AdminListGroupsForUser"
        ],
        Effect   = "Allow",
        Resource = aws_cognito_user_pool.user_pool.arn
      }
    ]
  })
}

# Attach Policy de Cognito na Role
resource "aws_iam_role_policy_attachment" "lambda_cognito_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_cognito_policy.arn
}

# Permissão para o API Gateway invocar a função Lambda
resource "aws_lambda_permission" "apigw_invoke_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  
  # Especifica o ARN do API Gateway para limitar as permissões
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
