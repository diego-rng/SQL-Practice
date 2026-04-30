USE linkedin_db
GO

CREATE TABLE comentarios (
comentario_id INT IDENTITY(1,1) PRIMARY KEY,
post_id INT NOT NULL,
usuario_id INT NOT NULL,
conteudo NVARCHAR(1000) NOT NULL,
data_comentario DATETIME2 DEFAULT(GETDATE())

CONSTRAINT fk_post_id_com
	FOREIGN KEY (post_id)
		REFERENCES posts(post_id),

CONSTRAINT fk_usuario_id_com
	FOREIGN KEY (usuario_id)
		REFERENCES usuarios(usuario_id)
)