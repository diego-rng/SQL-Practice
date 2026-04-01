USE uber_db
GO

CREATE OR ALTER PROCEDURE sp_iniciar_corrida
@usuario_id INT, @motorista_id INT, @veiculo_id INT, 
@cidade_id INT, @origem NVARCHAR(200), @destino NVARCHAR(200), 
@nova_corrida_id INT OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
BEGIN TRANSACTION;

IF NOT EXISTS (
	SELECT 1 FROM motoristas
	WHERE motorista_id = @motorista_id AND ativo = 1)
THROW 50001, 'Motorista inativo ou nao encontrado.', 1;

IF NOT EXISTS ( 
	SELECT 1 FROM veiculos 
	WHERE veiculo_id = @veiculo_id
	AND  motorista_id = @motorista_id AND ativo = 1)
THROW 50002, 'Veiculo nao associado ao motorista.', 1;

INSERT INTO corridas (
	usuario_id, motorista_id, veiculo_id, cidade_id,
	status, origem_endereco, destino_endereco)
VALUES (
	@usuario_id, @motorista_id, @veiculo_id, @cidade_id,
	'aceita', @origem, @destino);
SET @nova_corrida_id = SCOPE_IDENTITY();
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
THROW;
END CATCH
END;