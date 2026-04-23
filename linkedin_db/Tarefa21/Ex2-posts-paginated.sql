select 
u.nome,
p.conteudo, 
p.data_publicacao,
p.visualizacoes
from posts p
join usuarios u on u.usuario_id = p.usuario_id
order by visualizacoes desc
offset 0 rows 
fetch next 20 rows only;