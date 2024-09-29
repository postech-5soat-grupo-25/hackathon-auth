# IAM Role para a Lambda
resource "aws_iam_role" "lambda_auth_role" {
  name = "lambda-auth-role"
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
resource "aws_iam_role_policy_attachment" "lambda_auth_logs_policy" {
  role       = aws_iam_role.lambda_auth_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# IAM Policy personalizada para o Cognito
resource "aws_iam_policy" "lambda_auth_cognito_policy" {
  name = "lambda-auth-cognito-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
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
resource "aws_iam_role_policy_attachment" "lambda_auth_cognito_policy_attachment" {
  role       = aws_iam_role.lambda_auth_role.name
  policy_arn = aws_iam_policy.lambda_auth_cognito_policy.arn
}

# Permissão para o API Gateway invocar a função Lambda
resource "aws_lambda_permission" "api_gateway_invoke_lambda_auth" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_auth.function_name
  principal     = "apigateway.amazonaws.com"

  # Especifica o ARN do API Gateway para limitar as permissões
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_iam_role" "lambda_email_role" {
  name = "lambda-email-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Anexa política gerenciada pela AWS para logs
resource "aws_iam_role_policy_attachment" "lambda_email_logs_policy" {
  role       = aws_iam_role.lambda_email_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_email_ses_policy" {
  name = "LambdaSESPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:ListVerifiedEmailAddresses",
          "ses:VerifyEmailIdentity"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_email_ses_policy_attachment" {
  role       = aws_iam_role.lambda_email_role.name
  policy_arn = aws_iam_policy.lambda_email_ses_policy.arn
}

# Permissão para o API Gateway invocar a função Lambda
resource "aws_lambda_permission" "api_gateway_invoke_lambda_email" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_email.function_name
  principal     = "apigateway.amazonaws.com"

  # Especifica o ARN do API Gateway para limitar as permissões
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
