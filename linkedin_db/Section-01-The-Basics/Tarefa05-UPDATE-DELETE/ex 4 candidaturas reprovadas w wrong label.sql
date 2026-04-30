USE linkedin_db
GO

UPDATE candidaturas 
SET status = 'reprovada'
WHERE vaga_id IN (
SELECT c.vaga_id
FROM candidaturas c
JOIN vagas v ON c.vaga_id = v.vaga_id
WHERE v.ativa = 0 
	AND (
		c.status LIKE '%enviada%' 
		OR c.status LIKE '%em_revisao%'
		)
)