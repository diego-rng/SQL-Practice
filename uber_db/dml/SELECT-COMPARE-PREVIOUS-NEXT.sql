USE uber_db
GO

SELECT
usuario_id, corrida_id, data_solicitacao, valor_final,
LAG(valor_final) OVER
(PARTITION BY usuario_id ORDER BY data_solicitacao) AS corrida_anterior,
LEAD(valor_final) OVER
(PARTITION BY usuario_id ORDER BY data_solicitacao) AS proxima_corrida
FROM corridas WHERE status = 'concluida';