SELECT DATE_FORMAT(create_date, '%Y-%m') AS issue_date,
district_id,
monthly_issurance,
sum(monthly_issurance) over (PARTITION BY EXTRACT(YEAR FROM create_date), district_id) AS yearly_issuance,
round(monthly_issurance * 100 / sum(monthly_issurance) over (PARTITION BY EXTRACT(YEAR FROM create_date), district_id), 1) AS pct_yearly
FROM 
(
SELECT 
		create_date, 
	 	district_id, SUM(CASE WHEN frequency_translated = 'MONTHLY ISSUANCE' THEN 1 ELSE 0 END) AS monthly_issurance
FROM account_transformed
WHERE district_id IN (1, 70, 72, 74)
GROUP BY 1, 2
ORDER BY 1, 2) AS a
GROUP BY 1, 2
order BY 1, 2;