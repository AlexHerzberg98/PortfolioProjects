Select * 
From master..Covid_Deaths
Where continent is not NULL
order by 3,4 

Select * 
From master..Covid_Vacc
order by 3,4 

-- Select Data that we are going to be using 

Select Location, date , total_cases ,total_deaths , population
From master..Covid_Deaths
order by 1,2 


-- Looking at Total Cases vs. Total Deaths 
SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF

Select Top(100) Location, date , total_cases ,total_deaths , (total_deaths/total_cases) *100 as DeathPercentage
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
order by 1,2 


-- Looking at Total Cases vs. Population 
SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF

Select Top(100) Location, date ,population, total_cases , (total_cases/population) *100 as Percentage_of_Population_got_infected
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
order by 1,2 

--Looking at Countrys with Highest Infection Rate compared to Population

SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF

Select Top(100) Location, population, MAX(total_cases) as HighestInfectionCount , MAX((total_cases/population)) *100 as MaxPercentage_of_Population_got_infected
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
Group by Location , Population
order by MAXPercentage_of_Population_got_infected desc


-- Shoing the Countries with Highest Death Count per Population 

Select Location, MAX(Total_deaths) as TotalDeathCount
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
Group by Location 
order by TotalDeathCount desc

-- Breaking down by Continent

Select location, MAX(Total_deaths) as TotalDeathCount
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is NULL
Group by location 
order by TotalDeathCount desc



-- Global numbers 

Select  SUM(new_cases) as SumNewCases , SUM(new_deaths) as SumNewDeath, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentageGlobal
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
--Group by date
order by 1,2 


-- Looking at Total Population vs Vaccinations


Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent , dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPopleVaccinated
From master..Covid_Deaths dea
Join  master..Covid_Vacc vac 
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null

Select * , (RollingPopleVaccinated/Population)*100 as RollingPopleVaccinatedGlobal
From #PercentPopulationVaccinated
--Where location like '%Germany%'


-- Looking at the poeple who not Fully Vaccinated

Select dea.Location , dea.date ,dea.population, cast(people_vaccinated as int) as PeoplePartlyVacc , Cast(people_fully_vaccinated as int) as PeopleFullyVacc, (cast(people_vaccinated as int)-Cast(people_fully_vaccinated as int)) as PeoplepartlyVacc
From master..Covid_Vacc vac
JOIN master..Covid_Deaths dea
	ON dea.location = vac.location
	and dea.date = vac.date
--Where dea.location like '%Germany%' -- If you want to know the Data for a specific Country--
Where dea.continent is not NULL
order by 1,2 


-- Creating View to Store data for later Visulizations

Create View PercentPopulationVaccinated as 
Select dea.continent , dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPopleVaccinated
From master..Covid_Deaths dea
Join  master..Covid_Vacc vac 
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


Create View DeathPercentage as

Select Location, date , total_cases ,total_deaths , (total_deaths/total_cases) *100 as DeathPercentage
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL

Create View Percentage_of_Population_got_infected as

Select Location, date ,population, total_cases , (total_cases/population) *100 as Percentage_of_Population_got_infected
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL

Create View DeathPercentageGlobal as
Select  SUM(new_cases) as SumNewCases , SUM(new_deaths) as SumNewDeath, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentageGlobal
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL


Create view MaxPercentage_of_Population_got_infected as
Select Top(100) Location, population, MAX(total_cases) as HighestInfectionCount , MAX((total_cases/population)) *100 as MaxPercentage_of_Population_got_infected
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
Group by Location , Population
order by MAXPercentage_of_Population_got_infected desc


Create View TotalDeathCount as 
Select Location, MAX(Total_deaths) as TotalDeathCount
From master..Covid_Deaths
--Where location like '%Germany%' -- If you want to know the Data for a specific Country--
Where continent is not NULL
Group by Location 

