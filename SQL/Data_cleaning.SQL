-- Data Cleaning 
RENAME TABLE layoffs_uncleaned_data TO layoffs;

SELECT *
FROM layoffs;

-- Pionts we will work on in the data cleaning: 
-- 1. Remove Duplicates 
-- 2. Standardize the Data 
-- 3. Null Values or Blank Values 
-- 4. Remove Any Columns 

-- Creating a duplicate of raw data to data clean it. 
CREATE TABLE layoffs_staging 
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. Remove Duplicates 

--make a row_num column to identify duplicates

SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS 
(SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * 
FROM duplicate_cte 
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging;

--dentify duplicates and remove them from the staging table.
DELETE
FROM layoffs_staging2
WHERE ROW_NUM >1;

SELECT *
FROM layoffs_staging2;

-- 2. Standardize the Data 

-- Standardize the companynames by removing leading and trailing spaces.

SELECT company, TRIM(COMPANY)
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company = TRIM(company);

-- found 3 simlair industry options for crypto and unified them to one.
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Standardize the country names by removing trailing periods.
SELECT *
FROM layoffs_staging2;

SELECT DISTINCT country
From layoffs_staging2
order by 1;

update layoffs_staging2
set country = TRIM(TRAILING '.' from country)
Where country like 'United States%';

-- update date column to date format.

Select `date`
from  layoffs_staging2;

update layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

Alter table layoffs_staging2
modify column `date` date;

-- 3. Null Values or Blank Values

-- Identify the number of null values in industry and try to fill them in with the help of other rows with the same company name.
update layoffs_staging2
set industry = null
where industry = '';

select distinct *  
from layoffs_staging2
where industry is null
or industry = '' ;

select *
from layoffs_staging2
where company like 'Bally%';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	ON t1.company =  t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company =  t2.company
set t1.industry = t2.industry 
where t1.industry is null 
and t2.industry is not null;

-- 4. Remove Any Columns 

-- removing the row_num column as it is no longer needed after removing duplicates.
select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- removing rows where both total_laid_off and percentage_laid_off are null as they do not provide any useful information for this analysis.
delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;