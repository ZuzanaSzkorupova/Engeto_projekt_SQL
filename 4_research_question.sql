--4.Q Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?--
	
WITH wages_price_per_year AS (
	SELECT
		AVG(average_wages) AS avg_wages,
		AVG(price) AS avg_price,
		payroll_year,
		price_year
	FROM t_zuzana_szkorupova_project_sql_primary_final
	GROUP BY 
		payroll_year,
		price_year
),
lag_wages_price AS (			--hodnota z předchozího roku pro výpočet růstu--
	SELECT
		avg_wages,
		avg_price,
		payroll_year,
		price_year,
		LAG(avg_wages) OVER (ORDER BY payroll_year) AS wages_last_year,
   		LAG(avg_price) OVER (ORDER BY price_year) AS price_last_year
	FROM wages_price_per_year
),
growth_calculation AS (			--výpočet rústu mezd a cen--
	SELECT
		payroll_year,
    	price_year,
   	 	avg_wages,
    	avg_price,
   		ROUND(
    		CASE
       			WHEN wages_last_year IS NULL OR wages_last_year = 0 THEN NULL
        		ELSE (avg_wages - wages_last_year) / wages_last_year * 100 
        	END,
        	2
     	) AS growth_rate_wages,
   		ROUND(
    		(
    			CASE
       				WHEN price_last_year IS NULL OR price_last_year = 0 THEN NULL
        			ELSE (avg_price - price_last_year) / price_last_year * 100 
        		END
       		):: NUMERIC,
        	2
     	) AS growth_rate_price
	FROM lag_wages_price 
)
SELECT							--finální výstup - absolutní rozdíl mezi růstem mezd a cen--
	payroll_year AS year,
	growth_rate_wages,
	growth_rate_price,
	ABS(growth_rate_wages - growth_rate_price) as differences
FROM growth_calculation
ORDER BY differences;















