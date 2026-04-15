create or alter function fn_vagas_recomendadas (@usuario_id INT) 
returns table as return (
select v.vaga_id,
count(u.usuario_id) as hab_comuns
from vaga_habilidades v
join usuario_habilidades u on u.habilidade_id = v.habilidade_id
where u.usuario_id = @usuario_id
group by v.vaga_id
having count(u.usuario_id) >= 2
)
