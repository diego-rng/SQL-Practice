USE uber_db
GO

DECLARE @id INT;
EXEC sp_iniciar_corrida
@usuario_id = 1, @motorista_id = 3, @veiculo_id = 3,
@cidade_id = 1, @origem = 'Av. Paulista, 1000',
@destino = 'Aeroporto de Congonhas',
@nova_corrida_id = @id OUTPUT;
SELECT @id AS corrida_criada;