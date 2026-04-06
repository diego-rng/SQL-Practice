SELECT u.nome, 
em.nome,
e.data_inicio,
e.data_fim 
FROM usuarios u
JOIN candidaturas c ON u.usuario_id = c.usuario_id
JOIN vagas v ON v.vaga_id = c.vaga_id
JOIN experiencias e ON e.empresa_id = v.empresa_id
JOIN empresas em ON em.empresa_id = e.empresa_id
