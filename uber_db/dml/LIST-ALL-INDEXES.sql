USE uber_db

SELECT name, type_desc, is_unique, is_primary_key, filter_definition
FROM sys.indexes
WHERE object_id = OBJECT_ID('corridas');

