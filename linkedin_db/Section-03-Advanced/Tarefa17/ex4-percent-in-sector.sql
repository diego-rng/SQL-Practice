with original as (
    SELECT DISTINCT
        s.nome AS setor,
        SUM(COUNT(v.vaga_id)) OVER (PARTITION BY s.setor_id) AS total_vagas_setor,
        (select count(*) from vagas) as total
    FROM setores s
        JOIN empresas e ON s.setor_id = e.setor_id
        JOIN vagas v ON e.empresa_id = v.empresa_id
    GROUP BY
        s.setor_id, s.nome,
        e.empresa_id, e.nome,
        v.vaga_id)
select
    setor,
    cast((cast(total_vagas_setor as decimal) / total) * 100.0 as decimal(10,2)) as percentage
from original