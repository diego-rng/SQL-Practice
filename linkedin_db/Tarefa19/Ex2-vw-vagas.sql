create or alter view vw_vagas_completas as (
select 
v.titulo,
e.nome as nome_empresa,
s.nome as setor,
e.cidade,
v.modalidade,
v.nivel,
concat(v.salario_min, ' - ', v.salario_max) as faixa_salarial,
datediff(day, v.data_publicacao, getdate()) as dias_desde_publicacao,
(select count(*) from candidaturas c where c.vaga_id = v.vaga_id) as total_candidaturas
from vagas v
join empresas e on v.empresa_id = e.empresa_id
join setores s on s.setor_id = e.setor_id
)