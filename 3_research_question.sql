--3. Q Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? --

WITH prices_per_year AS (
    SELECT
        price_year,
        name_of_category,
        AVG(price) as average_price
    FROM t_zuzana_szkorupova_project_sql_primary_final
    GROUP BY
        price_year,
        name_of_category
),
lag_price AS (
    SELECT
        price_year,
        name_of_category,
        average_price,
        LAG(average_price) OVER (
            PARTITION BY name_of_category
            ORDER BY price_year
        ) AS price_last_year
    FROM prices_per_year
),
growth_calculation AS (
	SELECT
    	name_of_category,
    	price_year,
    	average_price,
    	price_last_year,
   	 CASE
        WHEN price_last_year IS NULL OR price_last_year = 0 THEN NULL
        ELSE (average_price - price_last_year) / price_last_year * 100 
        END AS growth_rate
	FROM lag_price
)
SELECT 
	name_of_category, 
	ROUND(AVG(growth_rate)::NUMERIC, 2) as avg_growth_rate
FROM growth_calculation
GROUP BY name_of_category
ORDER BY avg_growth_rate ASC;