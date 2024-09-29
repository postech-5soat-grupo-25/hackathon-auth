import json
import boto3
import os
from aws_lambda_powertools import Logger

client = boto3.client("cognito-idp")

logger = Logger(service="LambdaSignup")

@logger.inject_lambda_context(log_event=True)
def lambda_handler(event, context):
    try:
        user_pool_id = os.environ["COGNITO_USER_POOL_ID"]
        client_id = os.environ["COGNITO_CLIENT_ID"]

        resource = event.get('resource', '')
        http_method = event.get('httpMethod', '')
        query_string_parameters = event.get('queryStringParameters', '')
        path_parameters = event.get('pathParameters', '')
        headers = event.get("headers")
        body = event.get('body', "")

        logger.info(f"Received event with resource: {resource}, method: {http_method}")

        if body:
            body = json.loads(body)
            logger.debug(f"Request body: {body}")
    except Exception as e:
        logger.error(f"Error reading environment variables: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'message': 'Internal Server Error'})
        }

    try:
        username = body['username']
        password = body['password']
        email = body['email']
    except KeyError as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Please, provide email, username and password correctly'})
        }

    try:
        logger.info("Criando usuário")
        response = client.sign_up(
            ClientId=client_id,
            Username=username,
            Password=password,
            UserAttributes=[
                {
                    'Name': 'email',
                    'Value': email
                }
            ]
        )

        logger.info(f"Usuário criado com sucesso {response}")
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'User registered successfully'})
        }
    except client.exceptions.UsernameExistsException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'User already exists'})
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': str(e)})
        }