--5. Q Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
-- projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?--

WITH gdp_cze AS (
	SELECT 
		DISTINCT year,
		country,
		gdp
	FROM t_zuzana_szkorupova_project_sql_secondary_final t 
	WHERE country LIKE 'Cze%'
),
avg_wages_avg_price AS (
	SELECT
		AVG(average_wages) AS avg_wages,
		AVG(price) AS avg_price,
		price_year
	FROM t_zuzana_szkorupova_project_sql_primary_final t 
	GROUP BY 
		price_year 
),
table_avg_wages_price_gdp as (
	SELECT 
		g.year,
		g.country,
		g.gdp,
		a.avg_price,
		a.avg_wages
	FROM gdp_czechia_5_q g 
	JOIN avg_wages_price_5_q a 
		ON g."year" = a.price_year
),
lag_wages_price_gdp AS (
	SELECT
		year,	
		avg_wages,
		avg_price,
		gdp,
		LAG(avg_wages) OVER (ORDER BY year) AS wages_last_year,
    	LAG(avg_price) OVER (ORDER BY year) AS price_last_year,
  		LAG(gdp)OVER (ORDER BY year) AS gdp_last_year
	FROM table_avg_wages_price_gdp
)
SELECT
	year,
    avg_wages,
    avg_price,
    gdp,
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
      	)::NUMERIC,
      	2
   ) AS growth_rate_price,
   ROUND(
       (
   			CASE
    			WHEN gdp_last_year IS NULL OR gdp_last_year = 0 THEN NULL
        		ELSE (gdp - gdp_last_year) / gdp_last_year * 100 
        	END
     	)::NUMERIC,
    	2
   ) AS growth_rate_gdp
FROM lag_wages_price_gdp;
