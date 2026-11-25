create database Telco;
use Telco;

CREATE TABLE telco_churn (
    customerID        VARCHAR(20),
    gender            VARCHAR(10),
    SeniorCitizen     INT,
    Partner           VARCHAR(3),
    Dependents        VARCHAR(3),
    tenure            INT,
    PhoneService      VARCHAR(3),
    MultipleLines     VARCHAR(25),
    InternetService   VARCHAR(15),
    OnlineSecurity    VARCHAR(25),
    OnlineBackup      VARCHAR(25),
    DeviceProtection  VARCHAR(25),
    TechSupport       VARCHAR(25),
    StreamingTV       VARCHAR(25),
    StreamingMovies   VARCHAR(25),
    Contract          VARCHAR(20),
    PaperlessBilling  VARCHAR(3),
    PaymentMethod     VARCHAR(30),
    MonthlyCharges    NUMERIC(8,2),
    TotalCharges      VARCHAR(20),  
    Churn             VARCHAR(3)
);

SELECT COUNT(*) FROM telco_churn;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM churn_clean LIMIT 10;

-- Duplicates 
SELECT customerID, COUNT(*) FROM churn_clean GROUP BY customerID HAVING COUNT(*) > 1;

-- Nulls in TotalCharges 
SELECT COUNT(*) FROM churn_clean WHERE TotalCharges IS NULL;

-- KPI
SELECT
    COUNT(*)                                              AS total_customers,
    SUM(churn_flag)                                       AS churned_customers,
    ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)          AS churn_rate_pct,
    ROUND(AVG(tenure), 1)                                 AS avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2)                         AS avg_monthly_charge,
    ROUND(SUM(TotalCharges), 0)                           AS total_revenue,
    ROUND(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END), 0) AS monthly_revenue_at_risk,
    ROUND(AVG(CASE WHEN churn_flag = 1 THEN tenure END), 1) AS avg_tenure_churned,
    ROUND(AVG(CASE WHEN churn_flag = 0 THEN tenure END), 1) AS avg_tenure_retained
FROM churn_clean;

-- Churn rate by dimension ---

-- By Contract
SELECT Contract,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- By tenure_group
SELECT tenure_group,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;

-- By InternetService
SELECT InternetService,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- By PaymentMethod
SELECT PaymentMethod,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- By TechSupport
SELECT TechSupport,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;

-- By OnlineSecurity
SELECT OnlineSecurity,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY OnlineSecurity
ORDER BY churn_rate_pct DESC;

-- By senior_label
SELECT senior_label,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY senior_label
ORDER BY churn_rate_pct DESC;

-- By gender
SELECT gender,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY gender
ORDER BY churn_rate_pct DESC;

-- Churn by monthly charge band
SELECT FLOOR(MonthlyCharges / 10) * 10 AS charge_band,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY 1
ORDER BY 1;

-- Heatmap data
SELECT Contract, InternetService,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
GROUP BY Contract, InternetService
ORDER BY Contract, InternetService;

-- Revenue at risk by contract, with share of total
SELECT Contract,
       ROUND(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END), 0) AS revenue_at_risk,
       ROUND(100.0 * SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END)
             / SUM(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END)) OVER (), 1) AS pct_of_total_risk
FROM churn_clean
GROUP BY Contract
ORDER BY revenue_at_risk DESC;

-- Highest-risk segment
SELECT COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM churn_clean
WHERE Contract = 'Month-to-month'
  AND InternetService = 'Fiber optic'
  AND tenure <= 12
  AND TechSupport = 'No';
  
  -- Rank segments by churn, ignoring tiny groups
  SELECT Contract, InternetService, PaymentMethod,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       RANK() OVER (ORDER BY SUM(churn_flag) * 1.0 / COUNT(*) DESC) AS risk_rank
FROM churn_clean
GROUP BY Contract, InternetService, PaymentMethod
HAVING COUNT(*) >= 50
ORDER BY risk_rank
LIMIT 10;