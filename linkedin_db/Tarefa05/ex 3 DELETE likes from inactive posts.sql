USE linkedin_db
GO

DELETE FROM curtidas 
WHERE curtida_id IN (
SELECT curtida_id
FROM curtidas c
JOIN posts p ON c.post_id = p.post_id
WHERE p.ativo = 0
)