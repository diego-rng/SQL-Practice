USE uber_db
GO

SELECT 
ci.nome AS cidade,
YEAR(c.data_fim) AS ano,
MONTH(c.data_fim) AS mes,
COUNT(*) AS total_corridas,
SUM(c.valor_final) AS receita_total,
AVG(c.valor_final) AS ticket_medio,
MAX(c.valor_final) AS corrida_mais_cara,
COUNT(DISTINCT c.motorista_id) AS motoristas_ativos
FROM corridas c
JOIN cidades ci ON c.cidade_id = ci.cidade_id
WHERE c.status = 'concluida'
GROUP BY ci.nome, YEAR(c.data_fim), MONTH(c.data_fim)
HAVING SUM(c.valor_final) > 1000
ORDER BY ano DESC, mes DESC, receita_total DESC;