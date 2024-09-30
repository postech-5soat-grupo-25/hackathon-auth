resource "aws_api_gateway_resource" "medico_delete" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "medico"
}


# /usuarios-service/medico/{username} - DELETE
resource "aws_api_gateway_resource" "medico_delete_username" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.medico_delete.id
  path_part   = "{username}"
}

resource "aws_api_gateway_method" "medico_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.medico_delete_username.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "medico_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.medico_delete_username.id
  http_method             = aws_api_gateway_method.medico_delete_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "DELETE"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/medico/{username}"
}


# /usuarios-service/medico/{username} - GET

resource "aws_api_gateway_method" "medico_get_username_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.medico_delete_username.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "medico_get_username_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.medico_delete_username.id
  http_method             = aws_api_gateway_method.medico_get_username_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/medico/{username}"
}






# /usuarios-service/medico - GET
resource "aws_api_gateway_method" "medico_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.medico_delete.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "medico_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.medico_delete.id
  http_method             = aws_api_gateway_method.medico_get_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/medico"
}








# /usuarios-service/medico/{username} - PUT

resource "aws_api_gateway_method" "medico_put_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.medico_delete.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "medico_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.medico_delete.id
  http_method             = aws_api_gateway_method.medico_put_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "PUT"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/usuarios-service/medico/{username}"
}



