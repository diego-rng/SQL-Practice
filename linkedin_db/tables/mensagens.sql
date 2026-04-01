USE linkedin_db
GO

CREATE TABLE mensagens (
mensagem_id INT IDENTITY(1,1) PRIMARY KEY,
remetente_id INT NOT NULL,
destinatario_id INT NOT NULL,
conteudo NVARCHAR(1000) NULL,
data_envio DATETIME2 DEFAULT(GETDATE()),
lida BIT DEFAULT(0)

CONSTRAINT fk_remetente_id
	FOREIGN KEY (remetente_id)
		REFERENCES usuarios(usuario_id),

CONSTRAINT fk_destinatario_id
	FOREIGN KEY (destinatario_id)
		REFERENCES usuarios(usuario_id)

)