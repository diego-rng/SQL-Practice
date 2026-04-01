USE uber_db

CREATE NONCLUSTERED INDEX IX_corridas_usuario_data
ON corridas (usuario_id, data_solicitacao DESC)
include (status, valor_final, motorista_id);

