create or alter function fn_score_perfil
	(@usuario_id INT) 
returns int
as

begin 
	declare @user_score int = 0

	if exists (select usuario_id from usuario_habilidades where usuario_id = @usuario_id)
		set @user_score = @user_score + ((select count(usuario_id) from usuario_habilidades where usuario_id = @usuario_id) * 10)
			
	if exists (select usuario_id from experiencias where usuario_id = @usuario_id)
		set @user_score = @user_score + ((select count(usuario_id) from experiencias where usuario_id = @usuario_id) * 15)

	if exists (select usuario_origem from conexoes where usuario_origem = @usuario_id and status like '%aceita%')
		set @user_score = @user_score + ((select count(usuario_origem) from conexoes where usuario_origem = @usuario_id and status like '%aceita%') * 5)

	if exists (select usuario_destino from conexoes where usuario_destino = @usuario_id and status like '%aceita%') 
		set @user_score = @user_score + ((select count(usuario_destino) from conexoes where usuario_destino = @usuario_id and status like '%aceita%') * 5)

	if (select premium from usuarios where usuario_id = @usuario_id) = 1
		set @user_score = @user_score + 20

return @user_score 
end
	