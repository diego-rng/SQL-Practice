with original as (
    SELECT
        u.usuario_id,
        p.data_publicacao,
        datediff(day, 
            lag(p.data_publicacao) over (partition by u.usuario_id order by p.data_publicacao), 
            p.data_publicacao
        ) as time_since_last_post 
    from usuarios u 
    join posts p on u.usuario_id = p.usuario_id
) 
select 
    usuario_id,
    avg(time_since_last_post) as user_avg
from original
group by usuario_id
having avg(time_since_last_post) >= 30