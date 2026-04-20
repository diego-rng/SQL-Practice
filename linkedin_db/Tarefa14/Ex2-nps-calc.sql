select distinct 
    s.setor_id,
    s.nome,
    cast(((cast(
    (select 
        count(*) 
    from candidaturas c 
        join vagas v on v.vaga_id = c.vaga_id 
        join empresas e on e.empresa_id = v.empresa_id 
    where status like '%aprovada%'
        and e.setor_id = s.setor_id) 
    as decimal
    ) * 100) - (cast((
    select 
       count(*) 
    from candidaturas c 
        join vagas v on v.vaga_id = c.vaga_id
        join empresas e on e.empresa_id = v.empresa_id
    where status like '%reprovada%' 
        and e.setor_id = s.setor_id)
    as decimal
    ) * 100))
    / 100 as decimal(10,1)
) as nps
from candidaturas c
    join vagas v on c.vaga_id = v.vaga_id
    join empresas e on e.empresa_id = v.empresa_id
    join setores s on s.setor_id = e.setor_id
where c.status like '%aprovada%' or c.status like '%reprovada%'


