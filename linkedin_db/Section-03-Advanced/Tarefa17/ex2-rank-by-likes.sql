SELECT TOP 10
    DENSE_RANK() OVER (ORDER BY COUNT(c.post_id) DESC) AS rank,
    p.usuario_id,
    COUNT(c.post_id) AS like_count
FROM posts p
JOIN usuarios u ON u.usuario_id = p.usuario_id
JOIN curtidas c ON p.post_id = c.post_id
WHERE datediff(day, c.data_curtida, getdate()) <= 30 
GROUP BY p.usuario_id
ORDER BY like_count DESC