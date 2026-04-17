USE linkedin_db
GO

SELECT titulo, 
e.nome, 
s.nome AS setor, 
e.cidade, 
v.modalidade, 
v.nivel, 
CONCAT('R$', CAST(v.salario_min AS DECIMAL(10,2)), ' - R$', CAST(v.salario_max AS DECIMAL(10,2))) AS faixa_salarial
FROM vagas v
INNER JOIN empresas e ON v.empresa_id = e.empresa_id
INNER JOIN setores s ON e.setor_id = s.setor_id
WHERE v.ativa = 1