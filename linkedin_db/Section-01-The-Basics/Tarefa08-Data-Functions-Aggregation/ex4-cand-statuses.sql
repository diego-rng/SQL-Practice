CREATE VIEW vw_status_distribution
AS 
SELECT 
DISTINCT status,
COUNT(status) as cand_count,
ROUND(CAST(COUNT(status) * 100.0 / (SELECT COUNT(*) FROM candidaturas) AS FLOAT), 2) as cand_percent
FROM candidaturas
GROUP BY status

SELECT TOP 10 * FROM vw_status_distribution
ORDER BY cand_count DESC
