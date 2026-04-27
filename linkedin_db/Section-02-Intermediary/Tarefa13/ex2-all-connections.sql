create or alter function fn_conexoes_usuario (@usuario_id INT)
returns table as return (
select * from conexoes where usuario_destino = @usuario_id or usuario_origem = @usuario_id
)