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

**Atenção** as respostas às perguntas de negócio deste desafio estão no arquivo *queries.sql*

## Este ETL é correspondente ao seguinte desafio:

O desafio consiste em desenvolver um ETL para processar arquivos que representam o orçamento do Estado de São Paulo de 2022 e armazená-los em um formato consistente para responder perguntas que ajudarão nosso time.

Os valores foram dolarizados com a cotação máxima do dolár do dia 22/06/2022.

## Tarefas

**Sobre os dados**

Disponibilizamos para você dois arquivos com os dados de Despesas e Receitas do Orçamento do Estado de São Paulo em 2022

| Dataset | Descrição      |
| :---  | :---      |
|[**gdvDespesasExcel**](./gdvDespesasExcel.csv) | Dados de despesas do Estado |
|[**gdvReceitasExcel**](./gdvReceitasExcel.csv) | Dados de receita do Estado |
|[**API cotação de moedas**](https://docs.awesomeapi.com.br/api-de-moedas#retorna-o-fechamento-de-um-periodo-especifico) | API que retorna cotação de uma moeda em um período especifico |


### Transformar e salvar os dados

**Regras de negócio**

* A tabela final deve conter as colunas ID da fonte de recurso, nome da fonte de recursos, total arrecadado e total liquidado.
    - Exemplo: a fonte de recurso `001 - TESOURO-DOT.INICIAL E CRED.SUPLEMENTAR` deverá ser salva como:

| ID Fonte Recurso | Nome Fonte Recurso| Total Liquidado | Total Arrecadado |
| :---  | :---      | :---  | :---  |
| 001 | TESOURO-DOT.INICIAL E CRED.SUPLEMENTAR | 9999.99 | 9999.99 |

* Os valores obitidos acima devem também ser exibidos na cotação do real no dia 22/06/2022 no formato decimal usando a api (https://docs.awesomeapi.com.br/api-de-moedas#retorna-o-fechamento-de-um-periodo-especifico) (lembrando que os valores das planilhas foram dolarizados)
* Adequar os tipos de dados para os mais apropriados.
* Para ajudar a identificar registros mais atualizados e para nosso controle de auditoria, precisamos que a tabela final tenha as colunas `dt_insert` que contenha data/hora de inclusão do registro
* Salvar esses dados em uma tabela, preferencialmente no BigQuery


### Utilizando consultas SQL responda as perguntas
* Quais são as 5 fontes de recursos que mais arrecadaram?
* Quais são as 5 fontes de recursos que mais gastaram?
* Quais são as 5 fontes de recursos com a melhor margem bruta?
* Quais são as 5 fontes de recursos que menir arrecadaram?
* Quais são as 5 fontes de recursos que menir gastaram?
* Quais são as 5 fontes de recursos com a pior margem bruta?
* Qual a média de arrecadação por fonte de recurso?
* Qual a média de gastos por fonte de recurso?


### Orquestração de Tarefas
O objetivo desse desafio é avaliar o conhecimento em automação do fluxo de dados, você tem a liberdade para demonstrar seus conhecimentos em orquestração, infraestrutura e conteinerização do projeto utilizando Docker.

### O que esperamos:
* Seu projeto deve estar hospedado em um repositório **git**.
* Crie uma documentação que explique como fez para chegar nos resultados obtidos, contendo as instruções para reproduzirmos suas análises, pode ser no **README** do git.
* A ferramenta de orquestração deve incluir cada etapa do ETL, sendo preferencialmente **Airflow**.
* Sinta-se à vontade para usar qualquer framework, bibliotecas e ferramentas que se sentir à vontade a única restrição é a linguagem de programação que deve ser **Python**

**Dicas**
* Usar encoding para ler arquivo sem erros
* Pandas para leitura de arquivos csv
* Se atentar as virgulas em campos que exibem valores
* Ler a documentação na api de moedas awesomeapi para utilizar o endpoint correto para obter da cotação do real

Boa sorte !