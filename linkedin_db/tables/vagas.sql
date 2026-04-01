USE linkedin_db
GO

CREATE TABLE vagas (
vaga_id INT IDENTITY(1,1) PRIMARY KEY,
empresa_id INT NOT NULL,
titulo NVARCHAR(200) NOT NULL,
descricao NVARCHAR(MAX) NULL,
cidade NVARCHAR(100) NOT NULL,
modalidade VARCHAR(20) NOT NULL,
nivel VARCHAR(20) NOT NULL,
salario_min DECIMAL(10,2) NULL,
salario_max DECIMAL(10,2) NULL,
data_publicacao DATETIME2 DEFAULT(GETDATE()),
data_expiracao DATE NULL, 
ativa BIT DEFAULT(1)

CONSTRAINT fk_empresa_id_vaga
	FOREIGN KEY (empresa_id)
		REFERENCES empresas(empresa_id)
)