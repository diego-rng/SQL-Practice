USE linkedin_db
GO

SELECT TOP 10 * FROM posts
ORDER BY data_publicacao DESC

PRINT('-------------------------')

SELECT * FROM posts
ORDER BY data_publicacao DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

PRINT('-------------------------')

SELECT * FROM POSTS
ORDER BY data_publicacao DESC
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;