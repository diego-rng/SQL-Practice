USE linkedin_db
GO

SELECT * FROM vagas WHERE data_expiracao < GETDATE()

UPDATE vagas SET ativa = 0 WHERE data_expiracao < GETDATE()