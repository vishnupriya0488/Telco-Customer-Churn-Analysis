# Telco Customer Churn Analysis: Identifying High-Risk Customer Segments

**Tools:** Excel | Tableau | Power BI | SQL

An end-to-end customer churn analysis of a telecom company's customer base. The same analysis is built in four tools, covering data cleaning, KPIs, segment-level churn analysis and interactive dashboards.

---

## Business Problem

Acquiring a new customer costs far more than keeping an existing one. This project answers three questions for a telecom company:

1. How many customers are leaving, and what does it cost in revenue?
2. Which customer segments are most likely to churn?
3. What can the business do to reduce churn?

---

## Dataset

- **Source:** [Telco Customer Churn (IBM sample dataset, Kaggle)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- **Size:** 7,043 customers, 21 columns
- **Key fields:** tenure, contract type, internet service, payment method, tech support, monthly charges, total charges, churn status

---

## Repository Contents

| File | Description |
|---|---|
| `Telco-Customer-Churn.xlsx` | Cleaned dataset |
| `Excel Dashboard.xlsx` | Excel dashboard: KPIs, pivot tables, charts, slicers |
| `Tableau Dashboard.twbx` | Interactive Tableau dashboard |
| `PowerBi Dashboard.pbix` | Interactive Power BI dashboard with DAX measures |
| `Sql query.sql` | SQL queries: cleaning, KPIs and segment analysis |

---

## Approach

**1. Data cleaning**
- Converted `TotalCharges` to a numeric type and handled blank values (customers with tenure 0)
- Checked for duplicates and missing values
- Created helper fields: churn flag, tenure group, senior citizen label

**2. KPIs**
- Total customers
- Churned customers
- Churn rate
- Average tenure
- Average monthly charge
- Total revenue
- Monthly revenue at risk

**3. Analysis**
- Churn rate by contract type, tenure group, internet service, payment method, tech support and online security
- Monthly charges distribution for churned vs. retained customers
- Contract x internet service heatmap

**4. Dashboards**
- KPI cards, charts and slicers/filters for interactive exploration

---

## Key Findings

- The overall churn rate is about **26.5%**, which is over 1 in 4 customers.
- **Month-to-month** contract customers churn far more than one- and two-year contract customers.
- Churn is highest in the **first 12 months** of tenure.
- **Fiber optic** customers churn more than DSL customers.
- Customers paying by **electronic check** churn the most.
- Customers **without tech support or online security** churn more than those with these services.

> Add exact percentages from your own dashboards here, for example: "Month-to-month churn: XX% vs. two-year: XX%".

---

## Recommendations

1. Offer discounts or incentives to move **month-to-month customers onto annual contracts**, especially in their first year.
2. Run an **onboarding and early-engagement program** for customers in their first 12 months.
3. Bundle **tech support and online security** with fiber optic plans to improve retention.
4. Encourage **automatic payment methods** instead of electronic check.
5. Investigate pricing and service quality on the fiber optic plans.

---

## Dashboard Previews

**Excel**

<img width="802" height="681" alt="Screenshot (228)" src="https://github.com/user-attachments/assets/20abe530-8b34-4ef9-b806-26305e9b2e56" />



**Tableau**

<img width="1653" height="922" alt="Screenshot (227)" src="https://github.com/user-attachments/assets/6336f464-3911-4cf7-ba72-c2805169906a" />


**Power BI**

<img width="1304" height="749" alt="Screenshot (226)" src="https://github.com/user-attachments/assets/3419294f-6a3a-4484-a2df-ea3802ba8ae5" />


## How to Use

- **Excel:** Open `Excel Dashboard.xlsx` and use the slicers to filter.
- **Tableau:** Open `Tableau Dashboard.twbx` in Tableau Desktop or Tableau Public.
- **Power BI:** Open `PowerBi Dashboard.pbix` in Power BI Desktop.
- **SQL:** Load the CSV into a database (PostgreSQL, MySQL or SQL Server), then run `Sql query.sql`.

---

## Skills Demonstrated

- Data cleaning and preparation
- KPI design and business metrics
- Pivot tables, DAX measures, calculated fields
- SQL: aggregations, CASE logic, views, window functions
- Dashboard design and data storytelling

---

## Author

**Vishnupriya**
[https://www.linkedin.com/in/vishnupriya-l-6544442a1] | [GitHub](https://github.com/vishnupriya0488)
