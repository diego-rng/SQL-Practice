USE uber_db
GO

SELECT 
ISNULL(ci.nome, '** TOTAL GERAL') AS cidade,
COUNT(*) AS total_corridas,
SUM(c.valor_final) as receita
FROM corridas c
JOIN cidades ci ON c.cidade_id = ci.cidade_id
WHERE c.status = 'concluida'
GROUP BY ROLLUP(ci.nome);