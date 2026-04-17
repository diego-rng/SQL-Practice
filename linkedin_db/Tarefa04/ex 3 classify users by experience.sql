USE linkedin_db
GO

SELECT u.usuario_id, 
nome,
COUNT(h.usuario_id) AS count,
CASE
	WHEN COUNT(h.usuario_id) > 1 AND COUNT(h.usuario_id) < 4
	THEN 'Em Crescimento'
	WHEN COUNT(h.usuario_id) >= 4 
	THEN 'Experiente'
	ELSE 'Iniciante'
	END AS experiencia
FROM usuarios u
JOIN usuario_habilidades h ON u.usuario_id = h.usuario_id
GROUP BY 
u.usuario_id,
u.nome;