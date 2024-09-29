resource "aws_lambda_function" "lambda_function_auth" {
  function_name    = var.aws_lambda_function_auth_name
  handler          = "main.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_auth_role.arn
  filename         = "../source/lambda/signup.zip"
  source_code_hash = filebase64sha256("../source/lambda/signup.zip")

  # Definindo variáveis de ambiente
  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id
      COGNITO_CLIENT_ID    = aws_cognito_user_pool_client.user_pool_client.id
    }
  }

  depends_on = [
    aws_iam_role.lambda_auth_role,
    aws_cognito_user_pool.user_pool,
    aws_cognito_user_pool_client.user_pool_client
  ]
}

resource "aws_lambda_function" "lambda_function_email" {
  function_name    = var.aws_lambda_function_email_name
  handler          = "main.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_email_role.arn
  filename         = "../source/lambda/email.zip"
  source_code_hash = filebase64sha256("../source/lambda/email.zip")

  environment {
    variables = {
      EMAIL_SOURCE = var.email
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_email_ses_policy_attachment
  ]
}

resource "aws_lambda_function" "lambda_pre_signup" {
  filename         = "../source/lambda/pre-signup.zip"
  function_name    = "LambdaPreSignUp"
  role             = aws_iam_role.lambda_email_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = filebase64sha256("../source/lambda/pre-signup.zip")

  environment {
    variables = {
      STAGE = "prod"
    }
  }
}


resource "aws_lambda_permission" "allow_cognito_invoke" {
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_pre_signup.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.user_pool.arn

  depends_on = [aws_cognito_user_pool.user_pool, aws_lambda_function.lambda_pre_signup]
}




resource "aws_lambda_function" "lambda_login" {
  filename         = "../source/lambda/login.zip"
  function_name    = "LambdaLogin"
  role             = aws_iam_role.lambda_email_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = filebase64sha256("../source/lambda/login.zip")

  # Definindo variáveis de ambiente
  environment {
    variables = {
      COGNITO_CLIENT_ID    = aws_cognito_user_pool_client.user_pool_client.id
    }
  }
}
