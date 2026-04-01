USE uber_db

CREATE TABLE avaliacoes (

avaliacao_id INT IDENTITY(1,1) PRIMARY KEY,
corrida_id INT NOT NULL,
avaliador_tipo VARCHAR(10) NOT NULL
CHECK (avaliador_tipo IN ('usuario', 'motorista')),
nota TINYINT NOT NULL CHECK (nota BETWEEN 1 AND 5),
comentario NVARCHAR(500) NULL,
data_avaliacao DATETIME2 NOT NULL DEFAULT (GETDATE()),

CONSTRAINT fk_avaliacao_corrida
	FOREIGN KEY (corrida_id)
	REFERENCES corridas(corrida_id)

);