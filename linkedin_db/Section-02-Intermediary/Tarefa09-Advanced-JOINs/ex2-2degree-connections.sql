
SELECT u1.nome AS con1,
u3.nome AS conIndex,
u2.nome AS con2
FROM conexoes c1, conexoes c2 , usuarios u1, usuarios u2, usuarios u3
WHERE u1.usuario_id = c1.usuario_origem
AND u2.usuario_id = c2.usuario_destino
AND u3.usuario_id = c1.usuario_destino
AND
NOT c1.usuario_origem = c2.usuario_destino 
AND c1.usuario_destino = c2.usuario_origem
