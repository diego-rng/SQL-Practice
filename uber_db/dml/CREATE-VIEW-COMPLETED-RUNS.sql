USE uber_db
GO

CREATE OR ALTER VIEW vw_corridas_completas AS 
SELECT 
c.corrida_id,
u.nome AS passageiro,
u.email AS email_passageiro,
m.nome AS motorista,
m.avaliacao_media,
v.categoria,
CONCAT(v.marca,' ',v.modelo) AS veiculo,
ci.nome AS cidade,
c.status,
c.origem_endereco, c.destino_endereco,
c.distancia_km, c.valor_final, 
c.surge_multiplier, 
p.metodo AS pagamento,
p.status AS status_pgto,
DATEDIFF(MINUTE, c.data_inicio, c.data_fim) AS duracao_min
FROM corridas c
JOIN usuarios u ON c.usuario_id = u.usuario_id
JOIN motoristas m ON c.motorista_id = m.motorista_id
JOIN veiculos v ON c.veiculo_id = v.veiculo_id
JOIN cidades ci ON c.cidade_id = ci.cidade_id
LEFT JOIN pagamentos p ON c.corrida_id = p.corrida_id;
