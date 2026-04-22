with cte as ( 
select 
	u.usuario_id,
	(select count(*) from conexoes ci where ci.status like '%aceita%' and (ci.usuario_destino = u.usuario_id or ci.usuario_origem = u.usuario_id)) as conexoes_aceitas,
	(select count(*) from posts pi where pi.usuario_id = u.usuario_id) as posts_proprios,
	(select count(*) from curtidas cri join posts pri on pri.post_id = cri.post_id where pri.usuario_id = u.usuario_id) as curtidas_recebidas
from usuarios u
	join conexoes c on u.usuario_id = c.usuario_origem or u.usuario_id = c.usuario_destino
	join posts p on p.usuario_id = u.usuario_id
	join curtidas cr on cr.post_id = p.post_id
)
select top 5
	cte.usuario_id,
	u.nome,
	((conexoes_aceitas * 2) + (posts_proprios * 3) + (curtidas_recebidas * 1)) as influencia
from cte
	join usuarios u on cte.usuario_id = u.usuario_id
group by cte.usuario_id, u.nome, conexoes_aceitas, posts_proprios, curtidas_recebidas
order by influencia desc