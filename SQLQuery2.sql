-- no. of rows in each dataset
select COUNT(*)
from dbo.data1
select COUNT(*)
from dbo.data2
-- looking for data of two states
Select* from dbo.data1 where State in ('Jharkhand','Bihar') 
-- Total population of India from dataset 2
Select SUM(Population) as Total_population from dbo.data2
-- average growth precentage of country
Select ROUND(AVG(Growth)*100,2) as Average from dbo.data1
-- Average growth percentage by state
Select State, ROUND(AVG(Growth)*100,2) as Average from dbo.data1 group by State
-- Average sex ratio per state
Select State,ROUND(AVG(Sex_Ratio),2) as sex_ratio from dbo.data1 group by State
-- State with highest average growth rate
Select State, ROUND(AVG(Growth)*100,2) as Average from dbo.data1 group by State order by Average DESC
-- Average literacy rate of India
Select AVG(Literacy) as Literacy_rate from dbo.data1
-- Average literacy rate of India per state
Select state,ROUND(AVG(Literacy),2) as Literacy_rate from dbo.data1 group by State order by Literacy_rate DESC
-- Literacy_ratio greater than 90 
Select state,ROUND(AVG(Literacy),2) as Literacy_rate from dbo.data1 group by State HAVING ROUND(AVG(Literacy),2)>90 order by Literacy_rate DESC 
-- Top 3 states with highest growth percentage ratio
Select top 3 State, ROUND(AVG(Growth)*100,2) as growth_percentage from dbo.data1 group by State order by growth_percentage DESC 
-- bottom 3 states with lowest average sex ratio
select top 3 state,ROUND(AVG(Sex_Ratio),2) as avg_sex_ratio from dbo.data1 group by state order by avg_sex_ratio
--top 3 and lowest 3 literacy rates in one table
create view top_3 as
select top 3 state,avg(literacy) as avg_literacy from dbo.data1 group by state order by avg(literacy) DESC 
create view bottom_3 as
select top 3 state,avg(literacy) as avg_literacy from dbo.data1 group by state order by avg(literacy)  
select* from top_3 
union
select* from bottom_3 
order by avg_literacy
--joining both tables
select a.District,a.State,b.Population from dbo.data1 as a 
join dbo.data2 as b on a.District = b.District order by Population DESC
-- calculating no. of females and males (assuming just two genders)
create view pop as
select a.District,a.sex_ratio,a.State,b.Population from dbo.data1 as a 
join dbo.data2 as b on a.District = b.District
select state,round(population / sex_ratio+1),0) as females,round(population - (population/sex_ratio+1),0) as males from pop 
