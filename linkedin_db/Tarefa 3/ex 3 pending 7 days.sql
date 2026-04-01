USE linkedin_db
GO

SELECT * 
FROM conexoes 
WHERE DATEDIFF(day, data_solicitacao, GETDATE()) >= 7 
AND status = 'pendente' 
AND data_resposta IS NULL