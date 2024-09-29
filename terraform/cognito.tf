# Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = var.aws_cognito_user_pool_name

  lambda_config {
    pre_sign_up = aws_lambda_function.lambda_pre_signup.arn
  }


  # Atributos customizados
  schema {
    name                     = "cpf"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "crm"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name            = var.aws_cognito_user_pool_client_name
  user_pool_id    = aws_cognito_user_pool.user_pool.id
  generate_secret = false

  # Fluxos de autenticação permitidos
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]
}

# Grupos no User Pool para Médicos
resource "aws_cognito_user_group" "medico_group" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = var.aws_cognito_medico_group_name
  description  = "Grupo para médicos"
}

# Grupos no User Pool para Pacientes
resource "aws_cognito_user_group" "paciente_group" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = var.aws_cognito_paciente_group_name
  description  = "Grupo para pacientes"
}

# Grupos no User Pool para Admins
resource "aws_cognito_user_group" "admin_group" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = var.aws_cognito_admin_group_name
  description  = "Grupo para administradores"
}
