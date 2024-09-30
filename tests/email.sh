#!/bin/bash

API_GATEWAY_ID="5mbaqjqh39"
SES_REGION="us-east-1"
FROM_EMAIL="postech-5soat-grupo-25@grr.la"
TO_EMAIL="<EMAIL_MEDICO>"  # E-mail do médico a ser enviado (verificado no SES)
NOME_MEDICO="Fulano"  # Nome do médico
NOME_PACIENTE="Ciclano"  # Nome do paciente
DATA="2024-09-30"  # Data da consulta
HORARIO="14:00"  # Horário da consulta

# Chamando o endpoint /email
echo "Enviando o e-mail de confirmação..."
response=$(curl -X POST https://$API_GATEWAY_ID.execute-api.us-east-1.amazonaws.com/prod/email \
  -H "Content-Type: application/json" \
  -d "{\"email_medico\": \"$TO_EMAIL\", \"nome_medico\": \"$NOME_MEDICO\", \"nome_paciente\": \"$NOME_PACIENTE\", \"data\": \"$DATA\", \"horario\": \"$HORARIO\"}")

echo "Resposta da API: $response"