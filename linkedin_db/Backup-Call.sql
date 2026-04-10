backup database linkedin_db 
to disk = '/var/opt/mssql/backups'
with format, init, compression,
name = 'linkedin_db - Full Backup',
stats = 10;