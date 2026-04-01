USE uber_db;

CREATE TABLE motoristas (
motorista_id INT IDENTITY(1, 1) PRIMARY KEY,
nome NVARCHAR(120) NOT NULL,
email VARCHAR(180) NOT NULL,
cnh VARCHAR(20) NOT NULL,
data_cadastro DATETIME2 NOT NULL DEFAULT(GETDATE()),
avaliacao_media DECIMAL(3,2) NULL,
ativo BIT NOT NULL DEFAULT (1),
cidade_id INT NOT NULL

CONSTRAINT uq_motorista_email UNIQUE (email),
CONSTRAINT uq_motorista_cnh UNIQUE (cnh),
CONSTRAINT fk_motorista_cidade 
	FOREIGN KEY (cidade_id)
	REFERENCES cidades(cidade_id)
);

