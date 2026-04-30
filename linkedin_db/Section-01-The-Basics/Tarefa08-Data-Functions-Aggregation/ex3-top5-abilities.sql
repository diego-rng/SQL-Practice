SELECT TOP 5
h.nome,
COUNT(uh.habilidade_id) AS qt_ass,
ROUND(
CAST(
(COUNT(uh.habilidade_id) * 100.0 / 
(SELECT COUNT(*) 
FROM usuario_habilidades)) AS FLOAT), 2)
as porcentagem
FROM habilidades h
JOIN usuario_habilidades uh ON h.habilidade_id = uh.habilidade_id
JOIN usuarios u ON u.usuario_id = uh.usuario_id
GROUP BY h.nome
ORDER BY COUNT(uh.habilidade_id) DESC
