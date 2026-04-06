USE linkedin_db
GO

UPDATE posts 
SET visualizacoes = visualizacoes + 1 
WHERE DATEDIFF(DAY, data_publicacao, GETDATE()) > 30 
AND post_id IN (
SELECT p.post_id
FROM posts p
JOIN curtidas c ON c.post_id = p.post_id
GROUP BY p.post_id
HAVING COUNT(c.post_id) >= 1
)