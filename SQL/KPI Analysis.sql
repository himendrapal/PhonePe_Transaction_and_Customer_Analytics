-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 02_KPI_Analysis.sql
-- Purpose: Calculate major transaction and customer KPIs
-- ============================================================

USE PhonePe_Analytics;


-- 1. Overall transaction KPIs
SELECT
COUNT(*) AS Total_Transactions,
SUM(Amount) AS Total_Transaction_Value,
AVG(Amount) AS Average_Transaction_Value,
COUNT(DISTINCT User_ID) AS Active_Users
FROM All_Transactions;

-- 2. Total registered users
SELECT
COUNT(*) AS Total_Registered_Users
FROM All_Users;

-- 3. Successful transactions
SELECT
COUNT(*) AS Successful_Transactions
FROM All_Transactions
WHERE Payment_Status = 'Successful';

-- 4. Failed transactions
SELECT
COUNT(*) AS Failed_Transactions
FROM All_Transactions
WHERE Payment_Status <> 'Successful';

-- 5. Payment success rate
SELECT
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
FROM All_Transactions;

-- 6. Minimum, maximum and average transaction amount
SELECT
MIN(Amount) AS Minimum_Transaction_Value,
MAX(Amount) AS Maximum_Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions;
