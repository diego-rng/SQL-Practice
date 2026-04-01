USE uber_db

CREATE NONCLUSTERED INDEX IX_corridas_cidade_status
ON corridas (cidade_id, status)
INCLUDE (valor_final, data_solicitacao);

