-- 4. Liste empresas com mais vagas abertas que a media geral de vagas por empresa.

SELECT e.empresa_id, nome, setor_id, e.cidade, pais,
COUNT(v.empresa_id) AS numero_vagas
FROM empresas e
LEFT JOIN vagas v ON v.empresa_id = e.empresa_id
GROUP BY e.empresa_id, nome, setor_id, e.cidade, pais
HAVING COUNT(v.empresa_id) > (SELECT result FROM vw_avg_count)
