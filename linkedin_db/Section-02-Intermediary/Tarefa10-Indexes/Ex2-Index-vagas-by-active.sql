create nonclustered index IX_vagas_ativas
ON vagas (empresa_id, data_publicacao) 
WHERE ativa = 1