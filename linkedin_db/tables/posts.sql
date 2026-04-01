USE linkedin_db
GO

CREATE TABLE posts ( 
post_id INT IDENTITY(1,1) PRIMARY KEY,
usuario_id INT NOT NULL,
conteudo NVARCHAR(3000) NOT NULL,
tipo VARCHAR(20) DEFAULT('texto'),
data_publicacao DATETIME2 DEFAULT(GETDATE()),
visualizacoes INT DEFAULT(0),
ativo BIT DEFAULT(1)

CONSTRAINT fk_usuario_id_post
	FOREIGN KEY (usuario_id)
		REFERENCES usuarios(usuario_id)
)