USE uber_db;

--SELECT * FROM corridas WHERE status = 'concluida';

SELECT TOP 10
corrida_id, 
valor_final,
distancia_km,
ROUND (valor_final / NULLIF(distancia_km, 0), 2) AS preco_por_km
FROM corridas
WHERE status = 'concluida'
ORDER BY valor_final DESC;

--SELECT corrida_id, usuario_id, motorista_id, valor_final
--FROM corridas
--ORDER BY data_solicitacao DESC
--OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY;