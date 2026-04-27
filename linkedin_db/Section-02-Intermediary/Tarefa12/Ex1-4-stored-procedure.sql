create or alter procedure sp_registrar_candidatura
	@usuario_id INT,
	@vaga_id INT,
	@carta NVARCHAR(2000),
	@candidatura_id INT OUTPUT
as 
begin
	set nocount on

	begin try
		begin transaction

			if not exists (select usuario_id from usuarios where usuario_id = @usuario_id and ativo = 1)
				throw 50010, 'User does not exist or is not currently active.', 1;
		
			if not exists (select vaga_id from vagas where vaga_id = @vaga_id and ativa = 1)
				throw 50011, 'Opening does not exist or is not currently active.', 1;
			
			if exists (select candidatura_id from candidaturas where @candidatura_id = candidatura_id)
				throw 50012, 'Server error: Application ID already exists', 1

			if exists (select vaga_id from vagas where vaga_id = @vaga_id and data_expiracao <= getdate())
				throw 50013, 'Opening has expired.', 1;

			insert into candidaturas (
			usuario_id, vaga_id, carta_apresentacao, data_candidatura)
			values (
			@usuario_id, @vaga_id, @carta, getdate())
				
			set @candidatura_id = scope_identity()

		commit transaction;
	end try
	begin catch 
		if @@trancount > 0 rollback transaction;
		throw
	end catch
	end
