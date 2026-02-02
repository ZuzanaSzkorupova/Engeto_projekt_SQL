--1. Q Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?--

with wages_per_year as (
    select
        payroll_year,
        industry_branch,
        industry_branch_code,
        avg(average_wages) as average_wages
    from t_zuzana_szkorupova_project_sql_primary_final
    group by
        payroll_year,
        industry_branch,
        industry_branch_code
),
wage_lag as (
    select
        payroll_year,
        industry_branch,
        industry_branch_code,
        average_wages,
        lag(average_wages) over (
            partition by industry_branch
            order by payroll_year
        ) as wage_last_year
    from wages_per_year
)
select
    industry_branch,
    industry_branch_code,
    payroll_year,
    average_wages,
    wage_last_year,
    case
        when wage_last_year is null then 'prvni_sledovany_rok'
        when average_wages > wage_last_year then 'roste'
        when average_wages < wage_last_year then 'klesa'
        else 'beze_zmeny'
    end as trend_wage
from wage_lag
order by industry_branch_code, payroll_year;