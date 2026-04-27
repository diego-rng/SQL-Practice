select u.nome,
count(c.usuario_origem) as conexoes
from usuarios u 
join conexoes c on u.usuario_id = c.usuario_origem
group by u.nome