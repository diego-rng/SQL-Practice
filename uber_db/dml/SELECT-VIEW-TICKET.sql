USE uber_db
GO

SELECT cidade, categoria, AVG(valor_final) AS ticket_medio
FROM vw_corridas_completas
WHERE status = 'concluida'
GROUP BY cidade, categoria;