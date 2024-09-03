FROM apache/airflow:2.7.1-python3.9

COPY requirements.txt /requirements.txt

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt

USER root

COPY dags/ /airflow/dags/
COPY data/ /airflow/data/
COPY credentials/ /airflow/credentials/
COPY .env /airflow/

RUN chown -R airflow: /airflow/dags/ /airflow/data/

USER airflow