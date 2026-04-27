select
    e.nome,
    c.data_candidatura,
    count(*) as cand_on_day,
    sum(count(*)) over (
        partition by e.empresa_id
        order by c.data_candidatura
    ) as total_now
from candidaturas c
    join vagas v on c.vaga_id = v.vaga_id
    join empresas e on e.empresa_id = v.empresa_id
group by e.empresa_id, e.nome, c.data_candidatura