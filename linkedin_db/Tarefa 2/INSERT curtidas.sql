USE linkedin_db	
GO

declare @i int
set @i = 0
while (@i < 80)
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
DECLARE @post_id INT
SELECT @post_id = [post_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [post_id]) [row], [post_id]
	FROM [posts]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [posts])
END

BEGIN
DECLARE @length INT
DECLARE @reacao VARCHAR(15)
SELECT @reacao = ''

SET @length = CAST(RAND() * 15 AS INT)
WHILE @length <> 0 
BEGIN 
	SELECT @reacao = @reacao + CHAR(CAST(RAND() * 96 AS INT))
	SET @length = @length - 1
END
END

BEGIN
DECLARE @data_curtida DATETIME2

SELECT @data_curtida = DATEADD(DAY, CAST(RAND() * DATEDIFF(DAY, '2020-01-01', '2024-01-01') AS INT), '2020-01-01')

END
insert into curtidas values (@post_id, @usuario_id, @reacao, @data_curtida)
SET @i = @i + 1
end