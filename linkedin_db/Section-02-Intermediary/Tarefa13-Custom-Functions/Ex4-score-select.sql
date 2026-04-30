select top 10
usuario_id,
dbo.fn_score_perfil(usuario_id) as score
from usuarios 
group by usuario_id 
order by score desc