create or alter view vw_perfil_completo as (
select 
	u.nome,
	u.email,
	u.titulo_perfil, 
	u.cidade,
	(select count(*) from conexoes ci where ci.status like '%aceita%' and (ci.usuario_destino = u.usuario_id or ci.usuario_origem = u.usuario_id)) as conexoes_aceitas,
	(select count(*) from posts pi where pi.usuario_id = u.usuario_id) as qt_posts,
	(select count(*) from curtidas cri join posts pri on pri.post_id = cri.post_id where pri.usuario_id = u.usuario_id) as curtidas_recebidas,
	(select dbo.fn_score_perfil(u.usuario_id)) as user_score,
	(select STRING_AGG(h.nome, ', ') from usuario_habilidades uh join habilidades h on uh.habilidade_id = h.habilidade_id where uh.usuario_id = u.usuario_id) as habilidades
from usuarios u)