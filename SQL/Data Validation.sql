-- ============================================================
-- PhonePe Transaction & Customer Analytics
-- File: 01_Data_Validation.sql
-- Purpose: Validate the structure and quality of the dataset
-- ============================================================

USE PhonePe_Analytics;

-- 1. Check total number of users
SELECT COUNT(*) AS Total_Users
FROM All_Users;

-- 2. Check total number of transactions
SELECT COUNT(*) AS Total_Transactions
FROM All_Transactions;

-- 3. Preview users table
SELECT * 
FROM All_Users
LIMIT 10;

-- 4. Preview transactions table
SELECT  *
FROM All_Transactions
LIMIT 10;

-- 5. Check duplicate transaction IDs
SELECT
Transaction_ID,
COUNT(*) AS Duplicate_Count
FROM All_Transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- 6. Check for missing values in the transactions table
SELECT
SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_ID,
SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS Missing_Amount,
SUM(CASE WHEN User_ID IS NULL THEN 1 ELSE 0 END) AS Missing_User_ID,
SUM(CASE WHEN Service IS NULL THEN 1 ELSE 0 END) AS Missing_Service,
SUM(CASE WHEN Payment_Status IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Status,
SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Missing_Date
FROM All_Transactions;

-- 7. Check for transactions linked to users
--    who do not exist in the users table
SELECT COUNT(*) AS Invalid_User_Transactions
FROM All_Transactions t
LEFT JOIN All_Users u
ON t.User_ID = u.User_ID
WHERE u.User_ID IS NULL;

-- 8. Check transaction date range
SELECT
MIN(Date) AS First_Transaction_Date,
MAX(Date) AS Last_Transaction_Date
FROM All_Transactions;

-- 9. Check available service categories
SELECT DISTINCT Service
FROM All_Transactions
ORDER BY Service;

-- 10. Check payment status categories
SELECT DISTINCT Payment_Status
FROM All_Transactions
ORDER BY Payment_Status;
