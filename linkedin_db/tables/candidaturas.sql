USE linkedin_db
GO

CREATE TABLE candidaturas (
candidatura_id INT IDENTITY(1,1) PRIMARY KEY,
usuario_id INT NOT NULL,
vaga_id INT NOT NULL, 
status VARCHAR(25) DEFAULT('enviada'),
data_candidatura DATETIME2 DEFAULT(GETDATE()),
data_atualizacao DATETIME2 NULL,
carta_apresentacao NVARCHAR(2000) NULL

CONSTRAINT fk_usuario_id_cand
	FOREIGN KEY (usuario_id)
		REFERENCES usuarios(usuario_id),

CONSTRAINT fk_vaga_id 
	FOREIGN KEY (vaga_id)
		REFERENCES vagas(vaga_id)
)