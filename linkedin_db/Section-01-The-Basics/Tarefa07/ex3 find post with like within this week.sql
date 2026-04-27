SELECT p.post_id, conteudo, data_publicacao, ativo,
COUNT(c.post_id) AS curtidas
FROM posts p
JOIN curtidas c ON c.post_id = p.post_id
WHERE DATEDIFF(DAY, data_publicacao, GETDATE()) <= 7
GROUP BY p.post_id, conteudo, data_publicacao, ativo, c.post_id
HAVING COUNT(c.post_id) >= 3
