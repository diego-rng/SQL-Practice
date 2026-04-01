USE uber_db

CREATE TABLE promocoes (
promocao_id INT IDENTITY(1,1) PRIMARY KEY,
codigo VARCHAR(20) NOT NULL UNIQUE,
descricao NVARCHAR(200) NOT NULL,
desconto_pct DECIMAL(5,2) NOT NULL,
CHECK (desconto_pct BETWEEN 1 AND 100),
validade DATE NOT NULL,
uso_maximo INT NOT NULL DEFAULT(1),
usos_realizados INT NOT NULL DEFAULT(0),
ativa BIT NOT NULL DEFAULT (1)
);