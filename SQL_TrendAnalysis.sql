-- Monthly layoffs trend
SELECT DATE_FORMAT(layoff_date, '%Y-%m') AS month, SUM(total_laid_off) AS total
FROM layoffs_clean
GROUP BY month
ORDER BY month;

-- Top 5 industries by layoffs
SELECT industry, SUM(total_laid_off) AS total
FROM layoffs_clean
GROUP BY industry
ORDER BY total DESC
LIMIT 5;

-- Companies with multiple layoffs
SELECT company, COUNT(*) AS rounds
FROM layoffs_clean
GROUP BY company
HAVING rounds > 1;

-- Add "crisis" flag
SELECT *,
    CASE 
        WHEN total_laid_off > 1000 THEN 'Major'
        WHEN total_laid_off > 100 THEN 'Moderate'
        ELSE 'Minor'
    END AS layoff_severity
FROM layoffs_clean;
