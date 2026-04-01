USE linkedin_db
GO

SELECT *
FROM usuarios u
WHERE NOT EXISTS (
SELECT *
FROM usuario_habilidades h
WHERE u.usuario_id = h.usuario_id
)
