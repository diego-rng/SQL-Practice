USE uber_db

CREATE TABLE pagamentos (

pagamento_id INT IDENTITY(1,1) PRIMARY KEY,
corrida_id INT NOT NULL UNIQUE,
metodo VARCHAR(30) NOT NULL
CHECK (metodo IN ('credito','debito','pix','carteira_uber')),
valor DECIMAL(10,2) NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT('pendente')
CHECK (status IN ('pendente','aprovado','recusado','estornado')),
data_pagamento DATETIME2 NULL,

CONSTRAINT fk_pagamento_corrida 
	FOREIGN KEY (corrida_id)
	REFERENCES corridas(corrida_id)
);