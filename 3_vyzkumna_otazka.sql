--3. Q Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? --

with prices_per_year as (
    select
        price_year,
        name_of_category,
        avg(price) as average_price
    from t_zuzana_szkorupova_project_sql_primary_final
    group by
        price_year,
        name_of_category
),
lag_price as (
    select
        price_year,
        name_of_category,
        average_price,
        lag(average_price) over (
            partition by name_of_category
            order by price_year
        ) as price_last_year
    from prices_per_year
),
growth_calculation as (
	select
    	name_of_category,
    	price_year,
    	average_price,
    	price_last_year,
   	 case
        when price_last_year is null or price_last_year = 0 then null
        else (average_price - price_last_year) / price_last_year * 100 
        end as growth_rate
	from lag_price
)
select 
	name_of_category, 
	avg(growth_rate) as avg_growth_rate
from growth_calculation
where growth_rate is not null and growth_rate >= 0
group by name_of_category
order by avg_growth_rate asc;