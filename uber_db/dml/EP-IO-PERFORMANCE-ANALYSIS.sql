USE uber_db

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- SELECT * FROM corridas WHERE status = 'concluida' AND cidade_id = 1;

CREATE NONCLUSTERED INDEX IX_corridas_status_cidade
ON corridas (status, cidade_id);
SELECT * FROM corridas WHERE status = 'concluida' AND cidade_id = 1;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

SELECT OBJECT_NAME(i.object_id) AS tabela,
i.name AS indice, 
s.user_seeks, s.user_scans, s.user_lookups, s.user_updates
FROM sys.indexes i 
LEFT JOIN sys.dm_db_index_usage_stats s
ON i.object_id = s.object_id AND i.index_id = s.index_id
WHERE OBJECT_NAME(i.object_id) = 'corridas'
ORDER BY ISNULL(s.user_seeks,0) DESC;
