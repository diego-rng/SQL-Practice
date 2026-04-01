USE uber_db 
GO;

CREATE OR ALTER FUNCTION fn_valor_com_surge
(@valor_base DECIMAL(10,2), @surge DECIMAL(4,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN ROUND(@valor_base * @surge, 2);
END;