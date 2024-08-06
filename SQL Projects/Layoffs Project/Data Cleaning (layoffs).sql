-- CLEANING TABLE
CREATE TABLE layoff_staging 
LIKE layoff;

INSERT layoff_staging
SELECT * 
FROM layoffs;

SELECT * 
FROM layoff_staging;

-- CHECKING FOR DUPLICATES
WITH duplicate_cte AS
(
SELECT *, 
row_number () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions order by country) AS row_num
FROM layoff_staging)

SELECT * 
FROM duplicate_cte 
WHERE row_num>1 ;

-- DELETING DUPLICATES
CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoff_staging2
SELECT *, 
row_number () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions order by country) AS row_num
FROM layoff_staging  ;

DELETE
FROM layoff_staging2
WHERE row_num >1;

-- STANDARDIZING DATA
select distinct industry
from layoff_staging2
order by 1;

select distinct(industry) 
from layoff_staging2 ;

UPDATE layoff_staging2
SET company = trim(company) ;

UPDATE layoff_staging2
SET industry = 'Crypto'
where industry like '%crypto%';

UPDATE layoff_staging2
SET country = 'United States'
where country like 'United Stat%';

select distinct country
from layoff_staging2
order by 1;

-- FORMATTING DATES 
select date, 
str_to_date(date, '%m/%d/%Y')
from layoff_staging2;

UPDATE layoff_staging2
SET date = str_to_date(date, '%m/%d/%Y'); -- Note that its small m, small d and capital Y

ALTER TABLE layoff_staging2
modify column `date` DATE;

-- FILLING INDUSTY COLUMN UP
select a.industry, b.industry
FROM layoff_staging2 a
JOIN layoff_staging2 b
ON a.company = b.company
where a.industry is null or a.industry = ''
and b.industry is not null;

update layoff_staging2 a
SET industry = null
where industry = '';

update layoff_staging2 a
JOIN layoff_staging2 b
ON a.company = b.company
SET a.industry = b.industry
where a.industry is null
and b.industry is not null;

SELECT * FROM layoff_staging2
where industry is null;

-- DELETING ROWS WITH MISSING PERCENTATE LAID OFF AND TOTAL LAID OFF
SELECT * 
FROM layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null;

DELETE  
FROM layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null;

-- REMOVING ROW_NUM COLUMN
ALTER TABLE layoff_staging2
DROP COLUMN row_num;

SELECT * 
FROM vaccinations;





