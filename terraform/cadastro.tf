# /usuarios-service/cadastro - POST
resource "aws_api_gateway_resource" "cadastro" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "cadastro"
}

resource "aws_api_gateway_method" "cadastro_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.cadastro.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "cadastro_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.cadastro.id
  http_method             = aws_api_gateway_method.cadastro_post.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/cadastro"
}

