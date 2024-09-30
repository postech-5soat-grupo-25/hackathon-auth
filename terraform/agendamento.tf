# Definição do recurso API Gateway para "working-hours"
resource "aws_api_gateway_resource" "working_hours" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "working-hours"
}

# /usuarios-service/working-hours - GET
resource "aws_api_gateway_method" "working_hours_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.working_hours.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "working_hours_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.working_hours.id
  http_method             = aws_api_gateway_method.working_hours_get_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/agendamento-service/working-hours"
}

# /usuarios-service/working-hours - POST
resource "aws_api_gateway_method" "working_hours_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.working_hours.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "working_hours_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.working_hours.id
  http_method             = aws_api_gateway_method.working_hours_post_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/agendamento-service/working-hours"
}

# Definição do recurso API Gateway para "appointment"
resource "aws_api_gateway_resource" "appointment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.usuarios_service.id
  path_part   = "appointment"
}

# /usuarios-service/appointment - GET
resource "aws_api_gateway_method" "appointment_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.appointment.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "appointment_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.appointment.id
  http_method             = aws_api_gateway_method.appointment_get_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/agendamento-service/appointment"
}

# /usuarios-service/appointment - POST
resource "aws_api_gateway_method" "appointment_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.appointment.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "appointment_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.appointment.id
  http_method             = aws_api_gateway_method.appointment_post_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/agendamento-service/appointment"
}

# /usuarios-service/appointment - DELETE
resource "aws_api_gateway_method" "appointment_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.appointment.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "appointment_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.appointment.id
  http_method             = aws_api_gateway_method.appointment_delete_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "DELETE"
  uri                     = "https://${aws_lb.ecs_alb.dns_name}/agendamento-service/appointment"
}