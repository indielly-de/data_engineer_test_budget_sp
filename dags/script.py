from typing import Any, Dict
import requests
import pandas as pd
from setting import settings
from google.oauth2 import service_account

credentials = service_account.Credentials.from_service_account_file('credentials/sa.json')

# retorna valor da cotação para a moeda e o período
def get_quotation(currency, period):
    url = f'{settings.API_URL}/json/daily/{currency}'
    params = {'start_date': period, 'end_date': period}
    response = requests.get(url, params=params)
    data = response.json()
    value = data[0]['high']
    return float(value)

def extract_data(csv_file, cols):
    path = f'data/{csv_file}.csv'
    df = pd.read_csv(path, encoding=settings.ENCODING, sep=',', usecols=cols)
    return df

def transform(df, column_value_name):
    name_column = df['Fonte de Recursos']
    df.insert(0, 'id_fonte_recurso', name_column.str[:3])

    resource_name = df['Fonte de Recursos'].str.replace(r'\d+', '', regex=True).str.strip()
    resource_name = resource_name.str.replace(r'^- ', '', regex=True).str.strip()
    df['nome_fonte_recurso'] = resource_name

    value = df[column_value_name].str.strip().str.replace('.', '', regex=False).str.replace(',', '.', regex=False).astype(float)
    df[column_value_name] = value * get_quotation(settings.CURRENCY, settings.PERIOD)
    return df.groupby(['id_fonte_recurso', 'nome_fonte_recurso'], as_index=False).agg({column_value_name: 'sum'})

def merge_df(revenue, cost):
    grouped_revenue = transform(revenue, 'Arrecadado')
    grouped_cost = transform(cost, 'Liquidado')

    merged = pd.merge(grouped_revenue, grouped_cost, on=['id_fonte_recurso', 'nome_fonte_recurso'], how='outer')
    merged.rename(columns={'Liquidado':'total_liquidado', 'Arrecadado':'total_arrecadado'}, inplace=True)
    merged.fillna(0, inplace=True)
    merged['dt_insert'] = pd.Timestamp.now()
    return merged

def load_bq(df: pd.DataFrame, project_id: str, table_id: str):
    df.to_gbq(destination_table=table_id, project_id=project_id, credentials=credentials, if_exists='replace')