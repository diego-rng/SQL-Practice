USE uber_db
GO

SELECT * FROM dbo.fn_historico_usuario(5)
ORDER BY data_solicitacao DESC;