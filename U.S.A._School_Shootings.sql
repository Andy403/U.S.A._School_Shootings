create database USschshoot_Data;
exec sp_databases
Use Lab4

create database Lab4
exec sp_databases

select * from dataset

--## DROPPING UNREQUIRED COLUMNS #################################################################

ALTER TABLE dataset
DROP COLUMN NCESSCH; --- NCESSCH Column was dropped from my data set

ALTER TABLE dataset
drop column LONCOD;  --- LONCOD Column was dropped from my data set

ALTER TABLE dataset
drop column LATCOD;  --- LATCOD Column was dropped from my data set

ALTER TABLE dataset
drop column CDCODE;  --- CDCODE Column was dropeed from my data set 


--## CHECKING FOR NULL VALUES ####################################################################
--I checked for Null values on specific variables I intend to manipulate

Select race
from dataset
where race is NULL; -- 7 Null values were found in Race

Select time
from dataset
where time is NULL; -- 6 Null values were found in time

Select victims
from dataset
where victims is NULL; -- No Null values for Victims

Select injured
from dataset
where injured is NULL; -- No Null values for Injured

Select date
from dataset
where date is NULL; -- No Null values for Date

Select address
from dataset
where address is NULL; -- No Null values for address

Select year
from dataset
where year is NULL; -- No Null values for year

Select urbanrural
from dataset
where urbanrural is NULL; -- 3 Null values were found for Urbanrural

Select school
from dataset
where school is NULL; -- No Null values for school

Select type
FROM dataset
where type is NULL; -- No Null values for type

Select city
FROM dataset
where City is NULL; -- No Null values for city

Select state
FROM dataset
where state is NULL; -- No Null values for State


--## PUTTING VALUES IN NULL RECORDS ###################################################################################

UPDATE dataset
SET race = 'Not Available'
where race IS NULL;

select urbanrural,state,school,city
from dataset
where urbanrural IS NULL;

UPDATE dataset
SET urbanrural = 'Urban'
where school = 'JFK Stadium';

UPDATE dataset
SET urbanrural = 'rural'
where school = 'Smalls Athletic Field';

select trim(Upper(race)) as Ethnicity_of_Shooter
from dataset



--## CHECKING THE UPDATE TO 'NOT AVAILABLE' ###########################################################################
select race from dataset
where race = 'Not available' -- The seven Null records were updated

--## CHANGING A STRING IN RACE COLUMN #################################################################################

UPDATE dataset
SET race = 'HISPANIC'
where race ='Hisp' -- Changed abbreviation of 'Hisp' to 'HISPANIC' in the race column

--## CHECKING THE STRING LENGTHS FOR MY RACE VARIABLE TO ASCERTAIN THAT THEY ARE IN ORDER ###########################

select len(race),race
from dataset
where len(race) between 5 and 8;

select len(race),race
from dataset
where len(race) > 8;

--**************************************** INSIGHTS *********************************************************
select * from dataset

--COUNT OF ETHNICITY OF SHOOTERS 

Select CONCAT ('The', ' ', 'count' , ' ', 'of',
' ', 'shooters of Black Ethicity', ' ', 'is') as Description, 
count(*) AS Number_of_Shooters
from dataset
Where race = 'Black'

--===========================================================================================================
--The count of shooters of Black ethnicity is 68
--===========================================================================================================

Select CONCAT ('The', ' ', 'count' , ' ', 'of',
' ', 'shooters of White Ethicity', ' ', 'is') as Description, 
count(*) AS Number_of_Shooters
from dataset
Where race = 'White'

--===========================================================================================================
--The count of shooters of White ethnicity is 73
--===========================================================================================================

Select CONCAT ('The', ' ', 'count' , ' ', 'of',
' ', 'shooters who are Hispanics', ' ', 'is') as Description, 
count(*) AS Number_of_Shooters
from dataset
Where race = 'Hispanic'

--===========================================================================================================
--The count of shooters of White ethnicity is 31
--===========================================================================================================

select school,type,city,state, year,race as Ethnicity_of_Shooter,killed as Persons_killed,Injured as Pesrons_injured,
(killed + injured) as Total_no_of_Victims from dataset
where race = 'Black' 
Group by school,type,city,state,year,race,killed,injured
order by year desc;

select school,type,city,state, year,race as Ethnicity_of_Shooter,killed as Persons_killed,Injured as Pesrons_injured,
(killed + injured) as Total_no_of_Victims from dataset
where race = 'White' 
Group by school,type,city,state,year,race,killed,injured
order by year desc;

select school,type,city,state, year,race as Ethnicity_of_Shooter,killed as Persons_killed,Injured as Pesrons_injured,
(killed + injured) as Total_no_of_Victims from dataset
where race = 'Hispanic' 
Group by school,type,city,state,year,race,killed,injured
order by year desc;


