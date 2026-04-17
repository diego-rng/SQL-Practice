SELECT usuario_id, nome, email, titulo_perfil, ativo, 
SUM(
CASE
	WHEN c.status = 'aceita'
	THEN 1
	ELSE 0
	END
)AS conexoes_aceitas
FROM usuarios u
JOIN conexoes c ON u.usuario_id = c.usuario_origem
GROUP BY usuario_id, nome, email, titulo_perfil, ativo