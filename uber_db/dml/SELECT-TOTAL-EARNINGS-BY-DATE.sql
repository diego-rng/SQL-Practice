USE uber_db
GO

SELECT 
CAST(data_fim AS DATE) AS data,
SUM(valor_final) AS receita_dia,
SUM(SUM(valor_final)) OVER (ORDER BY CAST(data_fim AS DATE))
AS receita_acumulada
FROM corridas WHERE status = 'concluida'
GROUP BY CAST(data_fim AS DATE)
ORDER BY data;