--Total Sum of shooting victims across all schools grouped by State 

SELECT school ,type, state,address,SUM(victims) AS TOTAL_NO_OF_VICTIMS,year
FROM dataset 
GROUP BY state, school,type,address,year 
ORDER BY TOTAL_NO_OF_VICTIMS DESC

select school, type, city, state, injured as Number_Injured, killed as Number_Killed, race as Ethnicity_of_Shooter, 
(killed + injured) as Total_No_of_Victims, year
from dataset
where killed > 5
ORDER BY TOTAL_NO_OF_VICTIMS DESC;

-=======================================================================================
--Majory Stoneman Douglas High School had the highest number of shooting victims with 31 
-=======================================================================================

-- Sum of shooting victims differentiated as Killed and Injured across all schools 

SELECT school ,type, state,address,sum(killed) AS Total_No_of_Persons_Killed, sum(injured) AS Total_No_of_Persons_Injured,year 
FROM dataset 
GROUP BY state, school,type,address,year 
ORDER BY Total_No_of_Persons_Killed DESC

-==============================================================================================================================================
--Sandy Hook Elementary School had the higest number of Persons Killed at 26 while Majory Stoneman Douglas High School and Marshall County High
--School had the highest number of persons injured at 14 
-==============================================================================================================================================

--Which State has the highest number of shootings

SELECT STATE, sum(victims) AS Highest_Percentage_of_Shootings 
FROM dataset WHERE victims >2 
GROUP BY STATE 
ORDER BY Highest_Percentage_of_Shootings DESC 

-==============================================================================================================================================
--The State of Florida had the highest number of shootings at 31
-==============================================================================================================================================

--Which year had the highest number of shootings

select year, count(*) as Year_with_Highest_Number_of_Shootings
from dataset
group by year
order by Year_with_Highest_Number_of_Shootings desc

-==============================================================================================================================================
--Year 2016 had the highest number of shootings with 35 recorded cases in the dataset
-==============================================================================================================================================

--School locations with the highest number of shootings 

select urbanrural as Counties_with_the_highest_Count_of_Shootings, count(*) as Count_of_Shootings
from dataset
group by urbanrural
order by Count_of_Shootings desc

-==============================================================================================================================================
--Schools located in Urban counties recorded the highest number of shooting incidents while those in rural counties had the least number of
--incidents
-==============================================================================================================================================

select distinct time, count(*) as Count_of_when_most_of_the_Shootings_occur
from dataset
group by time
order by Count_of_when_most_of_the_Shootings_occur desc

-==============================================================================================================================================
--The data showed that most of the shootings occured around 3:00 pm
-==============================================================================================================================================

select distinct type, count(*) as Count_of_which_type_of_School_records_the_highest_no_of_shootings
from dataset
group by type
order by Count_of_which_type_of_school_records_the_highest_no_of_shootings desc

-==============================================================================================================================================
--The data showed that most of the shootings occured in High Schools
-==============================================================================================================================================   ,


--************************************************ CONTROL PROCEDURE **************************************************************************

select state,school,year from dataset
group by state, school, year
order by year,state

CREATE PROCEDURE dbo.USSchshoot
@state as nvarchar(50), @year as int
AS
Select school, type, city,address,(killed + injured) as Total_No_of_Victims, race as Ethnicity_of_Shooter,date,time from dataset
where state = @state and year = @year
GO

exec dbo.USSchshoot @year = 2015, @state = 'New York'


--***************************************************** FUNCTIONS *****************************************************************************

CREATE FUNCTION GetdataSchShootings (
	@year int
)
RETURNS TABLE
AS
RETURN SELECT school, type, city, state, address, urbanrural as County, race as Ethnicity_of_Shooter, (killed + injured) as Total_no_of_Victims,
date,time from dataset
where year = @year

select * from GetdataSchShootings(2018)
GO

select * from dataset


--************************************************ USING THE WINDOWS FUNCTION TO RANK ************************************************************

Select school,type,state,address,race as Ethnicity_of_Shooter,year,
sum(victims)
OVER(PARTITION BY state order by type,victims asc) as Total_No_of_Victims
from dataset


Select school, type,state,address,race as Ethnicity_of_Shooter,year,(killed+injured) as victims,
ROW_NUMBER() OVER(PARTITION BY state order by victims) AS Rownumber,
RANK() OVER(PARTITION BY state order by victims asc) AS Rank_Row
from dataset


Select school, type,state,address,race as Ethnicity_of_Shooter,year,(killed+injured) as victims,
ROW_NUMBER() OVER(PARTITION BY state order by victims) AS Rownumber,
RANK() OVER(PARTITION BY state order by victims asc) AS Rank_Row,
DENSE_RANK() OVER(PARTITION BY state order by victims asc) AS Rank_Row
from dataset













