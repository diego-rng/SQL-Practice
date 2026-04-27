USE linkedin_db 
GO 

SELECT * FROM usuarios WHERE data_cadastro >= DATEADD(MONTH, -DATEDIFF(MONTH, '2020-01-01', '2020-06-01'), GETDATE()) AND premium = 1;
