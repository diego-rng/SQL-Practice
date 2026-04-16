with base as (
	select 
		data_publicacao,
		DATEPART(HOUR, data_publicacao) as horario
	from vagas  
)
select top 5
	horario,
	count(horario) as count
from base
group by horario
order by count desc
