# Stored Procedures and Functions

## Stored Procedures

### sp_buscar_vagas - Opening Search

This Procedure is focused on filtered searching of job openings, with optional filters for Keywords, City, Modality, Level of difficulty, Minimum pay and filtering per company.

#### Returns

It returns:

- Title
- Company
- Sector
- City
- Modality
- Level of Difficulty
- Minimum pay
- Maximum pay
- Post date

and is made to only return active openings.

If you enter any fields Null, those will be ignored when filtering.

#### Calling the procedure

When calling this function, make sure to know which fields you want to have an actual filter on and which you want null.

#### Example:

```
exec sp_buscar_vagas @palavra_chave = null, @cidade = 'Rio de Janeiro', @modalidade = 'hibrido', @nivel = null, @salario_min = 1500.0, @empresa_id = null
```

#### Expected result:

| titulo | empresa | setor | cidade | modalidade | nivel | salario_min | salario_max | data_publicacao|
|:------------:|:---------:|:-------:|:-------:|:------------:|:-------:|:------------:|:------------:|:----------------:|            
| Médico Clínico Geral |  VidaPlus Clinicas | Saude | Rio de Janeiro | hibrido |  Avançado | 5980.85 | 23536.91 | 2021-03-24 00:00:00.0000000 | 

### sp_registrar_candidatura - Easily registering job applications

This procedure is meant for easily creating new applications and identifying any errors upon doing so.

#### Returns

This procedure will not return anything, given the application is created successfully.

However, given an error does occur, the function will return an error between codes 50010 and 50013.

- Error code 50010: User does not exist or is not currently active

- Error code 50011: Opening does not exist or is not active anymore

- Error code 50012: Server attempted to create an opening with a code that already exists
 
- Error code 50013: Opening has expired

#### Calling the procedure

When calling the function, you only need to input 3 fields, the User's ID, the Opening's ID and the Opening Proposal text. The procedure also expects the id for the opening, but that should always be null.

#### Example:

```
exec sp_registrar_candidatura @usuario_id = 12, @vaga_id = 7284, @carta = 'example', @candidatura_id = null
```

#### Expected return: 

```
Commands completed successfully.
Total execution time: 00:00:00.203
```

### sp_recomendar_vagas - Recommend openings based on a score related to the user

This procedure will score every opening based on a list of factors and then list the top (x) openings, ordered descending by score. (x) is defined by the user with the @top_n variable.

#### Returns

This procedure returns a list of functions (number defined by the user) with:

- Title
- Company
- City
- Modality 
- Level of difficulty
- Score

and will fail to run if the number provided is below or equal to 0.

#### Calling the procedure

To call the function, simply execute the function while making sure to specify both the user's ID and how many openings you would like to have listed.

#### Example:
```
exec sp_recomendar_vagas @usuario_id = 32, @top_n = 10
```

#### Expected output:

| vaga_id | Título | Nível | Modalidade | Empresa | Cidade | Score Relevância |
|---------|--------|-------|------------|---------|--------|-----------------|
| 4114 | Desenvolvedor de Software | Intermediário | Híbrido | Tech teste | Salvador | 60 |
| 5431 | Analista de QA | Intermediário | Híbrido | Tech teste | Salvador | 60 |
| 5404 | Analista de Marketing Digital | Avançado | Remoto | BrandLift Agency | London | 40 |
| 5444 | Analista de Investimentos | Avançado | Presencial | FinEdge Investimentos | Sao Paulo | 40 |
| 4406 | Analista de Logística Internacional | Especialista | Remoto | TransGlobal Logistica | Hamburgo | 40 |
| 5338 | Coordenador de Saúde | Avançado | Remoto | NovaCare Health Group | Toronto | 40 |
| 5339 | Médico Clínico | Avançado | Presencial | VidaPlus Clinicas | Rio de Janeiro | 40 |
| 4012 | Especialista em E-commerce | Intermediário | Híbrido | Mercato Digital | Sao Paulo | 40 |
| 4372 | Gerente de Produto Digital | Especialista | Híbrido | Mercato Digital | Sao Paulo | 40 |

## Functions

### fn_score_perfil - Getting a user's arbitrary score

This function is focused on scoring a user based on their abilities, experience, connections and if they are a premium user in the website.

#### Returns

This function only has one return, which is the user's overall score.

#### Calling the function

To call the function, just insert it in a `SELECT` statement with the designated user's ID behind parentheses, or if you want to run it for every user, run it as a column.

##### Example 1:

``` 
select dbo.fn_score_perfil(15) as score
```
##### Expected result:

|score|
|:-:|
|225|

##### Example 2:

```
select 
    u.usuario_id,
    u.nome,
    dbo.fn_score_perfil(u.usuario_id) as score
from usuarios u
```

##### Expected result:

|usuario_id|nome|score|
|:---:|:-:|-:|
| 5 | Lucas Almeida   | 345 |
| 6 | Mariana Costa   | 180 | 
| 7 | Rafael Souza    | 250 | 
| 8 | Juliana Pereira | 300 |

and more...

### fn_conexoes_usuario - Getting a user's active connections

This function will do as the name suggests: it will return the user's active, first degree connections.

#### Returns

This function will return the user's ID and the connection's ID.

#### Calling the function

To call the function, you must treat it as if it were a table, since this is a TVF (Table-Valued Function). Call a `SELECT` statement with the function as the `FROM`.

#### Example:

```
select * 
    from fn_conexoes_usuario(27)
``` 

#### Expected return:

|conexao_id|usuario_origem|usuario_destino|status|data_solicitacao|data_resposta|
|:-:|:-:|:-:|:-:|:-:|:-:|
| 1112 | 27 | 25 | aceita | 2023-03-16 | 2024-12-11 |
| 1114 | 34 | 27 | aceita | 2023-10-13 | 2023-10-14 |
| 1132 | 27 | 32 | aceita | 2022-05-28 | 2022-06-03 | 

### fn_vagas_recomendadas - Recommending openings to a specific user

This function compares a user's skills to an opening's wanted skills and will recommend any openings that have 2 or more matching skills to the provided user.

#### Returns

As this is a TVF, it will return a table with the opening id's and the amount of matching skills to the provided users.

#### Calling the function

To call this function, like the previous one, call a `SELECT` statement with this section as the `FROM`.

#### Example:

```
select *
    from fn_vagas_recomendadas(34)
```

#### Expected return:

|vaga_id|hab_comuns|
|:---:|:-:|
|3989 | 2 |
|5501 | 2 | 
|6341 | 2 | 
|6414 | 2 |

