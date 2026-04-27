select 
    coalesce(e.nome, 'total') as empresa,
    count(c.candidatura_id) as cand_count
from empresas e 
    join vagas v on e.empresa_id = v.empresa_id
    join candidaturas c on c.vaga_id = v.vaga_id
group by rollup(e.nome) 
