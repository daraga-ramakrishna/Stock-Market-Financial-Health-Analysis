CREATE DATABASE indian_financials;
USE indian_financials;

-- 1.How many companies and years are we analyzing?
SELECT
    COUNT(DISTINCT company_name) AS total_companies,
    COUNT(DISTINCT financial_year) AS total_years
FROM company_financials;

-- 2.How many total records (rows) are there?
SELECT COUNT(*) AS total_rows
FROM company_financials;

-- 3. Which years show profit but NO operating cash flow? (Year-level red flag)
SELECT
    company_name,
    financial_year,
    net_profit,
    cash_from_operating_activity
FROM company_financials
WHERE net_profit > 0
  AND cash_from_operating_activity < 0
ORDER BY company_name, financial_year;

-- 4. How frequent is profit–cash divergence overall?
SELECT
    COUNT(*) AS profit_without_cash_cases
FROM company_financials
WHERE net_profit > 0
  AND cash_from_operating_activity < 0;
  
-- 5. Which companies repeatedly show profit–cash mismatch?
SELECT
    company_name,
    COUNT(*) AS divergence_years
FROM company_financials
WHERE profit_cash_divergence = 1
GROUP BY company_name
HAVING COUNT(*) >= 2
ORDER BY divergence_years DESC;

-- 6. Which companies have the most consistent operating cash flow?
SELECT
    company_name,
    sector,
    AVG(positive_ocf_flag) * 100 AS positive_ocf_pct
FROM company_financials
GROUP BY company_name, sector
ORDER BY positive_ocf_pct DESC;

-- 7. Which companies are highly leveraged?
SELECT
    company_name,
    financial_year,
    debt_pressure
FROM company_financials
WHERE debt_pressure > 0.8
ORDER BY debt_pressure DESC;

-- 8. High debt + negative cash flow (MOST DANGEROUS COMBINATION)
SELECT
    company_name,
    financial_year,
    debt_pressure,
    cash_from_operating_activity
FROM company_financials
WHERE debt_pressure > 0.8
  AND cash_from_operating_activity < 0
ORDER BY debt_pressure DESC;

-- 9. Sector-wise financial strength comparison
SELECT
    sector,
    AVG(positive_ocf_flag) * 100 AS avg_cash_consistency,
    AVG(debt_pressure) AS avg_debt_pressure,
    COUNT(DISTINCT company_name) AS company_count
FROM company_financials
GROUP BY sector
ORDER BY avg_cash_consistency DESC;

-- 10. Company-level financial profile (replacement for company_summary)
SELECT
    company_name,
    sector,
    COUNT(DISTINCT financial_year) AS years,
    AVG(positive_ocf_flag) * 100 AS positive_ocf_pct,
    AVG(profit_margin) AS avg_profit_margin,
    AVG(debt_pressure) AS avg_debt_pressure,
    SUM(profit_cash_divergence) AS divergence_years
FROM company_financials
GROUP BY company_name, sector;

-- 11. Financially Resilient Companies
SELECT
    company_name,
    sector,
    AVG(positive_ocf_flag) * 100 AS positive_ocf_pct,
    AVG(profit_margin) AS avg_profit_margin,
    AVG(debt_pressure) AS avg_debt_pressure,
    SUM(profit_cash_divergence) AS divergence_years
FROM company_financials
GROUP BY company_name, sector
HAVING positive_ocf_pct >= 70
   AND avg_debt_pressure < 0.6
   AND divergence_years <= 1
ORDER BY avg_profit_margin DESC;

-- 12. Financially Resilient Companies
CREATE OR REPLACE VIEW resilient_companies AS
SELECT
    company_name,
    sector,
    AVG(positive_ocf_flag) * 100 AS positive_ocf_pct,
    AVG(debt_pressure) AS avg_debt_pressure,
    SUM(profit_cash_divergence) AS divergence_years
FROM company_financials
GROUP BY company_name, sector
HAVING positive_ocf_pct >= 70
   AND avg_debt_pressure < 0.6
   AND divergence_years <= 1;

-- 13. High-Risk Companies
CREATE OR REPLACE VIEW high_risk_companies AS
SELECT
    company_name,
    sector,
    AVG(debt_pressure) AS avg_debt_pressure,
    SUM(profit_cash_divergence) AS divergence_years
FROM company_financials
GROUP BY company_name, sector
HAVING avg_debt_pressure > 0.8
   OR divergence_years >= 2;
   
-- Compare risk distribution
SELECT 'Resilient' AS category, COUNT(*) FROM resilient_companies
UNION ALL
SELECT 'High Risk', COUNT(*) FROM high_risk_companies;

-- 14. Add “Neutral” bucket
SELECT 'Neutral', COUNT(*)
FROM company_financials
WHERE company_name NOT IN (
    SELECT company_name FROM resilient_companies
    UNION
    SELECT company_name FROM high_risk_companies
);

SELECT
    company_name,
    sector,
    financial_year,
    net_profit,
    cash_from_operating_activity,
    debt_pressure,
    positive_ocf_flag,
    profit_cash_divergence
FROM company_financials;