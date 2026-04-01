USE linkedin_db	
GO

declare @i int
set @i = 0
while (@i < 50)
Begin

BEGIN
DECLARE @usuario_origem INT
SELECT @usuario_origem = [usuario_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [usuario_id]) [row], [usuario_id]
	FROM [usuarios]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [usuarios])
END

BEGIN
DECLARE @usuario_destino INT
SELECT @usuario_destino = [usuario_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [usuario_id]) [row], [usuario_id]
	FROM [usuarios]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [usuarios])
END 

BEGIN
DECLARE @length INT
DECLARE @status VARCHAR(15)
SELECT @status = ''

SET @length = CAST(RAND() * 15 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @status = @status + CHAR(CAST(RAND() * 96 + 32 AS INT))
	SET @length = @length - 1
END
END

BEGIN
DECLARE @data_solicitacao DATETIME2

SELECT @data_solicitacao = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2024-01-01') AS INT), '2020-01-01')

END

BEGIN 
DECLARE @data_resposta DATE

SELECT @data_resposta = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2025-01-01') AS INT), '2020-01-01')

END

insert into conexoes values (@usuario_origem, @usuario_destino, @status, @data_solicitacao, @data_resposta)
SET @i = @i + 1
end