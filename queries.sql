-- 1. Quais são as 5 fontes de recursos que mais arrecadaram?
SELECT
  nome_fonte_recurso,
  total_arrecadado
FROM `your_project_id.dataset_id.table_id`
ORDER BY total_arrecadado DESC
LIMIT 5

-- 2. Quais são as 5 fontes de recursos que mais gastaram?
SELECT
  nome_fonte_recurso,
  total_liquidado
FROM `your_project_id.dataset_id.table_id`
ORDER BY total_arrecadado DESC
LIMIT 5

-- 3. Quais são as 5 fontes de recursos com a melhor margem bruta?-
SELECT
  nome_fonte_recurso,
  (total_arrecadado - total_liquidado) AS margem_bruta
FROM `your_project_id.dataset_id.table_id`
ORDER BY margem_bruta DESC
LIMIT 5

-- 4. Quais são as 5 fontes de recursos que menos arrecadaram?
SELECT
  nome_fonte_recurso,
  total_arrecadado
FROM `your_project_id.dataset_id.table_id`
ORDER BY total_arrecadado ASC
LIMIT 5

-- 5. Quais são as 5 fontes de recursos que menos gastaram?
SELECT
  nome_fonte_recurso,
  total_liquidado
FROM `your_project_id.dataset_id.table_id`
ORDER BY total_liquidado ASC
LIMIT 5

-- 6. Quais são as 5 fontes de recursos com a pior margem bruta?
SELECT
  nome_fonte_recurso,
  (total_arrecadado - total_liquidado) AS margem_bruta
FROM `your_project_id.dataset_id.table_id`
ORDER BY margem_bruta ASC
LIMIT 5

/*OBS: Para responder às perguntas 7 e 8 sobre a média de gastos e arrecadação por fonte de recurso, foi necessário carregar a tabela
bruta sem agrupamento pela coluna Nome Fonte Recurso. A tabela final solicitada inclui as colunas ID Fonte Recurso, Nome Fonte Recurso,
Total Liquidado e Total Arrecadado. Embora essas colunas sejam suficientes para responder as perguntas anteriores, para calcular a 
média de forma precisa, foi essencial incluir a coluna de descrição de receita e despesa durante a análise. Isso se deve ao fato de que,
ao calcular a média por fonte de recurso, é necessário entender a quantidade de registros de receita e despesa associados a cada fonte. 
Se a tabela fosse agrupada apenas por ID Fonte Recurso e Nome Fonte Recurso, não seria possível calcular a média de maneira coerente, 
pois o agrupamento poderia levar a médias incorretas ou a resultados que não refletem a variabilidade dos dados. Portanto, o carregamento 
da tabela sem agrupamento garantiu que os cálculos de média fossem baseados em todos os registros relevantes, permitindo uma análise mais 
precisa e representativa.

-- 7. Qual a média de arrecadação por fonte de recurso? */
SELECT
  nome_fonte_recurso,
  SUM(Arrecadado) / COUNT(receita) AS media_arrecadacao
FROM `your_project_id.dataset_id.table_id`
GROUP BY nome_fonte_recurso

-- 8. Qual a média de gastos por fonte de recurso?
SELECT
  nome_fonte_recurso,
  SUM(Liquidado) / COUNT(despesa) AS media_gastos
FROM `your_project_id.dataset_id.table_id`
GROUP BY nome_fonte_recurso