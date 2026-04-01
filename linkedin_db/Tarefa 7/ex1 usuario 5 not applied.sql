SELECT vaga_id, titulo, cidade, modalidade, ativa
FROM vagas
WHERE vaga_id NOT IN (
SELECT vaga_id
FROM candidaturas 
WHERE usuario_id = 5)