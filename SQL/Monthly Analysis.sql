-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 03_Monthly_Analysis.sql
-- Purpose: Analyze monthly transaction trends
-- ============================================================

USE PhonePe_Analytics;

-- 1. Monthly transaction count and transaction value
SELECT
YEAR(Date) AS Transaction_Year,
MONTH(Date) AS Transaction_Month,
COUNT(*) AS Total_Transactions,
SUM(Amount) AS Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions
GROUP BY
YEAR(Date),
MONTH(Date)
ORDER BY
Transaction_Year,
Transaction_Month;

-- 2. Monthly successful transaction rate
SELECT
YEAR(Date) AS Transaction_Year,
MONTH(Date) AS Transaction_Month,
COUNT(*) AS Total_Transactions,
SUM(
CASE
WHEN Payment_Status = 'Successful' THEN 1
ELSE 0
END
) AS Successful_Transactions,
SUM(
CASE
WHEN Payment_Status = 'Successful' THEN 1
ELSE 0
END
) * 100.0 / COUNT(*) AS Success_Rate
FROM All_Transactions
GROUP BY
YEAR(Date),
MONTH(Date)
ORDER BY
Transaction_Year,
Transaction_Month;
