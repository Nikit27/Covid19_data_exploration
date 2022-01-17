--TO VIEW FULL DATASET
select* from Projectportfolio..coviddeaths
order by 3,4

--TO VIEW FULL DATASET
select* from Projectportfolio..covidvaccine
order by 3,4


select location,date,total_cases, new_cases ,population,total_deaths
from Projectportfolio..coviddeaths
order by 1,2

--TOTAL CASES VS TOTAL DEATHS ,trying to find percentage of people died who got infected by covid in india

select location ,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
from Projectportfolio..coviddeaths
where location='india'
order by 1,2

--TOTAL CASES VS POPULATION
--Shows what percentage of population got infected by covid in india

select location ,date,total_cases,population,(total_cases/population)*100 as Infection_percentage
from Projectportfolio..coviddeaths
where location='india'
order by 1,2


--Which country has highest Infection percentage as compared to its Populatiuon and their highest infection count

  select location ,population ,MAX(total_cases) as highestinfectioncount,max((total_cases/population)*100) as Infection_percentage
  from Projectportfolio..coviddeaths
  where continent is not null
  group by  location ,population
  order by  Infection_percentage desc


  -- Showing Countries with highest death count per population and casting total deaths to int data type
    
	
  select location ,population ,MAX(cast(total_deaths as int)) as highestdeathcount ,max((total_deaths/population)*100) as Death_percentage
  from Projectportfolio..coviddeaths
  where continent is not null
  group by  location ,population
  order by  Death_percentage desc

  -- When processing this query we realised that we are getting continents in location colomn figuring this issue we found that
  -- colomns where continents is null and instead of location of country there is continent so we will filter this .

  --TOTAL DEATHS VS COUNTRY
  
  select location  ,MAX(cast(total_deaths as int)) as highestdeathcount 
  from Projectportfolio..coviddeaths
  where continent is not null
  group by  location 
  order by highestdeathcount desc

  --TOTAL DEATHS VS CONTINENTS
  
  select continent  ,MAX(cast(total_deaths as int)) as highestdeathcount 
  from Projectportfolio..coviddeaths
  where continent is not null
  group by  continent 
  order by highestdeathcount desc
  

--NEW CASES ACROSS THE WORLD VS DATE and trying to find on which date we got maximum new cases and minimum new cases


  select date,new_cases
  from Projectportfolio..coviddeaths
  where location='india'
  order by new_cases desc
  

  --NEW CASES AND NEW DEATHS VS DATE, we came to know that data type of new deaths is VARCHAR so we will convert it into int.

   select date,new_cases,cast(new_deaths as int) as new_deaths
  from Projectportfolio..coviddeaths
  where continent is not null
  order by  new_deaths desc

  --TOTAL CASES AND TOTAL DEATHS BY DATE in world

     select date,sum(new_cases),sum(cast(new_deaths as int)) 
  from Projectportfolio..coviddeaths
  where continent is not null
  group by date
  order by date desc

  ----VACCINATED PEOPLE IN EACH COUNTRY 
  select dea.location,sum( cast(vac.total_vaccinations as bigint)) as total_no_vaccinations
  from Projectportfolio..coviddeaths  dea
  join
  Projectportfolio..covidvaccine  vac
  on
  dea.location=vac.location
  and 
  dea.date=vac.date
  group by dea.location

    --PERCENTAGE OF PEOPLE VACCINATED PEOPLE IN EACH COUNTRY PERDAY

	 select dea.location, max((cast(vac.people_vaccinated as bigint)/vac.population)*100) as percentage_vaccinations
  from Projectportfolio..coviddeaths  dea
  join
  Projectportfolio..covidvaccine  vac
  on
  dea.location=vac.location
  and 
  dea.date=vac.date
  where dea.continent is not null
 
  
  group by dea.location
  


  
  

  


  





  