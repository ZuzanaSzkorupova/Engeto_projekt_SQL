--2. Q Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední 
--srovnatelné období v dostupných datech cen a mezd?--

WITH avg_wages AS (
    SELECT 
        payroll_year,
        AVG(average_wages) AS avg_wage
    FROM t_zuzana_szkorupova_project_sql_primary_final
    GROUP BY  payroll_year
),
avg_prices AS (
    SELECT 
        price_year,
        name_of_category,
        AVG(price) AS avg_price
        FROM t_zuzana_szkorupova_project_sql_primary_final
    WHERE name_of_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
    GROUP BY name_of_category, price_year
),
base_data AS (
    SELECT 
        w.payroll_year,
        w.avg_wage,
        p.name_of_category,
        p.avg_price
    FROM avg_wages w
    JOIN avg_prices p
      ON w.payroll_year = p.price_year
    WHERE w.payroll_year in (2006, 2018)
)
SELECT
   	ROUND(avg_wage:: NUMERIC, 2) as round_avg_wage,
	ROUND(avg_price:: NUMERIC, 2) as round_avg_price,
    payroll_year,
    name_of_category,
   	ROUND((avg_wage / avg_price)::NUMERIC, 2) AS amount_can_buy
FROM base_data
ORDER BY
    payroll_year,
    name_of_category;