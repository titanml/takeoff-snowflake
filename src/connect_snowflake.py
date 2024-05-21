import snowflake.connector
import requests
import os

user = os.getenv('SNOWFLAKE_USER', 'yichengwang')
password = os.getenv('SNOWFLAKE_PASSWORD')
account = os.getenv('SNOWFLAKE_ACCOUNT', 'fqlpbpi-ga70241')
# Set this to the ingress endpoint URL for your service
url = os.getenv('SNOWFLAKE_INGRESS_URL', 'https://algse-fqlpbpi-ga70241.snowflakecomputing.app')

ctx = snowflake.connector.connect(
   user=user,
   password=password,
   account=account,
   session_parameters={
      'PYTHON_CONNECTOR_QUERY_RESULT_FORMAT': 'json'
   })

# Obtain a session token.
token_data = ctx._rest._token_request('ISSUE')
token_extract = token_data['data']['sessionToken']

# Create a request to the ingress endpoint with authz.
token = f'\"{token_extract}\"'
headers = {
    'Authorization': f'Snowflake Token={token}',
    'Content-Type': 'application/json'
    }

print(f'Ingress URL: {url}')
print(f'Token: {token}')

data = {
   "text": "List three things to do in London: "
}

# Validate the connection.
response = requests.post(f'{url}/generate', headers=headers, json=data)
print(response.text)
