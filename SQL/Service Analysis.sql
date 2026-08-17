-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 04_Service_Analysis.sql
-- Purpose: Analyze service-wise transaction performance
-- ============================================================

USE PhonePe_Analytics;

-- 1. Transaction volume and value by service
SELECT
Service,
COUNT(*) AS Total_Transactions,
SUM(Amount) AS Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions
GROUP BY Service
ORDER BY Transaction_Value DESC;

-- 2. Transaction volume by service type
SELECT
Service_Type,
COUNT(*) AS Total_Transactions,
SUM(Amount) AS Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions
GROUP BY Service_Type
ORDER BY Transaction_Value DESC;

-- 3. Payment success rate by service
SELECT
Service,
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
GROUP BY Service
ORDER BY Success_Rate DESC;
