-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 06_Customer_Analysis.sql
-- Purpose: Analyze customer activity and identify high-value users
-- ============================================================

USE PhonePe_Analytics;


-- 1. Active users
SELECT
COUNT(DISTINCT User_ID) AS Active_Users
FROM All_Transactions;

-- 2. Transactions and transaction value by user
SELECT
User_ID,
COUNT(*) AS Transaction_Count,
SUM(Amount) AS Total_Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions
GROUP BY User_ID
ORDER BY Total_Transaction_Value DESC;

-- 3. Top 10 high-value users
SELECT 
User_ID,
COUNT(*) AS Transaction_Count,
SUM(Amount) AS Total_Transaction_Value,
AVG(Amount) AS Average_Transaction_Value
FROM All_Transactions
GROUP BY User_ID
ORDER BY Total_Transaction_Value DESC
LIMIT 10;

-- 4. Top 10 most active users by transaction count
SELECT 
User_ID,
COUNT(*) AS Transaction_Count,
SUM(Amount) AS Total_Transaction_Value
FROM All_Transactions
GROUP BY User_ID
ORDER BY Transaction_Count DESC
LIMIT 10;

-- 5. Customer analysis with demographic information
SELECT
u.User_ID,
u.Name,
u.Age,
u.Join_Date,
COUNT(t.Transaction_ID) AS Transaction_Count,
SUM(t.Amount) AS Total_Transaction_Value,
AVG(t.Amount) AS Average_Transaction_Value
FROM All_Users u
JOIN All_Transactions t
ON u.User_ID = t.User_ID
GROUP BY
u.User_ID,
u.Name,
u.Age,
u.Join_Date
ORDER BY Total_Transaction_Value DESC;

-- 6. Transaction activity by age group
SELECT
CASE
WHEN u.Age < 25 THEN 'Under 25'
WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
ELSE '55+'
END AS Age_Group,
COUNT(DISTINCT u.User_ID) AS Active_Users,
COUNT(t.Transaction_ID) AS Total_Transactions,
SUM(t.Amount) AS Transaction_Value
FROM All_Users u
JOIN All_Transactions t
ON u.User_ID = t.User_ID
GROUP BY
CASE
WHEN u.Age < 25 THEN 'Under 25'
WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
ELSE '55+'
END
ORDER BY Transaction_Value DESC;
