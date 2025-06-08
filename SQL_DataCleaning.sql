-- Replace inconsistent country names
UPDATE layoffs SET country = 'United States'
WHERE country IN ('USA', 'US', 'U.S.');

-- Fill NULL with 0
UPDATE layoffs
SET total_laid_off = 0
WHERE total_laid_off IS NULL;

-- Create cleaned table
CREATE TABLE layoffs_clean AS
SELECT 
    company,
    industry,
    country,
    COALESCE(total_laid_off, 0) AS total_laid_off,
    COALESCE(percentage_laid_off, 0) AS percentage_laid_off,
    STR_TO_DATE(`date`, '%m/%d/%Y') AS layoff_date
FROM layoffs;

