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

-- 7. Qual a média de arrecadação por fonte de recurso?
SELECT
  nome_fonte_recurso,
  AVG(total_arrecadado) AS media_arrecadacao
FROM `your_project_id.dataset_id.table_id`
GROUP BY nome_fonte_recurso
ORDER BY media_arrecadacao DESC

-- 8. Qual a média de gastos por fonte de recurso?
SELECT
  nome_fonte_recurso,
  AVG(total_liquidado) AS media_gastos
FROM `your_project_id.dataset_id.table_id`
GROUP BY nome_fonte_recurso
ORDER BY media_gastos DESC