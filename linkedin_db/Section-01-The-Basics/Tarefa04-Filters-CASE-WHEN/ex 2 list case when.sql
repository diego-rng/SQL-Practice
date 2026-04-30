USE linkedin_db
GO

SELECT salario_min, salario_max,
CASE 
	WHEN salario_max > 20000
	THEN 'Huge End'
	WHEN salario_max < 5000
	THEN 'Low End'
	WHEN salario_min > 5000 AND salario_max < 10000
	THEN 'Middle End'
	WHEN salario_min > 10000 AND salario_max < 20000
	THEN 'High End'
	WHEN salario_max IS NULL
	THEN 'No earnings'
	END AS earnings	
FROM vagas