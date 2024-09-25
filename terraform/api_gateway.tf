# Rest API
resource "aws_api_gateway_rest_api" "api" {
  name = var.aws_api_gateway_rest_api_name
}

# Deploy da API
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.signup_integration,
    aws_api_gateway_integration.login_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

# Autenticação com Cognito
resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name            = "cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.api.id
  identity_source = "method.request.header.Authorization"
  provider_arns   = [aws_cognito_user_pool.user_pool.arn]
  type            = "COGNITO_USER_POOLS"
}

# /login
resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "login"
}

# POST /login
resource "aws_api_gateway_method" "login_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

# POST /login Integration
resource "aws_api_gateway_integration" "login_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.login_post.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

# /signup
resource "aws_api_gateway_resource" "signup" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "signup"
}

# POST /signup
resource "aws_api_gateway_method" "signup_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.signup.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

# POST /signup Integration
resource "aws_api_gateway_integration" "signup_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.signup.id
  http_method             = aws_api_gateway_method.signup_post.http_method
  type                    = "AWS_PROXY" # "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda_function.invoke_arn # Endereço do seu Load Balancer
}
