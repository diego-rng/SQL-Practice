USE uber_db

--UPDATE motoristas
--SET ativo = 0 
--WHERE motorista_id = 7;

UPDATE m
SET m.avaliacao_media = sub.media
FROM motoristas m 
JOIN (
SELECT c.motorista_id,
AVG(CAST(a.nota AS DECIMAL(3,2))) AS media
FROM avaliacoes a 
JOIN corridas c ON a.corrida_id = c.corrida_id
WHERE a.avaliador_tipo = 'usuario'
GROUP BY c.motorista_id
) sub ON m.motorista_id = sub.motorista_id;

--SELECT * FROM promocoes
--WHERE validade < CAST(GETDATE() AS DATE)
--AND usos_realizados = 0;
--DELETE FROM promocoes
--WHERE validade < CAST(GETDATE() AS DATE)
--AND usos_realizados = 0;