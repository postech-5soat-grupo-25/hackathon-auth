import json
import boto3
import os

client = boto3.client("cognito-idp")

# Obtém os valores das variáveis de ambiente
USER_POOL_ID = os.environ["COGNITO_USER_POOL_ID"]
CLIENT_ID = os.environ["COGNITO_CLIENT_ID"]

def lambda_handler(event, context):
    try:
        # Captura o e-mail e a senha do corpo da requisição
        body = json.loads(event["body"])
        email = body["email"]
        password = body["password"]

        # Tenta autenticar o usuário usando as variáveis de ambiente
        response = client.initiate_auth(
            ClientId=CLIENT_ID,
            AuthFlow="USER_PASSWORD_AUTH",
            AuthParameters={"USERNAME": email, "PASSWORD": password},
        )

        # Verifica se 'AuthenticationResult' está presente na resposta
        if "AuthenticationResult" in response:
            return {
                "statusCode": 200,
                "body": json.dumps(
                    {
                        "message": "Usuário autenticado com sucesso!",
                        "token": response["AuthenticationResult"]["IdToken"],
                    }
                ),
            }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({"message": "Erro na autenticação", "response": response}),
            }
    except client.exceptions.NotAuthorizedException:
        return {
            "statusCode": 401,
            "body": json.dumps({"message": "Credenciais inválidas"}),
        }
    except Exception as error:
        return {
            "statusCode": 400,
            "body": json.dumps({"message": str(error)}),
        }
