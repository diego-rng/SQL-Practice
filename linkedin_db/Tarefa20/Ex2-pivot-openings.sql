select empresa, remoto, presencial, hibrido from
(select 
e.nome as empresa, 
v.modalidade
from vagas v
join empresas e on v.empresa_id = e.empresa_id
) as data
pivot (
count(modalidade)
for modalidade in ([remoto], [presencial], [hibrido])
) as pvt;