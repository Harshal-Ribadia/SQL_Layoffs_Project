-- View structure
DESCRIBE layoffs;

-- Top 10 rows
SELECT * FROM layoffs LIMIT 10;

-- Unique countries
SELECT DISTINCT country FROM layoffs;

-- Count total layoffs
SELECT COUNT(*) FROM layoffs;

-- Total people laid off
SELECT SUM(total_laid_off) AS total_laid_off FROM layoffs;

-- Layoffs by country
SELECT country, SUM(total_laid_off) AS layoffs
FROM layoffs
GROUP BY country
ORDER BY layoffs DESC;
