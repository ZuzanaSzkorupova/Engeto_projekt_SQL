--1. tabulka: vytvořená pomoci CTE, klauzule WITH. Došlo k spojení tabulek s daty o mzdách, tabulek s datay o cenách a jejich vzájemnému propojení, čím vznikla finální tabulka
-- za totožné srovnatelné období let 2006 - 2018

CREATE TABLE t_zuzana_szkorupova_project_sql_primary_final AS
WITH payroll AS (
    SELECT 
        AVG(c.value) AS average_wages,
        c.industry_branch_code,
        c3.name AS industry_branch,
        c.unit_code,
        c4.name AS unit_name,
        c.value_type_code,
        c5.name AS value_type_name,
        c.payroll_year
    FROM czechia_payroll AS c
    JOIN czechia_payroll_calculation AS c2
        ON c.calculation_code = c2.code
    JOIN czechia_payroll_industry_branch AS c3
        ON c.industry_branch_code = c3.code
    JOIN czechia_payroll_unit AS c4
        ON c.unit_code = c4.code
    JOIN czechia_payroll_value_type AS c5
        ON c.value_type_code = c5.code
    WHERE c5.code = 5958
    GROUP BY
        c.industry_branch_code,
        c3.name,
        c.unit_code,
        c4.name,
        c.value_type_code,
        c5.name,
        c.payroll_year
),
price AS (
    SELECT
        AVG(c.value) AS price,
        c.category_code,
        c2.name AS name_of_category,
        c2.price_value,
        c2.price_unit,
        EXTRACT(YEAR FROM c.date_from) AS price_year,
        c.region_code
    FROM czechia_price AS c
    JOIN czechia_price_category AS c2
        ON c.category_code = c2.code
    WHERE c.region_code IS NULL
    GROUP BY 
        c.category_code,
        c2.name,
        c2.price_value,
        c2.price_unit,
        EXTRACT(YEAR FROM c.date_from),
        c.region_code
)
SELECT *
FROM payroll
JOIN price
    ON payroll.payroll_year = price.price_year
ORDER BY payroll.payroll_year ASC;
