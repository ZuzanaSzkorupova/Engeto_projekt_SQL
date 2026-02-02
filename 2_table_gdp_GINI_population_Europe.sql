--tvorba druhé - dodatečné tabulky--

create table t_zuzana_szkorupova_project_SQL_secondary_final as
select 
	e.country,
	e.year,
	e.gdp,
	e.gini,
	e.population
from economies e 
join countries c 
	on c.country = e.country
where c.continent = 'Europe'
	and e."year" between 2006 and 2018
order by country, year;

-- tabulka 2. vytvorená--

select *
from t_zuzana_szkorupova_project_sql_secondary_final t ;