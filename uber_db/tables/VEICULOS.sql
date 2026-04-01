USE uber_db;

CREATE TABLE veiculos (
veiculo_id INT IDENTITY(1, 1) PRIMARY KEY,
motorista_id INT NOT NULL,
marca VARCHAR(50) NOT NULL,
modelo VARCHAR(80) NOT NULL,
ano SMALLINT NOT NULL,
placa CHAR(8) NOT NULL,
categoria VARCHAR(20) NOT NULL,
CHECK (categoria IN ('UberX', 'UberBlack', 'UberComfort', 'Moto')),
ativo BIT NOT NULL DEFAULT (1),

CONSTRAINT uq_veiculo_placa UNIQUE (placa),
CONSTRAINT fk_veiculo_motorista 
	FOREIGN KEY (motorista_id)
	REFERENCES motoristas(motorista_id)
);

