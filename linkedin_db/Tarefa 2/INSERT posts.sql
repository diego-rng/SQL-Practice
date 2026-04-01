USE linkedin_db	
GO

declare @i int
set @i = 0
while (@i < 50)
Begin

BEGIN
DECLARE @usuario_id INT
SELECT @usuario_id = [usuario_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [usuario_id]) [row], [usuario_id]
	FROM [usuarios]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [usuarios])
END

BEGIN
DECLARE @length INT
DECLARE @conteudo NVARCHAR(3000)
SELECT @conteudo = ''

SET @length = CAST(RAND() * 3000 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @conteudo = @conteudo + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

BEGIN 
DECLARE @tipo VARCHAR(20)

SELECT @tipo = ''

SET @length = CAST(RAND() * 20 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @conteudo = @conteudo + CHAR(CAST(RAND() * 96 AS INT))
	SET @length = @length - 1
END
END

BEGIN
DECLARE @data_publicacao DATETIME2

SELECT @data_publicacao = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2024-01-01') AS INT), '2020-01-01')

END

BEGIN 
DECLARE @visualizacoes INT

SELECT @visualizacoes = CAST(RAND() * 100000 AS INT)

END

BEGIN

DECLARE @ativo BIT

SELECT @ativo = CAST(RAND() * 2 AS BIT)

END

insert into posts values (@usuario_id, @conteudo, @tipo, @data_publicacao, @visualizacoes, @ativo)
SET @i = @i + 1
end