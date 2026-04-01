USE uber_db

CREATE TABLE corridas (
corrida_id INT IDENTITY(1,1) PRIMARY KEY,
usuario_id INT NOT NULL,
motorista_id INT NOT NULL,
veiculo_id INT NOT NULL,
cidade_id INT NOT NULL,
status VARCHAR(20) NOT NULL
CHECK (status IN ('solicitada','aceita','em_andamento','concluida','cancelada')),
origem_endereco NVARCHAR(200) NOT NULL,
destino_endereco NVARCHAR(200) NOT NULL,
data_solicitacao DATETIME2 NOT NULL DEFAULT (GETDATE()),
data_inicio DATETIME2 NULL,
data_fim DATETIME2 NULL,
distancia_km DECIMAL(8,3) NULL,
duracao_minutos INT NULL,
valor_base DECIMAL(10,2) NULL,
valor_final DECIMAL(10,2) NULL,
surge_multiplier DECIMAL(4,2) NOT NULL DEFAULT (1.00),

CONSTRAINT fk_corrida_usuario 
	FOREIGN KEY (usuario_id)
	REFERENCES usuarios(usuario_id),
CONSTRAINT fk_corrida_motorista 
	FOREIGN KEY (motorista_id)
	REFERENCES motoristas(motorista_id),
CONSTRAINT fk_corrida_veiculo 
	FOREIGN KEY (veiculo_id)
	REFERENCES veiculos(veiculo_id),
CONSTRAINT fk_corrida_cidade 
	FOREIGN KEY (cidade_id)
	REFERENCES cidades(cidade_id)
);