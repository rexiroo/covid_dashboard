SELECT *
FROM covid_project.covid_deaths 
ORDER BY 3,4

SELECT *
FROM covid_project.covid_vaccinations
ORDER BY 3,4



-- Selecting Data

SELECT location , `date` , total_cases, new_cases, total_deaths, population  
FROM covid_project.covid_deaths
ORDER BY 1,2



-- Total Cases vs. Total Deaths by date
-- Likelihood of Dying if You Contract COVID in United States

SELECT location , `date` , total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM covid_project.covid_deaths
WHERE location like '%states%'
AND continent is not NULL 
ORDER BY 1,2



-- Worldwide Total Cases vs. Total Deaths, Death Percentage 

SELECT location, MAX(total_cases) as total_case_count, MAX(total_deaths) as total_death_count, (MAX(total_deaths)/MAX(total_cases))*100 as death_percentage
FROM covid_project.covid_deaths
WHERE location like 'World' 
ORDER BY `date` DESC 



-- Total Cases vs. Population
-- Percentage of Population Infected with COVID in United States

SELECT location, `date`, population, total_cases, (total_cases/population)*100 as infection_percentage
FROM covid_project.covid_deaths
WHERE location like '%states%'
AND continent is not NULL 
ORDER BY 1,2



-- Countries with Highest Infection Reate compared to Population

SELECT location, population, `date`, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as percent_population_infected
FROM covid_project.covid_deaths
GROUP BY  location, population 
ORDER BY percent_population_infected DESC 



-- Countries with Highest Death Count per Population

SELECT location, MAX(total_deaths) as total_death_count
FROM covid_project.covid_deaths
GROUP BY location 
ORDER By total_death_count desc



-- Group Data by Continents

SELECT iso_code, location, MAX(total_deaths) as total_death_count
FROM covid_project.covid_deaths
WHERE continent = ''
AND location not like '%income%' 
AND location not like 'International'
GROUP BY location  
ORDER By total_death_count desc



-- Global Numbers by Date

SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentage
FROM covid_project.covid_deaths
WHERE continent = ''
AND location not like '%income%' 
AND location not like 'International'
GROUP by `date` 
ORDER by 1,2



-- Total % of Population Vaccinated by Continent

SELECT cd.location, cd.population, MAX(CONVERT(cv.people_vaccinated, SIGNED)) as total_people_vaccinated, MAX(CONVERT(cv.people_vaccinated, SIGNED))/cd.population*100 as percent_pop_vaccinated
FROM covid_project.covid_vaccinations cv
JOIN covid_project.covid_deaths cd 
	ON cd.location = cv.location 
	AND cd.date = cv.date
WHERE cd.continent = ''
AND cd.location not like '%income%' 
AND cd.location not like 'International'
GROUP BY cd.location  
ORDER By 2 DESC  






