SELECT u.nome,
u.email,
u.titulo_perfil,
v.titulo,
e.nome,
s.nome,
e.cidade,
v.modalidade,
v.nivel,
c.status,
c.data_candidatura
FROM candidaturas c 
JOIN usuarios u ON u.usuario_id = c.usuario_id
JOIN vagas v ON v.vaga_id = c.vaga_id
JOIN empresas e ON e.empresa_id = v.empresa_id
JOIN setores s ON s.setor_id = e.setor_id