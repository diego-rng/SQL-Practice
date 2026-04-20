with cte as (
    select 
        u.usuario_id as usuario_origem,
        u.nome as nome1,
        u1.usuario_id as usuario_destino,
        u1.nome as nome2,
        1 as nivel
    from usuarios u
        join conexoes c on c.usuario_origem = u.usuario_id 
        join usuarios u1 on c.usuario_destino = u1.usuario_id

    UNION ALL

    select 
        cte.usuario_origem,
        cte.nome1,
        u2.usuario_id as usuario_destino,
        u2.nome as nome2,
        cte.nivel + 1 as nivel
    from cte 
        join conexoes c2 on c2.usuario_origem = cte.usuario_destino
        join usuarios u2 on c2.usuario_destino = u2.usuario_id
    where cte.nivel <= 3
)
select * from cte

option (maxrecursion 4);

