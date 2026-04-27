USE linkedin_db	
GO

declare @i int
set @i = 0
while (@i < 50)
Begin

BEGIN
DECLARE @vaga_id INT
SELECT @vaga_id = [vaga_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [vaga_id]) [row], [vaga_id]
	FROM [vagas]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [vagas])
END

BEGIN
DECLARE @habilidade_id INT
SELECT @habilidade_id = [habilidade_id] FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY [habilidade_id]) [row], [habilidade_id]
	FROM [habilidades]
) t
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) AS INT) FROM [habilidades])
END 

insert into vaga_habilidades values (@vaga_id, @habilidade_id)
SET @i = @i + 1
end