--spojena tabulka: cz_payroll,cz_payroll_calculation, cz_payroll_industry_branch, cz_payroll_unit, cz_payroll_value_type
--vytovorené view

create view czechia_payroll_view as
select 
	avg(c.value) as average_wages,
	c.industry_branch_code,
	c3.name as industry_branch,
	c.unit_code,
	c4.name as TisOsob_Kč,
	c.value_type_code,
	c5.name as Prum_hruba_mzda,
	c.payroll_year
from 
	czechia_payroll c 
join czechia_payroll_calculation c2 
	on c.calculation_code = c2.code
join czechia_payroll_industry_branch c3 
	on c.industry_branch_code = c3.code 
join czechia_payroll_unit c4 
	on c.unit_code = c4.code
join czechia_payroll_value_type c5 
	on c.value_type_code = c5.code
where c5.code = 5958
group by
	c.industry_branch_code,
	industry_branch,
	c.unit_code,
	TisOsob_Kč,
	c.value_type_code,
	Prum_hruba_mzda,
	c.payroll_year
order by c.payroll_year, industry_branch_code;


--spojena tabulka czechia price: czechia_price, czechia_price_category
--vytvorené view

create view czechia_price_view as
select
	avg(c.value) as price,
	c.category_code, 
	c2."name" as name_of_category,
    c2.price_value,
    c2.price_unit, 
    EXTRACT(YEAR FROM c.date_from) as price_year,
    c.region_code
from 
	czechia_price c 
join czechia_price_category c2 
	on c.category_code = c2.code
where region_code is null
group by 
	c.category_code,
	name_of_category,
	c2.price_value,
	c2.price_unit,
	price_year,
	c.region_code
order by price_year;


--tvorba první tabulky--

create table t_zuzana_szkorupova_project_SQL_primary_final as
select *
from czechia_payroll_view
join czechia_price_view
	on payroll_year = price_year
order by payroll_year asc;

--tabulka 1. vytvorená--

select *
from t_zuzana_szkorupova_project_SQL_primary_final;