--2. Q Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední 
--srovnatelné období v dostupných datech cen a mezd?--

select *
from t_zuzana_szkorupova_project_sql_primary_final t 

--vytvořené view, ve kterém jsou průměrné mzdy za jednotlivé období v letech--

create view avg_wages_branch_year as
select 
	avg(t.average_wages),
	t.industry_branch_code, 
	t.industry_branch,
	t.payroll_year
from t_zuzana_szkorupova_project_sql_primary_final t 
group by t.industry_branch,
	t.industry_branch_code,
	t.payroll_year
order by t.payroll_year, t.industry_branch_code;

--vytvorené view, ve kterém jsou jenom vybrané kategórie a jejich průměrné ceny v letech--

create view avg_price_category_year as
select 
	avg(price),
	name_of_category,
	price_year
from t_zuzana_szkorupova_project_sql_primary_final t 
where name_of_category in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
group by name_of_category, price_year
order by price_year;

--spojené view--

select *
from avg_wages_branch_year a 
	join avg_price_category_year a2 
	on a.payroll_year = a2.price_year
where payroll_year in (2006, 2018)
order by payroll_year ;

--pomoci with výpočet množství chleba a mléka, které lze koupit za průměrné mzdy v jednotlivých odvětvích v letech 2006 a 2018--

with base_data as (
	select 
		a.industry_branch,
        a.industry_branch_code,
        a.payroll_year,
        a.avg as avg_wage,
        a2.name_of_category,
        a2.avg as avg_price
	from avg_wages_branch_year a 
		join avg_price_category_year a2 
		on a.payroll_year = a2.price_year
	where payroll_year in (2006, 2018)
)
	select
    	industry_branch,
    	industry_branch_code,
    	payroll_year,
    	name_of_category,
    	(avg_wage / avg_price) as amount_can_buy
	from base_data
	where name_of_category in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	order by
    	industry_branch_code,
    	payroll_year,
   		name_of_category;