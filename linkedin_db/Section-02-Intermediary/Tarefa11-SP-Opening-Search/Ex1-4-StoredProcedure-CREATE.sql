create or alter procedure sp_buscar_vagas
    @palavra_chave  NVARCHAR(100)   = null,
    @cidade         NVARCHAR(100)   = null,
    @modalidade     VARCHAR(50)     = null,
    @nivel          VARCHAR(50)     = null,
    @salario_min    DECIMAL(10,2)   = null,
    @empresa_id     INT             = null OUTPUT
as
begin
    begin try
        set nocount on;

        if @salario_min is not null and @salario_min <= 0
            throw 50002, 'Invalid min salary number', 1;

        if @palavra_chave is null and @cidade is null
            and @modalidade is null and @nivel is null
            and @salario_min is null and @empresa_id is null
        begin
            select v.titulo, e.nome, s.nome,
                   e.cidade, v.modalidade, v.nivel,
                   v.salario_min, v.salario_max, v.data_publicacao
            from vagas v
            join empresas e on v.empresa_id = e.empresa_id
            join setores s on e.setor_id = s.setor_id;
            return;
        end

        if @cidade is not null
        begin
            if not exists (select 1 from empresas where cidade like '%' + @cidade + '%')
                throw 50003, 'City not found', 1;
        end

        if @empresa_id is not null
        begin
            if not exists (select 1 from empresas where empresa_id = @empresa_id)
                throw 50004, 'Company not found', 1;
        end

        if not exists (
            select 1 from vagas v
            join empresas e on v.empresa_id = e.empresa_id
            where (
                (@palavra_chave  is null or v.titulo        like '%' + @palavra_chave + '%')
                and (@cidade     is null or e.cidade        like '%' + @cidade        + '%')
                and (@modalidade is null or v.modalidade    like '%' + @modalidade    + '%')
                and (@nivel      is null or v.nivel         like '%' + @nivel         + '%')
                and (@salario_min is null or v.salario_min  >=   @salario_min)
                and (@empresa_id  is null or e.empresa_id   =    @empresa_id)
            )
            and v.ativa = 1
        )
            throw 50001, 'Not found', 1;

        select 
            v.titulo, 
            e.nome as empresa, 
            s.nome as setor,
            e.cidade,
            v.modalidade,
            v.nivel,
            v.salario_min, 
            v.salario_max, 
            v.data_publicacao
        from vagas v
        join empresas e on v.empresa_id = e.empresa_id
        join setores s on e.setor_id = s.setor_id
        where (
            (@palavra_chave  is null or v.titulo        like '%' + @palavra_chave + '%')
            and (@cidade     is null or e.cidade        like '%' + @cidade        + '%')
            and (@modalidade is null or v.modalidade    like '%' + @modalidade    + '%')
            and (@nivel      is null or v.nivel         like '%' + @nivel         + '%')
            and (@salario_min is null or v.salario_min  >=   @salario_min)
            and (@empresa_id  is null or e.empresa_id   =    @empresa_id)
        )
        and v.ativa = 1;

    end try
    begin catch
        throw;
    end catch
end