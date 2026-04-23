with cte as (
	select 
	c1.usuario_origem as usuario,
	c2.usuario_destino as conexao
	from conexoes c1 
	join conexoes c2 on c1.usuario_destino = c2.usuario_origem
)
select distinct
	count(*) as count_2g,
	cte.usuario,
	cte.conexao,
	(
	select count(*) 
	from usuarios u
		where u.ativo = 1 
		and (u.usuario_id = cte.usuario or u.usuario_id = cte.conexao)
	) as premium
from cte
group by cte.usuario, cte.conexao
order by cte.usuario asc