USE linkedin_db
GO

ALTER TABLE usuarios 
ADD linkedin_url VARCHAR(200) UNIQUE
