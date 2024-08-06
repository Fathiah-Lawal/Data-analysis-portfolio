-- EXPLLORATORY DATA ANALYSIS
select * 
from layoff_staging2
where company = 'google';

select * 
from layoff_staging2
where percentage_laid_off =1 
order by funds_raised_millions ;

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;

select industry, sum(total_laid_off)
from layoff_staging2
group by industry
order by 2 desc;

select min(date), max(date)
from layoff_staging2; 

select country, sum(total_laid_off)
from layoff_staging2
group by country
order by 2 DESC;

select year(date), sum(total_laid_off)
from layoff_staging2 
group by year(date)
order by year(date);

select stage, sum(total_laid_off)
from layoff_staging2
group by stage
order by sum(total_laid_off) DESC;

SELECT
    month_no,
    total_laid_off,
    CASE
        WHEN month_no = '01' THEN 'January'
        WHEN month_no = '02' THEN 'February'
        WHEN month_no = '03' THEN 'March'
        WHEN month_no = '04' THEN 'April'
        WHEN month_no = '05' THEN 'May'
        WHEN month_no = '06' THEN 'June'
        WHEN month_no = '07' THEN 'July'
        WHEN month_no = '08' THEN 'August'
        WHEN month_no = '09' THEN 'September'
        WHEN month_no = '10' THEN 'October'
        WHEN month_no = '11' THEN 'November'
        WHEN month_no = '12' THEN 'December'
        ELSE ''
    END AS month
FROM
    (SELECT
        SUBSTRING(date, 6, 2) AS month_no,
        sum(total_laid_off) as total_laid_off
    FROM
        layoff_staging2
	GROUP BY
        month_no ) AS subquery;

select substring(date, 1,7) as month, sum(total_laid_off)
from layoff_staging2
where  substring(date, 1,7) is not null
group by month
order by 1;

with Rolling_total as
( select substring(date, 1,7) as month, sum(total_laid_off) as total_laid
from layoff_staging2
where  substring(date, 1,7) is not null
group by month
order by 1
)

select month, total_laid, sum(total_laid) over (order by month) as rolling_total
from Rolling_total;

select company, year(date), sum(total_laid_off)
from layoff_staging2
group by company, year(date)
order by 3 desc;

with company_year(company, years, total_laid_off) as 
(
select company, year(date), sum(total_laid_off)
from layoff_staging2
group by company, year(date)
)
, company_year_rank as
(
select *, dense_rank() over (partition by years order by total_laid_off DESC) as ranking
from company_year
where years is not null
)
select * 
from company_year_rank
where ranking<=5;
select *
from layoff_staging2;










