USE uber_db

CREATE NONCLUSTERED INDEX IX_corridas_ativas
ON corridas(motorista_id, data_solicitacao)
WHERE status IN ('aceita', 'em andamento');
