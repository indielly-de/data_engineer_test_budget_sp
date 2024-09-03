import script
from airflow import DAG
from airflow.decorators import task
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'retries': 1
}

@task(task_id='extraindo_dados_despesa')
def extract_costs():
    return script.extract_data('gdvDespesasExcel', ['Fonte de Recursos', 'Liquidado'])

@task(task_id='extraindo_dados_receita')
def extract_revenues():
    return script.extract_data('gdvReceitasExcel', ['Fonte de Recursos', 'Arrecadado'])

@task(task_id='transformando_dados')
def transform(df_costs, df_revenues):
    return script.merge_df(df_revenues, df_costs)

@task(task_id='carregando_dados')
def load_to_bq(df):
    script.load_bq(df)

with DAG(
    'orcamento_sp',
    default_args=default_args,
    description='Load quotation data on bigquery',
    catchup=False,
    schedule='@daily'
) as dag:
    start = EmptyOperator(task_id='start')
    end = EmptyOperator(task_id='end')
    df_costs = extract_costs()
    df_revenues = extract_revenues()
    df = transform(df_costs, df_revenues)

    start >> [df_costs, df_revenues] >> df
    df >> load_to_bq(df) >> end