USE uber_db
GO

SELECT
ci.nome AS cidade,
m.nome AS motorista,
SUM(c.valor_final) AS receita,
RANK() OVER (PARTITION BY ci.nome
ORDER BY SYM(c.valor_final) DESC) AS rank_cidade,
ROW_NUMBER() OVER (PARTITION BY ci.nome
ORDER BY SUM(c.valor_final) DESC) AS row_num
FROM corridas c
JOIN motoristas m ON c.motorista_id = m.motorista_id
JOIN cidades ci on c.cidade_id = ci.cidade_id
WHERE c.status = 'concluida'
GROUP BY ci.nome, m.nome, m.motorista_id;