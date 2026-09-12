# Customer Support & Quality Analysis

## 📌 Project Overview

This project analyzes customer support operations using **Excel, SQL, and Power BI** to evaluate customer satisfaction, service quality, SLA compliance, ticket trends, and agent performance.

The objective is to identify operational issues, monitor key support KPIs, and provide insights that can help improve service quality and agent performance.

---

## 🛠 Tools Used

- **Excel** – Data cleaning, analysis, Pivot Tables, KPI calculations, and dashboard creation
- **Power BI** – Power Query, data modeling, DAX measures, interactive dashboard development, and visualization
-  **SQL (MySQL)** – Data querying, joins, aggregations, CASE statements, CTEs, and window functions

---

## 📂 Dataset

The project uses two datasets:

### Tickets
Contains ticket-level information including:
- Ticket ID
- Created Date
- Agent ID
- Channel
- Issue Type
- Priority
- Resolution Hours
- First Response Minutes
- CSAT Score
- QA Score
- Status
- Reopened
- Escalated

### Agents
Contains agent-level information including:
- Agent ID
- Agent Name
- Team Lead
- Team
- Location

---

## 📊 Excel Analysis

Excel was used to clean and analyze the customer support data and create an initial quality dashboard.

The analysis focused on:

- Total ticket volume
- Average CSAT
- Average QA score
- Ticket volume by team
- Team-level quality performance
- Monthly ticket and quality trends
- SLA and quality monitoring

📁 **[View Excel Analysis](excel/)**

---

## 📈 Power BI Dashboard

An interactive Power BI dashboard was developed to monitor customer support and quality performance.

### KPI Cards

- Total Tickets
- Average CSAT
- Average QA Score
- SLA Compliance %

### Dashboard Visuals

- Tickets by Issue Type
- Monthly Ticket Trend
- SLA Status by Priority
- Tickets by Team

### Interactive Filters

- Month
- Channel
- Priority
- Team

📁 **[View Power BI Files](PowerBI/)**

---

## 💻 SQL Analysis

MySQL was used to answer business questions related to customer support performance.

### Business Questions

1. What are the overall customer support KPIs?
2. What is the ticket volume by channel?
3. What are the average CSAT and QA scores by team?
4. Which issue types receive the most tickets?
5. How many SLA breaches occur for each priority level?
6. Which agents require coaching based on their QA performance?
7. What are the escalation and reopening rates by team?
8. How do agents rank by QA score within their respective teams?

### SQL Concepts Used

- `JOIN`
- `GROUP BY`
- Aggregate functions
- `CASE WHEN`
- `HAVING`
- Common Table Expressions (CTEs)
- `DENSE_RANK()`
- Window functions

📁 **[View SQL Analysis](sql/customer_support_analysis.sql)**

---

## 🔍 Key Insights

- **500 support tickets** were analyzed.
- Overall **SLA compliance was approximately 59%**.
- Average **QA score was approximately 86**.
- Average **CSAT was approximately 4 out of 5**.
- **Email Support** handled the highest ticket volume.
- **Delivery Delay** was the most frequent issue type.
- SLA breaches, QA scores, escalations, and reopened tickets can be analyzed together to identify coaching and process-improvement opportunities.

---

## 🎯 Skills Demonstrated

**Advanced Excel | SQL | MySQL | Power BI | Power Query | DAX | Data Cleaning | Data Modeling | KPI Analysis | Data Visualization | Customer Support Analytics**

---

## 📁 Project Structure

```text
Customer-Support-Quality-Analysis/
│
├── data/
│   ├── agents.csv
│   └── tickets.csv
│
├── excel/
│   └── Excel analysis files
│
├── sql/
│   └── customer_support_analysis.sql
│
├── PowerBI/
│   ├── Power BI dashboard
│   └── Dashboard screenshot
│
└── README.md
```


## 📌 Project Objective

The project demonstrates an end-to-end analytics workflow by transforming raw customer support data into actionable insights using **Excel, SQL, and Power BI**.
