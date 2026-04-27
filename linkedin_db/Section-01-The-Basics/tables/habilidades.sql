USE linkedin_db	
GO

CREATE TABLE habilidades (
	habilidade_id INT IDENTITY(1,1) PRIMARY KEY,
	nome NVARCHAR(100) NOT NULL, 
	categoria VARCHAR(20) NOT NULL
	)