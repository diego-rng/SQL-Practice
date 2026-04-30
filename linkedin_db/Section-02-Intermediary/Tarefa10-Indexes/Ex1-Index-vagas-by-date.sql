CREATE NONCLUSTERED INDEX IX_vagas_empresa_data 
on vagas (empresa_id, data_publicacao DESC)
include (titulo, modalidade, nivel);