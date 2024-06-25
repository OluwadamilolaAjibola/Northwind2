import pandas as pd ## For data manipulation
import requests as rq ## To connect to the API
import configparser as cp ## To read the configuration file
from sqlalchemy import create_engine as ce ## To connect to the database

def etl_process():
 config = cp.ConfigParser()
 config.read ('config.ini')

## To connect to the database
 postgres_config = config ['postgres']
 engine = ce (f"postgresql://{postgres_config['user']}:{postgres_config['password']}@{postgres_config['host']}/{postgres_config['database']}")

## To connect to the API
 url = 'https://demodata.grapecity.com/northwind/api/v1/Shippers'
 api_response = rq.get(url)
 data = api_response.json()

## To send the data to postgres
 df = pd.json_normalize(data)
 df.to_sql('shipper',engine,if_exists='replace',index=False)

 engine.dispose()
 
 etl_process()