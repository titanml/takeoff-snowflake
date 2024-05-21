import snowflake.connector
import requests

ctx = snowflake.connector.connect(
   user="<username>",# username
   password="<your_password>", # insert password here
   account="<org>-<account>",
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

print(headers)
# Set this to the ingress endpoint URL for your service
url = 'https://algr4-fqlpbpi-ga70241.snowflakecomputing.app'


data = {
   "text": "Hello, Snowflake!"
}

# Validate the connection.
response = requests.post(f'{url}/generate', headers=headers, json=data)
print(response.text)
