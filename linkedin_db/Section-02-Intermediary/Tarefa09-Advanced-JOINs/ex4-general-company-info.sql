select e.nome,
s.nome,
count(distinct v.vaga_id) as total_vagas,
count(distinct c.candidatura_id) as total_candidaturas,
cast(count(case when c.status like '%aprovada%' then 1 end) * 1.0 as float) / nullif(count(c.candidatura_id), 0) as taxa_conversao
from empresas e
join setores s on s.setor_id = e.setor_id
join vagas v on v.empresa_id = e.empresa_id
join candidaturas c on v.vaga_id = c.vaga_id
group by e.nome, s.nome		
