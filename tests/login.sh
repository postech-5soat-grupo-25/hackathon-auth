#!/bin/bash

API_GATEWAY_ID="..."
USER_POOL_ID="..."
USERNAME="..."
PASSWORD="..."

# Cria o usuário com uma senha temporária
echo "Criando o usuário..."
aws cognito-idp admin-create-user \
  --user-pool-id $USER_POOL_ID \
  --username $USERNAME \
  --user-attributes Name=email,Value=$USERNAME \
  --temporary-password $PASSWORD \
  --message-action SUPPRESS > /dev/null 2>&1

# Altera a senha para uma permanente
echo "Alterando a senha para uma permanente..."
aws cognito-idp admin-set-user-password \
  --user-pool-id $USER_POOL_ID \
  --username $USERNAME \
  --password $PASSWORD \
  --permanent > /dev/null 2>&1

echo "Usuário criado e senha alterada com sucesso!"

# Faz login usando o API Gateway
echo "Realizando o login..."
curl -X POST https://$API_GATEWAY_ID.execute-api.us-east-1.amazonaws.com/prod/login \
  -H "Content-Type: application/json" \
  -d "{\"email\": \"$USERNAME\", \"password\": \"$PASSWORD\"}"
