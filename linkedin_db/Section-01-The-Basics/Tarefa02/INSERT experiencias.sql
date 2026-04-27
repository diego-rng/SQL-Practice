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
DECLARE @empresa_id INT
SELECT @empresa_id = [empresa_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [empresa_id]) [row], [empresa_id]
	FROM [empresas]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [empresas])
END 

BEGIN
DECLARE @cargo NVARCHAR(150)
SELECT @cargo = [titulo_perfil] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [titulo_perfil]) [row], [titulo_perfil]
	FROM [usuarios]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [usuarios])
END 

BEGIN
DECLARE @data_inicio DATETIME2

SELECT @data_inicio = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2015-01-01', '2025-01-01') AS INT), '2015-01-01')

END

BEGIN 
DECLARE @data_fim DATE

SELECT @data_fim = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2026-01-01') AS INT), '2020-01-01')

END

BEGIN
DECLARE @length INT
DECLARE @descricao VARCHAR(15)
SELECT @descricao = ''

SET @length = CAST(RAND() * 15 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @descricao = @descricao + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

insert into experiencias values (@usuario_id, @empresa_id, @cargo, @data_inicio, @data_fim, @descricao)
SET @i = @i + 1
end