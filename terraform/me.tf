# /usuarios-service/me - DELETE
resource "aws_api_gateway_resource" "me_delete" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "me"
}

resource "aws_api_gateway_method" "me_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.me_delete.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "me_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.me_delete.id
  http_method             = aws_api_gateway_method.me_delete_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "DELETE"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/me"
}



# /usuarios-service/me - GET

resource "aws_api_gateway_method" "me_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.me_delete.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "me_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.me_delete.id
  http_method             = aws_api_gateway_method.me_get_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/me"
}



# /usuarios-service/me/{username} - PUT

resource "aws_api_gateway_method" "me_put_username_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.me_delete.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "me_put_username_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.me_delete.id
  http_method             = aws_api_gateway_method.me_put_username_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "PUT"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/me/{username}"
}