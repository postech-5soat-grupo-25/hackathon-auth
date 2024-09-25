# Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = var.aws_cognito_user_pool_name

  # Auto-verifica o e-mail durante o registro
  auto_verified_attributes = ["email"]

  # Regras de política de senha para o User Pool
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # Template de mensagem de verificação de e-mail
  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_message        = "Clique no link para verificar seu e-mail: {####}"
    email_subject        = "Health&Med - Verifique seu e-mail para completar o registro"
  }

  # Configuração de envio de e-mail
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
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
