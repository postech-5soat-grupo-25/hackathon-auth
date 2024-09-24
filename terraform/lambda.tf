resource "aws_lambda_function" "lambda_function" {
  function_name    = var.aws_lambda_function_name
  handler          = "auth.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_role.arn
  filename         = "../source/lambda.zip"
  source_code_hash = filebase64sha256("../source/lambda.zip")

  # Definindo variáveis de ambiente
  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id
      COGNITO_CLIENT_ID    = aws_cognito_user_pool_client.user_pool_client.id
    }
  }

  depends_on = [
    aws_iam_role.lambda_role,
    aws_cognito_user_pool.user_pool,
    aws_cognito_user_pool_client.user_pool_client
  ]
}