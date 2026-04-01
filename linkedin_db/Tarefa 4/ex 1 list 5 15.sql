USE linkedin_db
GO

SELECT * 
FROM vagas 
WHERE salario_min >= 5000
AND salario_max <= 15000
AND (modalidade = 'remoto') 
AND (nivel IN ('senior', 'pleno'))

