--tvorba druhé - dodatečné tabulky - tabulka vznikla spojením tabulky ecnomies a countries. Spojení jsem provedla přes sloupce country
--data jsou selectované jenom za kontinent Evropy a za časové období 2006 - 2018.

CREATE TABLE t_zuzana_szkorupova_project_SQL_secondary_final AS
SELECT
	e.country,
	e.year,
	e.gdp,
	e.gini,
	e.population
FROM economies e 
JOIN countries c 
	ON c.country = e.country
WHERE c.continent = 'Europe'
	AND e."year" BETWEEN 2006 AND 2018
ORDER BY country, year;

-- tabulka 2. vytvorená--

SELECT *
FROM t_zuzana_szkorupova_project_sql_secondary_final t ;