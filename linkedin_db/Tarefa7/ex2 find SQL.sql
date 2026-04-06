SELECT * 
FROM usuarios u
JOIN usuario_habilidades h ON u.usuario_id = h.usuario_id AND h.habilidade_id = 3	 
WHERE u.usuario_id IN (
SELECT usuario_id 
FROM usuario_habilidades
WHERE habilidade_id = 3 AND nivel LIKE '%Avançado%' OR habilidade_id = 3 AND nivel LIKE '%especialista%')