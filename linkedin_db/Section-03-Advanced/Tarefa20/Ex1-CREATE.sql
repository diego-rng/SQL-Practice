create table habilidades_mercado (
habilidade_id INT NOT NULL,
nome NVARCHAR(100) NOT NULL,
demanda_vagas INT NOT NULL

constraint fk_habilidade_id_merc
	foreign key (habilidade_id)
		references habilidades(habilidade_id)
)