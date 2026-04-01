USE uber_db

SELECT 
c.corrida_id,
u.nome AS passageiro,
m.nome AS motorista,
m.avaliacao_media,
CONCAT(v.marca,' ', v.modelo) as veiculo,
v.categoria,
ci.nome AS cidade, 
c.origem_endereco,
c.destino_endereco,
c.distancia_km,
c.valor_final,
c.surge_multiplier,
p.metodo AS forma_pagamento,
p.status AS status_pagamento,
DATEDIFF(MINUTE, c.data_inicio, c.data_fim) AS duracao_real_min
FROM corridas c

INNER JOIN usuarios u ON c.usuario_id = u.usuario_id
INNER JOIN motoristas m ON c.motorista_id = m.motorista_id
INNER JOIN veiculos v ON c.veiculo_id = v.veiculo_id
INNER JOIN cidades ci ON c.cidade_id = ci.cidade_id
LEFT JOIN pagamentos p ON c.corrida_id = p.corrida_id
WHERE c.status = 'concluida'
ORDER BY c.data_fim DESC;