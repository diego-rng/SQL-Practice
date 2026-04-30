with original as (select 
	nome,
	data_cadastro,
	month(data_cadastro) as mes,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 0 and 30
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 0 and 30) 
	as count1,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 31 and 60
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 31 and 60) 
	as count2,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 61 and 90
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 91 and 120) 
	as count3,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 121 and 150
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 121 and 150) 
	as count4,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 151 and 180
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 151 and 180) 
	as count5,
	(
	select 
		count(*) 
	from posts p 
	where
		u.usuario_id = p.usuario_id 
		and datediff(day, u.data_cadastro, p.data_publicacao) between 181 and 210
	) + (
	select 
		count(*) 
	from candidaturas c 
	where 
		u.usuario_id = c.usuario_id 
		and datediff(day, u.data_cadastro,c.data_candidatura) between 181 and 210) 
	as count6
from usuarios u
where ativo = 1
)

select 
	mes,
	cast((cast(((select count(distinct usuario_id) from candidaturas where month(data_cadastro) = mes) + (select count(distinct usuario_id) from posts where month(data_cadastro) = mes)) as decimal) / nullif(count1, 0))as decimal(10,2))
from original
group by mes, data_cadastro, count1
order by mes