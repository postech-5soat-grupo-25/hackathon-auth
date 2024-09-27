#!/bin/bash

API_GATEWAY_ID="..."
SES_REGION="us-east-1"
FROM_EMAIL="..."
TO_EMAIL="..."  # E-mail do médico a ser enviado
NOME_MEDICO="Dr. João"  # Nome do médico
NOME_PACIENTE="Alan"  # Nome do paciente
DATA="2024-09-30"  # Data da consulta
HORARIO="14:00"  # Horário da consulta

# Chamando o endpoint /email
echo "Enviando o e-mail de confirmação..."
response=$(curl -X POST https://$API_GATEWAY_ID.execute-api.us-east-1.amazonaws.com/prod/email \
  -H "Content-Type: application/json" \
  -d "{\"email_medico\": \"$TO_EMAIL\", \"nome_medico\": \"$NOME_MEDICO\", \"nome_paciente\": \"$NOME_PACIENTE\", \"data\": \"$DATA\", \"horario\": \"$HORARIO\"}")

echo "Resposta da API: $response"