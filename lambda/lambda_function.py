import boto3
import json
from custom_encoder import CustomEncoder
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodbTableName = "userserverless"
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(dynamodbTableName)

getMethod = 'GET'
postMethod = 'POST'
putMethod = 'PUT'
deleteMethod = 'DELETE'

healthPath = '/health'
productPath = '/user'
productsPath = '/users'

def lambda_handler(event, context):
    logger.info(event)
    httpMethod = event['httpMethod']
    path = event['path']
    if httpMethod == getMethod and path == healthPath:
        response = buildResponse(200)
    elif httpMethod == getMethod and path == productPath:
        response = getProduct(event['queryStringParameters']['id'])
    elif httpMethod == getMethod and path == productsPath:
        response = getProducts()
    elif httpMethod == postMethod and path == productPath:
        response = saveProduct(json.loads(event['body']))
    elif httpMethod == putMethod and path == productPath:
        requestBody = json.loads(event['body'])
        response = modifyProduct(requestBody)
    elif httpMethod == deleteMethod and path == productPath:
        requestBody = json.loads(event['body'])
        response = deleteProduct(requestBody['id'])
    else:
        response = buildResponse(404, 'Not found')
    return response

def getProduct(productId):
    try:
        response = table.get_item(Key={'id': productId})
        if 'Item' in response:
            return buildResponse(200, response['Item'])
        else:
            return buildResponse(404, {'Message': f'ProductId {productId} not found'})
    except Exception as e:
        logger.exception(f"Error: {e}")

def getProducts():
    try:
        response = table.scan()
        result = response['Items']
        while 'LastEvaluatedKey' in response:
            response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
            result.extend(response['Items'])
        body = {'products': result}
        return buildResponse(200, body)
    except Exception as e:
        logger.exception(f"Error: {e}")

def saveProduct(requestBody):
    try:
        table.put_item(Item=requestBody)
        body = {'Operation': 'SAVE', 'Message': 'SUCCESS', 'Item': requestBody}
        return buildResponse(200, body)
    except Exception as e:
        logger.exception(f"Error: {e}")

def modifyProduct(event):
    try:
        response = table.update_item(
            Key={'id': event['id']},
            UpdateExpression='SET fname=:pn, lname=:pnum, username=:pb, email=:d, avatar=:a',
            ExpressionAttributeValues={
                ':pn': event['fname'],
                ':pnum': event['lname'],
                ':pb': event['username'],
                ':d': event['email'],
                ':a': event['avatar'],
            },
            ReturnValues='UPDATED_NEW'
        )
        body = {'Operation': 'UPDATE', 'Message': 'SUCCESS', 'UpdateAttributes': response}
        return buildResponse(200, body)
    except Exception as e:
        logger.exception(f"Error: {e}")

def deleteProduct(productId):
    try:
        response = table.delete_item(Key={'id': productId}, ReturnValues='ALL_OLD')
        body = {'Operation': 'DELETE', 'Message': 'SUCCESS', 'deletedItem': response}
        return buildResponse(200, body)
    except Exception as e:
        logger.exception(f"Error: {e}")

def buildResponse(statusCode, body=None):
    response = {
        'statusCode': statusCode,
        'headers': {'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
    }
    if body is not None:
        response['body'] = json.dumps(body, cls=CustomEncoder)
    return response
