create nonclustered index IX_cand_usuario 
on candidaturas(usuario_id, status)
include (vaga_id, data_candidatura)