select top 10
DENSE_RANK() over (partition by p.ativo order by count(c.post_id) desc) as rank,
p.usuario_id,
count(p.usuario_id) as like_count
from posts p 
join usuarios u on u.usuario_id = p.usuario_id
join curtidas c on p.post_id = c.post_id
group by p.usuario_id, c.post_id, p.ativo
