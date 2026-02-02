--4.Q Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?--
	
with wages_price_per_year as (
	select 
		avg(average_wages) as avg_wages,
		avg(price) as avg_price,
		payroll_year,
		price_year
	from t_zuzana_szkorupova_project_sql_primary_final
	group by 
		payroll_year,
		price_year
	order by payroll_year, price_year
),
lag_wages_price as (
	select
		avg_wages,
		avg_price,
		payroll_year,
		price_year,
		lag(avg_wages) over (
            order by payroll_year
        ) as wages_last_year,
        lag(avg_price) over (
        	order by price_year
        ) as price_last_year
	from wages_price_per_year
),
growth_calculation as (
	select
		payroll_year,
    	price_year,
    	avg_wages,
    	avg_price,
    case
        when wages_last_year is null or wages_last_year = 0 then null
        else (avg_wages - wages_last_year) / wages_last_year * 100 
        end as growth_rate_wages,
    case
        when price_last_year is null or price_last_year = 0 then null
        else (avg_price - price_last_year) / price_last_year * 100 
        end as growth_rate_price
	from lag_wages_price 
)
select
	payroll_year as year,
	growth_rate_wages,
	growth_rate_price,
	abs(growth_rate_wages - growth_rate_price) as differences
from growth_calculation
order by differences;