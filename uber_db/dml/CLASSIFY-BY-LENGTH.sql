USE uber_db

SELECT corrida_id, distancia_km,
CASE 
WHEN distancia_km < 5 THEN 'Curta'
WHEN distancia_km < 20 THEN 'Media'
ELSE 'Longa'
END AS classificacao
FROM corridas WHERE status = 'concluida';