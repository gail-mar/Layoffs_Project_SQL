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

DELETE
FROM layoffs_staging2
WHERE ROW_NUM >1;

SELECT *
FROM layoffs_staging2;

-- 2. Standardize the Data 

SELECT company, TRIM(COMPANY)
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT country
From layoffs_staging2
order by 1;

update layoffs_staging2
set country = TRIM(TRAILING '.' from country)
Where country like 'United States%';

Select `date`
from  layoffs_staging2;

update layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

Alter table layoffs_staging2
modify column `date` date;

select * 
from layoffs_staging2
where total_laid_off is null;