create or alter view vw_empresa_dashboard as (
select
	e.nome as nome,
	s.nome as setor,
	e.tamanho,
	(select count(*) from vagas vi where vi.ativa = 1 and vi.empresa_id = e.empresa_id) as vagas_ativas,
	(select count(*) from candidaturas ci join vagas vi on vi.vaga_id = ci.vaga_id where vi.empresa_id = e.empresa_id) as total_candidaturas,
	cast(
    (select count(*) * 100.0 from candidaturas ci join vagas vi on vi.vaga_id = ci.vaga_id where vi.empresa_id = e.empresa_id and ci.status = 'aprovada')
		/ nullif((select count(*) from candidaturas ci join vagas vi on vi.vaga_id = ci.vaga_id where vi.empresa_id = e.empresa_id), 0)
		as decimal(10,2)) as taxa_aprovacao, 
	((select avg(datediff(day, vi.data_publicacao, ci.data_candidatura)) from vagas vi join candidaturas ci on vi.vaga_id = ci.vaga_id where vi.empresa_id = e.empresa_id)) as media_preenchimento
from empresas e 
	join setores s on e.setor_id = s.setor_id
)