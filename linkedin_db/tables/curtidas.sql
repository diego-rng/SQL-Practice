USE linkedin_db
GO

CREATE TABLE curtidas (
curtida_id INT IDENTITY(1,1) PRIMARY KEY,
post_id INT NOT NULL,
usuario_id INT NOT NULL,
reacao VARCHAR(15) DEFAULT('curtir'),
data_curtida DATETIME2 DEFAULT(GETDATE())

CONSTRAINT fk_post_id
	FOREIGN KEY (post_id)
		REFERENCES posts(post_id),

CONSTRAINT fk_usuario_id_curt
	FOREIGN KEY (usuario_id)
		REFERENCES usuarios(usuario_id)
)
