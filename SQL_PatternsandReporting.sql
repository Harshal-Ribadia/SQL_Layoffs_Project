-- Rank companies by layoffs in each industry
SELECT *,
       RANK() OVER (PARTITION BY industry ORDER BY total_laid_off DESC) AS industry_rank
FROM layoffs_clean;

-- Rolling 3-month layoffs by company
WITH MonthlyLayoffs AS (
    SELECT company, DATE_FORMAT(layoff_date, '%Y-%m') AS month, SUM(total_laid_off) AS layoffs
    FROM layoffs_clean
    GROUP BY company, month
)
SELECT *, 
       SUM(layoffs) OVER (PARTITION BY company ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3mo
FROM MonthlyLayoffs;

-- View: summary by country
CREATE VIEW country_layoff_summary AS
SELECT country, SUM(total_laid_off) AS total_layoffs, COUNT(DISTINCT company) AS companies
FROM layoffs_clean
GROUP BY country;

-- Company Layoff Report
CREATE VIEW company_layoff_summary AS
SELECT 
    company,
    COUNT(*) AS layoff_rounds,
    MAX(total_laid_off) AS biggest_round,
    SUM(total_laid_off) AS total_laid_off,
    ROUND(AVG(percentage_laid_off), 2) AS avg_pct_laid_off
FROM layoffs_clean
GROUP BY company;
