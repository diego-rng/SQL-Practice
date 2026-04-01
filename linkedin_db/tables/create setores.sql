-- =========================================
-- Create FileTable template
-- =========================================
USE linkedin_db
GO

CREATE TABLE setores (
   setor_id INT IDENTITY(1,1) PRIMARY KEY,
   nome NVARCHAR(100) NOT NULL
  );
GO
