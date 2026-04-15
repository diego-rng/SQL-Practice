select
e.empresa_id,
e.nome,
v.modalidade,
count(v.vaga_id) as total_vagas
from empresas e
join vagas v on e.empresa_id = v.empresa_id
where v.modalidade like '%remoto%' or v.modalidade like '%presencial%' or v.modalidade like '%hibrido%'
group by v.modalidade, e.empresa_id, e.nome