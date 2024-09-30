import json
import boto3
import os
from aws_lambda_powertools import Logger


logger = Logger(service="LambdaLogin")

@logger.inject_lambda_context(log_event=True)
def lambda_handler(event, context):
    try:
        client_id = os.environ["COGNITO_CLIENT_ID"]
        body = event.get('body', "")

    except Exception as e:
        logger.error(f"Error reading environment variables: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'message': 'Internal Server Error'})
        }

    if not body:
        raise Exception("Body is missing")


    try:
        body = json.loads(body)
        logger.debug(f"Request body: {body}")


        username = body['username']
        password = body['password']
    except KeyError as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Please, provide username and password correctly'})
        }

    try:
        client = boto3.client("cognito-idp")
        response = client.initiate_auth(
            ClientId=client_id,
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={
                'USERNAME': username,
                'PASSWORD': password
            }
        )
        return {
            'statusCode': 200,
            'body': json.dumps(response['AuthenticationResult'])
        }
    except client.exceptions.NotAuthorizedException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Invalid username or password'})
        }
    except client.exceptions.UserNotFoundException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'User not found'})
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': str(e)})
        }