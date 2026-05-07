--Basic Check
SELECT * FROM customers LIMIT 10;
--Overall Churn Rate
SELECT 
  COUNT(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS churn_rate
FROM customers;
--Churn by Contract
SELECT 
  Contract,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  (SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM customers
GROUP BY Contract;
--Churn by Tenure
SELECT 
  CASE 
    WHEN tenure < 12 THEN 'New Customers'
    WHEN tenure BETWEEN 12 AND 36 THEN 'Mid Customers'
    ELSE 'Old Customers'
  END AS customer_group,

  COUNT(*) AS total_customers,

  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

  (SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate

FROM customers
GROUP BY customer_group;
--Churn by Monthly Charges
SELECT 
  CASE 
    WHEN MonthlyCharges < 50 THEN 'Low'
    WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium'
    ELSE 'High'
  END AS charge_group,

  COUNT(*) AS total_customers,

  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

  (SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate

FROM customers
GROUP BY charge_group;
--High-Risk Customers
SELECT *
FROM customers
WHERE Contract = 'Month-to-month'
AND tenure < 12
AND MonthlyCharges > 80;
