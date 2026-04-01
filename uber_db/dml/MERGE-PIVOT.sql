USE uber_db
GO

MERGE motoristas AS alvo 
USING (
SELECT c.motorista_id,
AVG(CAST(a.nota AS DECIMAL(3,2))) AS nova_media
FROM avaliacoes a 
JOIN corridas c ON a.corrida_id = c.corrida_id
WHERE a.avaliador_tipo = 'usuario'
GROUP BY c.motorista_id
) AS origem ON (alvo.motorista_id = origem.motorista_id)
WHEN MATCHED THEN 
UPDATE SET alvo.avaliacao_media = origem.nova_media;

--SELECT cidade_id, UberX, UberBlack, UberComfort, Moto
--FROM (
--SELECT c.cidade_id, v.categoria
--FROM corridas c
--JOIN veiculos v ON c.veiculo_id = v.veiculo_id
--WHERE c.status = 'concluida'
--) AS dados
--PIVOT ( 
--COUNT(categoria)
--FOR categoria IN ( [UberX], [UberBlack], [UberComfort], [Moto] )
--) AS pvt;