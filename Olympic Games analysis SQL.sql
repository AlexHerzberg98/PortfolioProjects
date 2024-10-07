
-- How many Men and Women started at the Olympics?

Select *

From [Olympic Sports and Medals]..winter JOIN [Olympic Sports and Medals]..summer 
on winter.Athlete = summer.Athlete

-- Summergames

Select Count(*) as MenStartedSummerGames
From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer 
on dictionary.code = summer.code 
Where Gender = 'Men' 

Select Count(*) as WomenStaredSummerGames
From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer 
on dictionary.code = summer.code 
Where Gender = 'Women' 

--Wintergames

Select Count(*) as MenStartedSummerGames
From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code 
Where Gender = 'Men' 

Select Count(*) as WomenStaredSummerGames
From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code 
Where Gender = 'Women' 



-- Which Men/Women won the most Goldmedals at the Summergames?

Select Top 10  Country , Athlete ,  Gender, Medal ,Count( Medal) AS Medal_win

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer  
on dictionary.code = summer.code

Where Medal = 'Gold' and Gender = 'Men'
Group by Country, Athlete , Medal , Gender
Order by Medal_win desc


Select Top 10  Country , Athlete ,  Gender, Medal ,Count( Medal) AS Medal_win

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer  
on dictionary.code = summer.code

Where Medal = 'Gold' and Gender = 'Women'
Group by Country, Athlete , Medal , Gender
Order by Medal_win desc

-- Which Men/Women won the most Goldmedals at the Wintergames?

--Men 

Select Top 10  Country , Athlete ,  Gender, Medal ,Count( Medal) AS Medal_win

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter  
on dictionary.code = winter.code

Where Medal = 'Gold' and Gender = 'Men'
Group by Country, Athlete , Medal , Gender
Order by Medal_win desc

--Women

Select Top 10  Country , Athlete ,  Gender, Medal ,Count( Medal) AS Medal_win

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code

Where Medal = 'Gold' and Gender = 'Women'
Group by Country, Athlete , Medal , Gender
Order by Medal_win desc


-- Which Country has won the most Gold, Silver and Bronze Medal at the Wintergames?

--Gold

Select Top 3  Country , Medal , Count(Country) AS Country_gold_winter

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code

Where Medal = 'Gold'
Group by Country , Medal 
Order by Country_gold_winter desc

--Silver


Select Top 3  Country , Medal , Count(Country) AS Country_silver_winter

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code

Where Medal = 'Silver'
Group by Country , Medal 
Order by Country_silver_winter desc

--Bronze

Select Top 3  Country , Medal , Count(Country) AS Country_bronze_winter

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..winter 
on dictionary.code = winter.code

Where Medal = 'Bronze'
Group by Country , Medal 
Order by Country_bronze_winter desc


-- Which Country has won the most Gold, Silver and Bronze Medal at the Summergames?

Select Top 3  Country , Medal , Count(Country) AS CountryGoldMedal

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer  
on dictionary.code = summer.code

Where Medal = 'Gold'
Group by Country , Medal 
Order by CountryGoldMedal desc


Select Top 3  Country , Medal , Count(Country) AS CountrySilverMedal

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer  
on dictionary.code = summer.code

Where Medal = 'silver'
Group by Country , Medal 
Order by CountrySilverMedal desc


Select Top 3  Country , Medal , Count(Country) AS CountryBronzeMedal

From [Olympic Sports and Medals]..dictionary JOIN [Olympic Sports and Medals]..summer  
on dictionary.code = summer.code

Where Medal = 'bronze'
Group by Country , Medal 
Order by CountryBronzeMedal desc



