USE linkedin_db
GO

SELECT * 
FROM posts
WHERE visualizacoes >= 100
ORDER BY visualizacoes DESC