USE uber_db

--INSERT INTO cidades (nome, estado, pais)
--VALUES ('Sao Paulo', 'SP', 'BRA');

INSERT INTO cidades (nome, estado)
VALUES
('Rio de Janeiro', 'RJ'),
('Curitiba', 'PR'),
('Belo Horizonte', 'MG'),
('Porto Alegre', 'RS');

--DECLARE @ids TABLE (id INT);
--INSERT INTO cidades (nome, estado)
--OUTPUT INSERTED.cidade_id INTO @ids
--VALUES ('Recife', 'PE');
--SELECT id FROM @ids;