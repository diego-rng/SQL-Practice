USE uber_db

SELECT motorista_id, nome, avaliacao_media 
FROM motoristas
WHERE motorista_id IN (
SELECT c.motorista_id
FROM avaliacoes a
JOIN corridas c ON a.corrida_id = c.corrida_id
WHERE a.avaliador_tipo = 'usuario'
GROUP BY c.motorista_id
HAVING AVG(CAST(a.nota AS FLOAT)) < 4.0
);