Select *
From PortfolioProject_Covid..[Covid Deaths]
order by 3,4

--Select *
--From PortfolioProject_Covid..[Covid Vaccinations]
--order by 3,4

-- Select data we are using --

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject_Covid..[Covid Deaths]
order by 1,2


--We are now looking at Total Cases vs Total Deaths --
-- The Death Percentage function shows the likelihood of dying if Covid is contracted --
select location, date, total_cases, total_deaths, (try_cast(total_deaths as decimal(12,2)) / NULLIF(try_cast(total_cases as int),0))*100 as DeathPercentage
from PortfolioProject_Covid..[Covid Deaths]
Where location like '%United Kingdom%'
order by 1,2

-- We will now look at the Total Cases vs Population --
-- This shows the percentage of people who contracted covid --

select location, date, population, total_cases, (try_cast(total_cases as decimal(12,2)) / NULLIF(try_cast(population as int),0))*100 as PopulationPercentage
from PortfolioProject_Covid..[Covid Deaths]
Where location like '%United Kingdom%'
order by 1,2

-- We now want to find out which countries have the highest infection rates compared to population --

select location, population, MAX(total_cases) as HighestInfectionCount, (try_cast(MAX(total_cases) as decimal(12,2)) / NULLIF(try_cast(population as int),0))*100 as InfectionPercentage
from PortfolioProject_Covid..[Covid Deaths]
Group by Location, Population
order by InfectionPercentage desc

-- We now show the countries with the highest death percentage --

SELECT location, CAST(MAX(total_deaths) AS INT) AS TotalDeathCount
FROM PortfolioProject_Covid..[Covid Deaths]
WHERE location NOT LIKE '%Europe%' 
  AND location NOT LIKE '%World%'
  AND location NOT LIKE '%Africa%'
  AND location NOT LIKE '%Asia%'
  AND location NOT LIKE '%European Union%'
  AND location NOT LIKE '%North America%'
  AND location NOT LIKE '%South America%'
  AND location NOT LIKE '%Oceania%'
GROUP BY location, population
ORDER BY TotalDeathCount DESC;

-- Now, we will do he opposite and calculate deaths by continent --

SELECT location, CAST(MAX(total_deaths) AS INT) AS TotalDeathCountCont
FROM PortfolioProject_Covid..[Covid Deaths]
WHERE location IN ('Europe', 'Asia', 'Africa', 'North America', 'South America', 'Oceania')
GROUP BY location, population
ORDER BY TotalDeathCountCont DESC;

-- Calculate global numbers --

Select SUM(cast(new_cases as int)) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(cast(new_cases as int))*100 as DeathPercentage
From PortfolioProject_Covid..[Covid Deaths]
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

