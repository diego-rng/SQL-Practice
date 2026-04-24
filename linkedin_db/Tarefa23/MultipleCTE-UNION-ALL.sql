with current_week as (
	select 'users active' as metrica,
		count(distinct u.usuario_id) as valor
		from usuarios u
	join posts p on u.usuario_id = p.usuario_id 
		and p.data_publicacao = getdate() 
	join candidaturas c on u.usuario_id = c.usuario_id
		and c.data_candidatura = getdate()
),
last_week as (
	select 
		count(distinct u1.usuario_id) as valor
	from usuarios u1
	join posts p1 on u1.usuario_id = p1.usuario_id
			and p1.data_publicacao = dateadd(day, -7, getdate())
),
vagas_today as (
	select
		'vagas abertas' as metrica,
		count(distinct vaga_id) as valor
	from vagas 
	where ativa = 1
),
vagas_last_week as (
	select
		count(distinct vaga_id) as valor
	from vagas 
	where ativa = 1 and datediff(day,data_publicacao, getdate()) >= 7
),
cand_this_week as (
	select 
		'candidaturas abertas' as metrica,
		count(distinct candidatura_id) as valor
	from candidaturas
	where datediff(day, data_candidatura, getdate()) <= 7
),
cand_last_week as (
	select
		count(distinct candidatura_id) as valor
	from candidaturas
	where datediff(day, data_candidatura, getdate()) between 8 and 14
),
biggest_sector as (
	select top 1
		concat(s.nome, ' - setor com mais vagas') as metrica,
		count(v.empresa_id) as valor
	from setores s
	join empresas e on e.setor_id = s.setor_id
	join vagas v on e.empresa_id = v.empresa_id
		and v.ativa = 1
	group by s.nome
	order by count(v.empresa_id) desc
),
most_active_user as (
	select top 1
		concat(u.nome, ' - usuario mais ativo') as metrica,
		count(p.usuario_id) as valor
	from usuarios u
	join posts p on p.usuario_id = u.usuario_id
	where month(p.data_publicacao) = month(getdate())
	group by p.usuario_id, u.nome
	order by count(p.usuario_id) desc
),
conversion_rate as (
	select
		'taxa de conversão global' as metrica,
		count(distinct candidatura_id) as valor
	from candidaturas
	where status like '%aprovada%'
		and month(data_atualizacao) = month(getdate()) 
),
general as (
	select count(*) as valor
	from candidaturas
	where month(data_atualizacao) = month(getdate())	
)
select 
	current_week.metrica as metrica, 
	current_week.valor as valor,
	cast(cast(current_week.valor as decimal) / nullif(last_week.valor, 0) * 100.0 as decimal(10,2)) as variacao
from current_week, last_week
union all
select 
	vagas_today.metrica as metrica,
	vagas_today.valor as valor,
	cast(cast(vagas_today.valor as decimal) / nullif(vagas_last_week.valor, 0) * 100.0 as decimal(10,2)) as variacao
from vagas_today, vagas_last_week
union all
select 
	cand_this_week.metrica as metrica,
	cand_this_week.valor as valor,
	cast(cast(cand_this_week.valor as decimal) / nullif(cand_last_week.valor, 0) * 100.0 as decimal(10,2)) as variacao
from cand_last_week, cand_this_week
union all
select 
	metrica,
	valor,
	null as variacao
from biggest_sector
union all
select 
	metrica,
	valor,
	null as variacao
from most_active_user
union all
select
conversion_rate.metrica,
conversion_rate.valor,
cast(cast(conversion_rate.valor as decimal) / nullif(general.valor, 0) * 100.0 as decimal(10,2)) as variacao
from conversion_rate, general