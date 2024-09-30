# /usuarios-service/paciente/{username} - DELETE
resource "aws_api_gateway_resource" "paciente_delete" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "paciente"
}

resource "aws_api_gateway_resource" "paciente_delete_username" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.paciente_delete.id
  path_part   = "{username}"
}

resource "aws_api_gateway_method" "paciente_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.paciente_delete_username.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "paciente_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.paciente_delete_username.id
  http_method             = aws_api_gateway_method.paciente_delete_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "DELETE"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/paciente/{username}"
}



# /usuarios-service/paciente - GET
resource "aws_api_gateway_resource" "paciente_get" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "paciente"
}

resource "aws_api_gateway_method" "paciente_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.paciente_get.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "paciente_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.paciente_get.id
  http_method             = aws_api_gateway_method.paciente_get_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/paciente"
}

# /usuarios-service/paciente/{username} - GET
resource "aws_api_gateway_resource" "paciente_get_username" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "paciente/{username}"
}

resource "aws_api_gateway_method" "paciente_get_username_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.paciente_get_username.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "paciente_get_username_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.paciente_get_username.id
  http_method             = aws_api_gateway_method.paciente_get_username_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/paciente/{username}"
}


# /usuarios-service/paciente/{username} - PUT
resource "aws_api_gateway_resource" "paciente_put" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "paciente/{username}"
}

resource "aws_api_gateway_method" "paciente_put_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.paciente_put.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "paciente_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.paciente_put.id
  http_method             = aws_api_gateway_method.paciente_put_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "PUT"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/paciente/{username}"
}