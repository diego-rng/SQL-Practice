SELECT nome, 
titulo_perfil, 
cidade
FROM usuarios 
WHERE titulo_perfil LIKE '%Engenheiro%' 
OR titulo_perfil LIKE '%Analista%' 
OR titulo_perfil LIKE '%Desenvolvedor%'