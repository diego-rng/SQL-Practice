MERGE habilidades_mercado AS target
USING (
    SELECT
        vh.habilidade_id,
        h.nome,
        (SELECT COUNT(*) FROM vagas vi WHERE vi.vaga_id = vh.vaga_id) AS demanda_vagas
    FROM vaga_habilidades vh
    JOIN habilidades h ON h.habilidade_id = vh.habilidade_id
) AS origin
ON (target.habilidade_id = origin.habilidade_id)
WHEN NOT MATCHED THEN
    INSERT (habilidade_id, nome, demanda_vagas)
    VALUES (origin.habilidade_id, origin.nome, origin.demanda_vagas);