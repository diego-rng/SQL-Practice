USE uber_db
GO

CREATE OR ALTER FUNCTION fn_historico_usuario (@usuario_id INT)
RETURNS TABLE AS RETURN (
SELECT c.corrida_id, c.data_solicitacao, c.status,
m.nome AS motorista,  v.modelo, v.categoria, 
c.valor_final, p.metodo AS pagamento
FROM corridas c
JOIN motoristas m ON c.motorista_id = m.motorista_id
JOIN veiculos v ON c.veiculo_id = v.veiculo_id
LEFT JOIN pagamentos p ON c.corrida_id = p.corrida_id
WHERE c.usuario_id = @usuario_id
);