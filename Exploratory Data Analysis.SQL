-- Exploraty Data Analysis 

select * 
from layoffs_staging2;

select Max(total_laid_off), Max(percentage_laid_off) 
from layoffs_staging2;

select * 
from  layoffs_staging2 
where percentage_laid_off =1
order by total_laid_off desc;

select * 
from  layoffs_staging2 
where percentage_laid_off =1
order by funds_raised_millions desc;

select company, sum(total_laid_off) 
from  layoffs_staging2 
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2; 
-- form 2020-03-11 till 2023-03-06 (in 3 years)

select industry, sum(total_laid_off) 
from  layoffs_staging2 
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select country , sum(total_laid_off) 
from  layoffs_staging2 
group by country
order by 2 desc;

select year(`date`) , sum(total_laid_off) 
from  layoffs_staging2 
group by year(`date`)
order by 1 desc;

select company , sum(percentage_laid_off) 
from  layoffs_staging2 
group by company
order by 1 desc;
-- desiding not to explore furthure the percentage_laid_off for each company, industry or date as the precentages dont say so much in this case and the total_laid_off shows better comperations in this case.

select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2 
where substring(`date`,1,7) is not null
Group by `MONTH`
order by 1 asc;

with Rolling_total as
(select substring(`date`,1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2 
where substring(`date`,1,7) is not null
Group by `MONTH`
order by 1 asc)
select `MONTH`, total_off 
,sum(total_off) over(order by`MONTH`) as rolling_total
from Rolling_total;

select company,year(`date`) ,sum(total_laid_off) 
from  layoffs_staging2 
group by company,year(`date`)
order by 3 desc;

with Company_year (company,years,total_laid_off)  as
(select company,year(`date`) ,sum(total_laid_off) 
from  layoffs_staging2 
group by company,year(`date`)
), Company_year_rank as
(
select * , dense_rank() over (partition by years order by total_laid_off desc) as Ranking
from Company_year
where years is not null
)
select *
from Company_year_rank
where Ranking <=5;