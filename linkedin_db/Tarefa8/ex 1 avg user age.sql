SELECT 
SUM(idade) as dias_totais,
COUNT(usuario_id) as user_count,
(SUM(idade) / COUNT(usuario_id)) AS result
FROM vw_user_ages