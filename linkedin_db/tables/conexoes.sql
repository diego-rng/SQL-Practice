-- =========================================
-- Create FileTable template
-- =========================================
USE linkedin_db
GO

CREATE TABLE conexoes (
	conexao_id INT IDENTITY(1,1) PRIMARY KEY,
	usuario_origem INT NOT NULL,
	usuario_destino INT NOT NULL,
	status VARCHAR(15) NOT NULL,
	data_solicitacao DATETIME2 DEFAULT(GETDATE()),
	data_resposta DATETIME2 NULL
	CONSTRAINT fk_usuario_origem
		FOREIGN KEY (usuario_origem) 
		REFERENCES dbo.usuarios(usuario_id),

	CONSTRAINT fk_usuario_destino
		FOREIGN KEY (usuario_destino)
		REFERENCES dbo.usuarios(usuario_id)
  );
GO
