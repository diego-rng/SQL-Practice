SELECT * 
FROM empresas e
LEFT JOIN vagas v ON e.empresa_id = v.empresa_id
WHERE v.empresa_id IS NULL