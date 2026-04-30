USE linkedin_db 
GO

CREATE TABLE usuario_habilidades (
usuario_id INT NOT NULL,
habilidade_id INT NOT NULL,
PRIMARY KEY (usuario_id, habilidade_id),
nivel VARCHAR(20) NOT NULL,

CONSTRAINT pk_fk_usuario_id
	FOREIGN KEY (usuario_id)
		REFERENCES usuarios(usuario_id),

CONSTRAINT pk_fk_habilidade_id
	FOREIGN KEY (habilidade_id)
		REFERENCES habilidades(habilidade_id)
)