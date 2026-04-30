create table vaga_habilidades (
vaga_id INT NOT NULL,
habilidade_id INT NOT NULL

constraint fk_vaga_id_hab
	foreign key (vaga_id) 
		references vagas(vaga_id),

constraint fk_habilidade_id_hab
	foreign key (habilidade_id)
		references habilidades(habilidade_id)
)
