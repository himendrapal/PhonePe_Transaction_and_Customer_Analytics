-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 05_Payment_Analysis.sql
-- Purpose: Analyze payment status and failure reasons
-- ============================================================

USE PhonePe_Analytics;

-- 1. Overall payment status distribution
SELECT
Payment_Status,
COUNT(*) AS Transaction_Count,
SUM(Amount) AS Transaction_Value
FROM All_Transactions
GROUP BY Payment_Status
ORDER BY Transaction_Count DESC;

-- 2. Failure reasons
SELECT
Reason,
COUNT(*) AS Failure_Count
FROM All_Transactions
WHERE Payment_Status <> 'Successful'
GROUP BY Reason
ORDER BY Failure_Count DESC;

-- 3. Failure reasons by service
SELECT
Service,
Reason,
COUNT(*) AS Failure_Count
FROM All_Transactions
WHERE Payment_Status <> 'Successful'
GROUP BY
Service,
Reason
ORDER BY
Service,
Failure_Count DESC;

-- 4. Failed transaction value by reason
SELECT
Reason,
COUNT(*) AS Failed_Transactions,
SUM(Amount) AS Failed_Transaction_Value
FROM All_Transactions
WHERE Payment_Status <> 'Successful'
GROUP BY Reason
ORDER BY Failed_Transactions DESC;
