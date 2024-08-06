select *
from deaths;

select *
from covidvaccinations;

select *
from coviddeathss;

select * 
from vaccinations;

select location, date, total_cases, new_cases, total_deaths
from deaths
order by 1, 2 ;

-- looking at total cases versus total deaths
-- shows likelihood of dying if you contract covid at your neighbourhood
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_Percentage
from deaths
order by 1, 2 ;

-- Running sum of total number of deaths
select location, date, total_cases, sum(total_cases) over (partition by location order by date) as sum_tot
-- (total_deaths/total_cases) * 100 as Death_Percentage
from deaths
order by 1, 2 ;


-- COUNTRIES WHERE OVERALL DEATH PERCENTAGE IS GREATER THAN 5 
select location, sum(total_cases) as total_cases, sum(total_deaths) as total_deaths, 
sum(total_deaths)/sum(total_cases) * 100 as death_percentage
from deaths
group by location
HAVING (SUM(total_deaths) / SUM(total_cases)) * 100 > 5
order by death_percentage;

-- Looking at Total Cases vs Population
select location, date, total_cases, population, (total_cases/population)*100 as percentage_of_victims
-- (total_deaths/total_cases) * 100 as Death_Percentage
from coviddeaths
where location like '%nigeria%'
order by 1, 2 ;

-- looking at countries with highest infection rates compared to others 
select location, population, max(total_cases) as highest_infection_count, (max(total_cases)/population)*100 as percentage_of_infected
from coviddeaths
where location like "%nigeria%"
group by location, population
order by percentage_of_infected desc;
 
-- looking at countries with their highest death rates
select location, max(cast(total_deaths as signed )) as highest_deaths
from coviddeaths 
where continent is not null
group by location
order by highest_deaths desc;

-- Breaking down by continent
select continent, max(cast(total_deaths as signed )) as highest_deaths, sum(population)
from coviddeaths
where continent is not null
group by continent
order by highest_deaths desc;

-- Global numbers
select date, total_cases, total_deaths, total_deaths/total_cases * 100  as death_percentage
from deaths
order by 1;

select date, sum(new_cases), sum(new_deaths), (sum(new_deaths)/sum(new_cases)) * 100  as death_percentage
from coviddeathss
group by date
order by 2;

select sum(new_cases), sum(cast(new_deaths as signed)), (sum(new_deaths)/sum(cast(new_cases as signed))) * 100  as death_percentage
from coviddeaths
-- group by date
where continent is not null
order by 1,2;

SELECT *
FROM vaccinations AS vac
JOIN coviddeaths AS dea
ON vac.location = dea.location
AND vac.date = dea.date;






