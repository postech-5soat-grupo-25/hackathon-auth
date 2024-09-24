# AWS Cognito
variable "aws_cognito_user_pool_name" {
  description = "Nome do User Pool Cognito"
  default     = "hackathon-user-pool"
}
variable "aws_cognito_user_pool_client_name" {
  description = "Nome do User Pool Client para o sistema"
  default     = "hackathon-client"
}
variable "aws_cognito_medico_group_name" {
  description = "Nome do grupo de médicos"
  default     = "Medicos"
}
variable "aws_cognito_paciente_group_name" {
  description = "Nome do grupo de pacientes"
  default     = "Pacientes"
}
variable "aws_cognito_admin_group_name" {
  description = "Nome do grupo de administradores"
  default     = "Admins"
}

# AWS API Gateway
variable "aws_api_gateway_rest_api_name" {
  description = "Nome do API Gateway"
  default     = "hackathon-api"
}

# AWS Lambda
variable "aws_lambda_function_name" {
  description = "Nome da Lambda function"
  default     = "hackathon-auth"
}