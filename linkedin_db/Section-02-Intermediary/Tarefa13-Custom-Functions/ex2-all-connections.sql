create or alter function fn_conexoes_usuario (@usuario_id INT)
returns table as return (
select * from conexoes where usuario_destino = @usuario_id and status like '%aceita%' or usuario_origem = @usuario_id and status like '%aceita%'
)