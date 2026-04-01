USE linkedin_db
GO

SELECT * FROM empresas WHERE nome LIKE '%tech%' AND setor_id = 1 OR nome LIKE '%digital%' AND setor_id = 1