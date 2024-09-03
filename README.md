# ETL Cotação SP

Este é um projeto de teste para simular um ETL para *KarHub*. \
O projeto simula um ETL que trata dados referentes à despesas e receitas relativas ao estado de São Paulo.

**Atenção**
A etapa do L(load) carrega os dados no *BigQuery* e para isso é necessário ter uma *SERVICE_ACCOUNT* com permissão *Admin de Recursos do BigQuery* e então gerar a chave e baixar o json
caso o processo esteja rodando em localhost. Para isso coloque o arquivo do service_account com o nome **sa.json** dentro da pasta **credentials** (APENAS PARA O TESTE)

**este é um arquivo sensível e não deve ser versionado em hipótese alguma**

## Tecnologias utilizadas

- Python 3.9
- Apache Airflow
- Pydantic Settings
- Pandas GBQ
- Docker
- Docker Compose
- PostgreSQL

## Configuração inicial

Será necessário preencher as variáveis *PROJECT_ID* e *TABLE_ID* contidas no arquivo *local.env*
após preenche-las, faça uma cópia desse arquivo com o nome *.env*

`$ cp local.env .env`

**Obs**: A variável *TABLE_ID* precisa estar no formato `project_id.dataset_id.table_name`

Após definir as variáveis, entre com o comando abaixo (OSX ou Linux)

`$ make setup`

ou

`docker-compose up --build -d`

## Criando um usuário para o admin do Airflow

Entre com o comando abaixo (OSX ou Linux)

`$ make user`

ou

`docker exec airflow-webserver airflow users create --username karhub --firstname Kar --lastname Hub --role Admin --email karhub@email.com --password karhub`

Após criar o usuário, a interface admin do airflow estará acessível em `http://localhost:8080`

**Obs**: Caso a interface ainda não esteja disponível após subir os containers, emita o comando no terminal:

`$ docker-compose ps`

e veja se o container **airflow-webserver**
está com o status *(health: starting)*, caso a resposta seja positiva, espere até o status ficar como *(healthly)*

## Parando os containers da applicação

Execute o comando abaixo (OSX ou Linux)

`$ make stop`

ou

`docker-compose stop`

Para iniciar os containers novamente:

`$ docker-compose start`

## Parar/Remover os containers e excluir os volumes gerados

Entre com o comando a seguir (OSX ou Linux)

`$ make remove`

ou

```
$ docker-compose down
$ docker system prune --volumes -f

```