select setor, aprovada, reprovada, ativa
from (
select s.nome as setor,
c.status
from candidaturas c 
join vagas v on v.vaga_id = c.vaga_id
join empresas e on e.empresa_id = v.empresa_id
join setores s on s.setor_id = e.setor_id
)
as data
pivot (
count(status)
for status in ([aprovada], [reprovada], [ativa])
) as pvt