# Engeto_projekt_SQL
SQL projekt pre Engeto kurz - Datová Akademie

## Zadání projektu

Na analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní obyvatel, bylo rozhodnuto pokusit se odpovědět na několik předem definovaných výzkumných otázek zaměřených na dostupnost základních potravin pro širokou veřejnost. Tyto otázky byly připraveny kolegy s cílem poskytnout relevantní a srozumitelné informace tiskovému oddělení, které bude výsledky prezentovat na nadcházející odborné konferenci věnované této problematice.

Vaším úkolem je připravit robustní datové podklady, které umožní porovnání dostupnosti potravin na základě průměrných příjmů obyvatel v definovaném časovém období.

Jako doplňkový materiál je požadováno zpracování tabulky obsahující údaje o HDP, GINI koeficientu a velikosti populace dalších evropských států ve stejném období, které budou sloužit jako kontextový přehled k primární analýze zaměřené na Českou republiku.

## Výzkumné otázky

1. Rostou mzdy v průběhu sledovaných let ve všech odvětvích, nebo v některých odvětvích naopak klesají?

2. Kolik litrů mléka a kilogramů chleba je možné si zakoupit za průměrnou mzdu v prvním a posledním srovnatelném období dostupných dat o cenách a mzdách?

3. Která kategorie potravin zdražuje nejpomaleji, tedy vykazuje nejnižší meziroční procentuální nárůst cen?

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (o více než 10 %)?

5. Má výše HDP vliv na změny ve mzdách a cenách potravin? Jinými slovy, projeví se výraznější růst HDP v daném roce na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším tempem růstu?

## Řešení projektu

V rámci řešení projektu byly v databázi nejprve vytvořeny dvě základní tabulky, ze kterých byla následně čerpána potřebná data pro analýzu.

První tabulka obsahuje údaje o mzdách v jednotlivých odvětvích a cenách vybraných potravin v České republice za období let 2006–2018. [Tabulka_mzdy_ceny](1_table_mzdy_ceny.sql)

Druhá tabulka zahrnuje data o hrubém domácím produktu (HDP), GINI koeficientu a velikosti populace vybraných evropských zemí ve stejném časovém období, tedy v letech 2006–2018. [Tabulka_hdp_gini_populace](2_table_gdp_GINI_population_Europe.sql)

### Odpovědi na výzkumné otázky:

**1. Rostou mzdy v průběhu sledovaných let ve všech odvětvích, nebo v některých odvětvích naopak klesají?**

[SQL_script](1_vyzkumna_otazka.sql)

Ve sledovaném období 2006–2018 mzdy v rámci jednotlivých odvětví **ve většině případů rostly**. Přesto lze ojediněle pozorovat meziroční pokles mezd, například:  

- **Zemědělství**: 2009  
- **Těžba a dobývání**: 2009, 2013, 2014, 2016  
- **Výroba a rozvod elektřiny a plynu**: 2013, 2015  
- **Stavebnictví**: 2013  
- **Velkoobchod**: 2013  

V každém odvětví se tedy spíše jedná o **jednorázové meziroční výkyvy**. Z dlouhodobého hlediska můžeme tvrdit, že mzdy mají **rostoucí charakter** ve všech sledovaných odvětvích.

**2. Kolik litrů mléka a kilogramů chleba je možné si zakoupit za průměrnou mzdu v prvním a posledním srovnatelném období dostupných dat o cenách a mzdách?**

Ve druhé výzkumné otázce je vhodné zodpovědět otázku **v rámci sledovaných odvětví**, vzhledem k odlišnostem mezd mezi nimi. Výsledná tabulka, kterou lze získat pomocí [SQL_script](2_vyzkumna_otazka.sql) , ukazuje například, že:  

- V **odvětví zemědělství** bylo možné v roce 2006 koupit přibližně **907 ks chleba** a **1012 l mléka**, zatímco v roce 2018 to bylo **1043 ks chleba** a **1276 l mléka**.  
- V **odvětví informační a komunikační činnosti** bylo možné v roce 2006 koupit **2193 ks chleba** a **2450 l mléka**, zatímco v roce 2018 to bylo **2315 ks chleba** a **2831 l mléka**.

**3. Která kategorie potravin zdražuje nejpomaleji, tedy vykazuje nejnižší meziroční procentuální nárůst cen?**

Za sledované období nejpomaleji zdražuje kategorie potravin **„Jakostní víno bílé“** s nárůstem **2,7 %**.  

Výsledky jsou dostupné pomocí SQL skriptu: [SQL_script](3_vyzkumna_otazka.sql)

**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (o více než 10 %)?**

V roce 2013 můžeme pozorovat **pokles mezd o 1,55 %**, zatímco **ceny potravin rostly o 5,10 %**.  

Naopak v roce 2009 došlo k **růstu mezd o 3,16 %** a **poklesu cen potravin o 6,41 %**.  

Komplexní výsledná tabulka je dostupná pomocí [SQL_script](4_vyzkumna_otazka.sql)

**5. Má výše HDP vliv na změny ve mzdách a cenách potravin? Jinými slovy, projeví se výraznější růst HDP v daném roce na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším tempem růstu?**

Z tabulky vyplývá, že **růst HDP se častěji promítá do růstu mezd než do růstu cen potravin**. Vyšší růst HDP je většinou doprovázen růstem mezd, často však až v následujícím roce. **U cen potravin se jednoznačná souvislost s HDP neprokazuje**, protože jejich vývoj kolísá i v letech silného hospodářského růstu. **Jednoznačné závěry by však bylo možné potvrdit až po provedení podrobnější statistické analýzy**. Data jsou dostupná: [SQL_script](5_vyzkumna_otazka.sql)









