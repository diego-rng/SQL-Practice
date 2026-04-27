with original as (
    select 
        row_number() over (partition by usuario_id order by data_publicacao desc) as m,
        usuario_id,
        conteudo,
        data_publicacao,
        visualizacoes
    from posts
    group by usuario_id, conteudo, data_publicacao, visualizacoes
) select
    usuario_id, 
    conteudo,
    visualizacoes,
    data_publicacao
from original
where m = 1