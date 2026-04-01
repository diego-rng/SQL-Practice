USE uber_db

SELECT corrida_id,
dbo.fn_valor_com_surge(valor_base, surge_multiplier) AS valor_cobrado
FROM corridas WHERE status = 'concluida';

