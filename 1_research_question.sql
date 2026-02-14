--1. Q Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?--

WITH wages_per_year AS (
    SELECT
        payroll_year,
        industry_branch,
        industry_branch_code,
        ROUND(AVG(average_wages),2) as average_wages
    FROM t_zuzana_szkorupova_project_sql_primary_final
    GROUP BY
        payroll_year,
        industry_branch,
        industry_branch_code
),
wage_lag AS (
    SELECT
        payroll_year,
        industry_branch,
        industry_branch_code,
        average_wages,
        LAG(average_wages) OVER (
            PARTITION BY industry_branch
            ORDER BY payroll_year
        ) AS wage_last_year
    FROM wages_per_year
)
SELECT
    industry_branch,
    industry_branch_code,
    payroll_year,
    average_wages,
    wage_last_year,
    CASE
        WHEN wage_last_year IS NULL THEN  'prvni_sledovany_rok'
        WHEN average_wages > wage_last_year THEN 'roste'
        WHEN average_wages < wage_last_year THEN 'klesa'
        ELSE 'beze_zmeny'
    END AS trend_wage
FROM wage_lag
ORDER BY industry_branch_code, payroll_year;