USE uber_db
GO

WITH cte_receita AS (
SELECT c.motorista_id, c.cidade_id,
SUM(c.valor_final) AS receita_total, 
COUNT(*) AS total_corridas
FROM corridas c WHERE c.status = 'concluida'
GROUP BY c.motorista_id, c.cidade_id
),
cte_ranking AS (
SELECT *,
RANK() OVER (PARTITION BY cidade_id
ORDER BY receita_total DESC) AS rank
FROM cte_receita 
)
SELECT m.nome, ci.nome AS cidade,
r.receita_total, r.total_corridas, r.rank
FROM cte_ranking r
JOIN motoristas m ON r.motorista_id = m.motorista_id
JOIN cidades ci ON r.cidade_id = ci.cidade_id
WHERE r.rank <= 3
ORDER BY ci.nome, r.rank