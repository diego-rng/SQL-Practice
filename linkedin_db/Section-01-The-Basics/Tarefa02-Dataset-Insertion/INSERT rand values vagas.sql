USE linkedin_db	
GO

declare @i int
set @i = 0
while (@i < 25)
Begin

BEGIN
DECLARE @empresa_id INT
SELECT @empresa_id = [empresa_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [empresa_id]) [row], [empresa_id]
	FROM [empresas]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [empresas])
END

BEGIN
DECLARE @titulo NVARCHAR(200)

DECLARE @length INT
SELECT @titulo = ''

SET @length = CAST(RAND() * 200 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @titulo = @titulo + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END 

BEGIN
DECLARE @descricao NVARCHAR(MAX)
SELECT @descricao = ''

SET @length = CAST(RAND() * 1000 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @descricao = @descricao + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

BEGIN
DECLARE @cidade NVARCHAR(100)
SELECT @cidade = [cidade] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [cidade]) [row], [cidade]
	FROM [usuarios]
) a
WHERE a.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [usuarios])
END

BEGIN
DECLARE @modalidade VARCHAR(20)
SELECT @modalidade = ''

SET @length = CAST(RAND() * 20 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @modalidade = @modalidade + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

BEGIN
DECLARE @nivel VARCHAR(20)
SELECT @nivel = ''

SET @length = CAST(RAND() * 20 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @nivel = @nivel + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

BEGIN 

DECLARE @salario_min DECIMAL(10,2)

SELECT @salario_min = CAST(RAND() * (10000 - 500) AS DECIMAL(10,2))

END

BEGIN
DECLARE @salario_max DECIMAL(10,2)

SELECT @salario_max = CAST(RAND() * (30000 - 500) AS DECIMAL(10,2))

END

BEGIN
DECLARE @data_publicacao DATETIME2

SELECT @data_publicacao = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', getdate()) AS INT), '2020-01-01')

END

BEGIN 
DECLARE @data_expiracao DATE

SELECT @data_expiracao = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, @data_publicacao, '2027-12-31') AS INT), @data_publicacao)

END

BEGIN
DECLARE @ativa BIT

SELECT @ativa = 1

END

insert into vagas values (@empresa_id, @titulo, @descricao, @cidade, @modalidade, @nivel, @salario_min, @salario_max, @data_publicacao, @data_expiracao, @ativa)
SET @i = @i + 1
end