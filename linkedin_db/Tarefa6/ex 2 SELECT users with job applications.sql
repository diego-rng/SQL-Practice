SELECT u.nome, 
v.titulo, 
e.nome,
c.status,
c.data_candidatura
FROM usuarios u
JOIN candidaturas c ON u.usuario_id = c.usuario_id
JOIN vagas v ON c.vaga_id = v.vaga_id
JOIN empresas e ON v.empresa_id = e.empresa_id
