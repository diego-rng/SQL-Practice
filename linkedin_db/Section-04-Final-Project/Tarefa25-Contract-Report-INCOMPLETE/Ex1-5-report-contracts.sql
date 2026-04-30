create or alter procedure sp_relatorio_rh @empresa_id INT, @data_inicio DATE, @data_fim date
as 
begin
    set nocount on

    begin try
        begin transaction 

            if @empresa_id is null
                begin
                    with vs as (
                        select 
                            v.titulo,
                            (select count(*) 
                                from candidaturas ci 
                                where ci.vaga_id = v.vaga_id
                                ) as total_cand,
                            c.status,
                            datediff(day, v.data_publicacao, c.data_candidatura) as time_until_cand,
                            (select datediff(day, ci.data_candidatura, ci.data_atualizacao) 
                                from candidaturas ci 
                                where ci.vaga_id = v.vaga_id 
                                    and ci.status like '%aprovada%')
                        from vagas v
                        join candidaturas c on c.vaga_id = v.vaga_id
                    ),
                    cands as (
                        select 
                            (select count(*) 
                                from candidaturas ci 
                                join vagas vi on ci.vaga_id = vi.vaga_id 
                                join empresas ei on ei.empresa_id = vi.empresa_id 
                            where ei.empresa_id = e.empresa_id) 
                                as total_cand_all,
                            (select count(*) 
                                from candidaturas ci
                                join vagas vi on ci.vaga_id = vi.vaga_id 
                                join empresas ei on ei.empresa_id = vi.empresa_id 
                            where ei.empresa_id = e.empresa_id and ci.status like '%aprovada%') 
                                as aprov,
                            (select top 1 vi.vaga_id 
                                from vagas vi 
                                join empresas ei on ei.empresa_id = vi.empresa_id
                                join candidaturas ci on vi.vaga_id = ci.vaga_id 
                            where ei.empresa_id = e.empresa_id
                            order by count(ci.vaga_id) desc) 
                                as vaga_mais_disputada,
                            (select string_agg(hi.nome, ', ')
                                from habilidades hi 
                                join usuario_habilidades uhi on uhi.habilidade_id = hi.habilidade_id
                                join candidaturas ci on ci.usuario_id = uhi.usuario_id
                                join vagas vi on vi.vaga_id = ci.vaga_id
                            where vi.empresa_id = e.empresa_id)
                                as hab_approved
                        from empresas e
                        group by e.empresa_id
                    )

                    select 
                        titulo,
                        total_cand,
                        ['aprovada'] as aprovadas,
                        ['reprovada'] as reprovadas
                    from vs 
                    pivot (
                        total_cand
                        for status in (['aprovada'], ['reprovada'])
                    ) as pvt
                end;
            if @empresa_id is not null 
                begin
                    with vs as (
                        select 
                            titulo,
                            (select count(*) from candidaturas ci where ci.vaga_id = v.vaga_id) as total_cand,
                            c.status,
                            datediff(day, v.data_publicacao, c.data_candidatura) as time_until_cand,
                            (select datediff(day, ci.data_candidatura, ci.data_atualizacao) from candidaturas ci where ci.vaga_id = v.vaga_id and ci.status like '%aprovada%')
                        from vagas v
                            join candidaturas c on c.vaga_id = v.vaga_id
                        where v.empresa_id = @empresa_id
                    ),
                    cands as (
                        select 
                            (select count(*) 
                                from candidaturas ci 
                                join vagas vi on ci.vaga_id = vi.vaga_id 
                                join empresas ei on ei.empresa_id = vi.empresa_id 
                            where ei.empresa_id = e.empresa_id) 
                                as total_cand_all,
                            (select count(*) 
                                from candidaturas ci
                                join vagas vi on ci.vaga_id = vi.vaga_id 
                                join empresas ei on ei.empresa_id = vi.empresa_id 
                            where ei.empresa_id = e.empresa_id and ci.status like '%aprovada%') 
                                as aprov,
                            (select top 1 vi.vaga_id 
                                from vagas vi 
                                join empresas ei on ei.empresa_id = vi.empresa_id
                                join candidaturas ci on vi.vaga_id = ci.vaga_id 
                            where ei.empresa_id = e.empresa_id
                            order by count(ci.vaga_id) desc) 
                                as vaga_mais_disputada,
                            (select string_agg(hi.nome, ', ')
                                from habilidades hi 
                                join usuario_habilidades uhi on uhi.habilidade_id = hi.habilidade_id
                                join candidaturas ci on ci.usuario_id = uhi.usuario_id
                                join vagas vi on vi.vaga_id = ci.vaga_id
                            where vi.empresa_id = e.empresa_id)
                                as hab_approved
                        from empresas e
                        where e.empresa_id = @empresa_id
                    )
                end
        commit transaction;
    end try
    begin catch
        if @@trancount > 0 rollback transaction;
        throw;
    end catch
end