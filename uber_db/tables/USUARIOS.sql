USE uber_db;

CREATE TABLE usuarios (
usuario_id INT IDENTITY(1, 1) PRIMARY KEY,
nome NVARCHAR(120) NOT NULL,
email VARCHAR(180) NOT NULL,
telefone VARCHAR(20) NOT NULL,
data_cadastro DATETIME2 NOT NULL DEFAULT(GETDATE()),
ativo BIT NOT NULL DEFAULT (1),
cidade_id INT NOT NULL

CONSTRAINT uq_usuario_email UNIQUE (email),
CONSTRAINT fk_usuario_cidade 
	FOREIGN KEY (cidade_id)
	REFERENCES cidades(cidade_id)
);

