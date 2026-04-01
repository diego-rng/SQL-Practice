SELECT signup_month, COUNT(signup_month) AS MONTHCOUNT
FROM vw_signup_patterns
GROUP BY signup_month
ORDER BY COUNT(signup_month) DESC;

SELECT signup_year, COUNT(signup_year) as YEARCOUNT 
FROM vw_signup_patterns
GROUP BY signup_year
ORDER BY COUNT(signup_year) DESC;
