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
DECLARE @vaga_id INT
SELECT @vaga_id = [vaga_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [vaga_id]) [row], [vaga_id]
	FROM [vagas]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [vagas])
END

BEGIN
DECLARE @length INT
DECLARE @status VARCHAR(25)
SELECT @status = 'aprovada'

--SET @length = CAST(RAND() * 25 AS INT)
--WHILE @length <> 0 
--BEGIN 
--	SELECT @status = @status + CHAR(CAST(RAND() * 96 AS INT))
--	SET @length = @length - 1
--END
END

BEGIN
DECLARE @data_candidatura DATETIME2

SELECT @data_candidatura = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2024-01-01') AS INT), '2020-01-01')

END

BEGIN
DECLARE @data_atualizacao DATETIME2

SELECT @data_atualizacao = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2024-01-01') AS INT), '2020-01-01')

END


BEGIN 
DECLARE @carta_apresentacao NVARCHAR(2000)

SET @length = CAST(RAND() * 2000 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @carta_apresentacao = @carta_apresentacao + CHAR(CAST(RAND() * 96 AS INT))
	SET @length = @length - 1
END

END

insert into candidaturas values (@usuario_id, @vaga_id, @status, @data_candidatura, @data_atualizacao, @carta_apresentacao)
SET @i = @i + 1
end