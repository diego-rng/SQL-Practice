create or alter procedure sp_recomendar_vagas 
    @usuario_id INT,
    @top_n INT = 10
as 
begin
    set nocount on

    begin try
        begin transaction
                
                -- Nullifies the call if the @top_n variable is 0 or negative

                if @top_n <= 0
                    throw 50000, 'Top Number cannot be 0 or negative.', 1;

                -- Logs the user's abilities 

                declare @abilities table (
                    abilities varchar(100),
                    nivel varchar(100)
                )

                insert into @abilities
                    select habilidade_id, nivel from usuario_habilidades where usuario_id = @usuario_id

                -- Logs user's city

                declare @city varchar(100) = (select cidade from usuarios where usuario_id = @usuario_id)

                declare @scores table (
                    vaga_id int, 
                    score INT
                )

                if exists (
                    select vaga_id 
                    from vaga_habilidades
                    where habilidade_id in (select abilities from @abilities) 
                    )
                    begin 
                    insert into @scores (vaga_id, score)
                        select 
                            v.vaga_id,
                            -- adds 30 per ability in common
                            cast((select (count(*) * 30) from vaga_habilidades vh where v.vaga_id = vh.vaga_id and vh.habilidade_id in (select abilities from @abilities)) + (
                                --adds 20 if same city as user
                            case 
                                when (select e.cidade from empresas e join vagas vi on e.empresa_id = vi.empresa_id where e.cidade = @city and vi.vaga_id = v.vaga_id ) is null
                                    then 0
                                else 20
                            end
                            ) + (
                                -- adds 15 if compatible level
                                case 
                                    when v.nivel in (select nivel from @abilities join vaga_habilidades vil on vil.vaga_id = v.vaga_id where abilities = vil.habilidade_id)
                                        then 15
                                    else 0 
                                end
                            ) + (
                                -- adds 10 if user has a connection within the company
                                case 
                                    when (select count(*)
                                            from conexoes ci 
                                            join candidaturas cii on cii.usuario_id = ci.usuario_destino 
                                                or cii.usuario_id = ci.usuario_origem 
                                            where ci.usuario_destino = @usuario_id 
                                                or ci.usuario_origem = @usuario_id 
                                                and cii.status like '%aprovada%')   
                                                > 0 then 10
                                                else 0
                                end                             
                            ) 
                            
                             as int) as score
                        from vagas v
                        where v.ativa = 1 and not exists (select vaga_id from candidaturas where vaga_id = v.vaga_id and usuario_id = @usuario_id)
                    end

                    select top (@top_n) 
                        s.vaga_id,
                        v.titulo,
                        e.nome as empresa,
                        e.cidade,
                        v.modalidade, 
                        v.nivel,
                        s.score as score_relevancia
                    from @scores s 
                        join vagas v on v.vaga_id = s.vaga_id
                        join empresas e on v.empresa_id = e.empresa_id
                    order by s.score desc
                     
        commit transaction;
    end try
    begin catch
        if @@trancount > 0 rollback transaction;
        throw;
    end catch;
    end