--5. Q Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
-- projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?--

--vytovořené view pro GDP za ČR--

create view GDP_Czechia_5_Q as 
select 
	distinct year,
	country,
	gdp
	from t_zuzana_szkorupova_project_sql_secondary_final t 
where country like 'Cze%';

--vytvorené view pro AVG_mzdy a ceny--
 
create view avg_wages_price_5_Q as
select 
	avg(average_wages) as avg_wages,
	avg(price) as avg_price,
	price_year
from t_zuzana_szkorupova_project_sql_primary_final t 
group by 
		price_year 
order by price_year;
	
--vytvoření joinu z view--

select 
	g.year,
	g.country,
	g.gdp,
	a.avg_price,
	a.avg_wages
from gdp_czechia_5_q g 
join avg_wages_price_5_q a 
	on g."year" = a.price_year
order by g.year;

--dotaz ze zadání nad joinem--

with based_data as (
	select 
	g.year,
	g.country,
	g.gdp,
	a.avg_price,
	a.avg_wages
from gdp_czechia_5_q g 
join avg_wages_price_5_q a 
	on g."year" = a.price_year
order by g.year
),
lag_wages_price_gdp as (
	select
		year,	
		avg_wages,
		avg_price,
		gdp,
		lag(avg_wages) over (
            order by year
        ) as wages_last_year,
        lag(avg_price) over (
        	order by year
        ) as price_last_year,
        lag(gdp)over (
        	order by year
        ) as gdp_last_year
	from based_data
)
select
	year,
    avg_wages,
    avg_price,
    gdp,
    case
        when wages_last_year is null or wages_last_year = 0 then null
        else (avg_wages - wages_last_year) / wages_last_year * 100 
        end as growth_rate_wages,
    case
        when price_last_year is null or price_last_year = 0 then null
        else (avg_price - price_last_year) / price_last_year * 100 
        end as growth_rate_price,
    case
    	when gdp_last_year is null or gdp_last_year = 0 then null
        else (gdp - gdp_last_year) / gdp_last_year * 100 
        end as growth_rate_gdp
from lag_wages_price_gdp;
