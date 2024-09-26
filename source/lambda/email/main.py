import json
import boto3
import os

# Inicializa o cliente SES
ses_client = boto3.client("ses")

# Função Lambda para enviar o e-mail
def lambda_handler(event, context):
    # Extrai os dados do corpo da requisição
    body = json.loads(event["body"])
    email_medico = body["email_medico"]
    nome_medico = body["nome_medico"]
    nome_paciente = body["nome_paciente"]
    data = body["data"]
    horario = body["horario"]

    # Configura o conteúdo do e-mail
    titulo_email = "Health&Med - Nova consulta agendada"
    corpo_email = f"Olá, Dr. {nome_medico}!\nVocê tem uma nova consulta marcada! Paciente: {nome_paciente}.\nData e horário: {data} às {horario}."

    try:
        # Verifica o e-mail do médico antes de enviar
        verify_response = ses_client.list_verified_email_addresses()
        if email_medico not in verify_response['VerifiedEmailAddresses']:
            # Se o e-mail não está verificado, envia um pedido de verificação
            ses_client.verify_email_identity(EmailAddress=email_medico)
            return {
                "statusCode": 200,
                "body": json.dumps({"message": f"Um e-mail de verificação foi enviado para {email_medico}. Confirme o endereço para continuar."}),
            }

        # Se o e-mail já foi verificado, envia o e-mail de consulta
        response = ses_client.send_email(
            Source=os.environ["EMAIL_SOURCE"],  # Endereço de e-mail verificado no SES
            Destination={
                "ToAddresses": [email_medico],
            },
            Message={
                "Subject": {
                    "Data": titulo_email,
                    "Charset": "UTF-8",
                },
                "Body": {
                    "Text": {
                        "Data": corpo_email,
                        "Charset": "UTF-8",
                    }
                },
            },
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "E-mail enviado com sucesso!", "response": response}),
        }

    except Exception as error:
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Falha ao enviar o e-mail", "error": str(error)}),
        }
