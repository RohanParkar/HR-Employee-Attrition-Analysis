# HR Employee Attrition Analysis

## Overview
End-to-end analysis of employee attrition using MySQL and Power BI.  
Identifies key drivers of turnover to help HR teams reduce hiring costs.

**Dataset:** IBM HR Analytics — Kaggle | 1,470 records | 35 features  
**Tools:** MySQL · Power BI · DAX

---

## Problem Statement
Employee attrition costs organizations 50–200% of an employee's annual salary  
in recruitment, training, and lost productivity. This project analyses IBM's HR  
dataset to answer:
- Why are employees leaving?
- Which departments and roles are at highest risk?
- What is the estimated financial impact?

---

## Dashboard Preview
📄 [View Full Dashboard PDF](HR_Employee_Attrition_Analysis_PowerBI_Dashboard.pdf)

> The dashboard includes 3 pages — Executive Summary, Deep Dive Analysis,  
> and Department Drill Through with drill-through, tooltips, and dynamic slicers.

---

## Key Findings

| Finding | Data |
|---|---|
| Overall Attrition Rate | 16.12% — above industry avg of 10–12% |
| Highest Risk Department | Sales at 20.63% |
| Highest Risk Role | Sales Representative at 39.76% |
| Overtime Impact | OT employees leave at 30.53% vs 10.44% without OT |
| Compensation Gap | Leavers earn $4,787/mo vs $6,833/mo for stayers |
| Estimated Annual Cost | $6.81M in replacement costs |
| Avg Tenure of Leavers | 5.13 years before resignation |

---

## Project Structure

| File | Description |
|---|---|
| `01_schema_and_data_load.sql` | Database schema and CSV import |
| `02_analysis_queries.sql` | 7 analytical SQL queries with results |
| `HR_Employee_Attrition_Analysis.pbix` | Power BI dashboard file |
| `HR_Attrition_Project_Report.pdf` | Full project report |
| `HR_Employee_Attrition_Analysis.pdf` | Exported Power BI dashboard — all 3 pages |

---

## Dashboard Features
- **Drill Through** — Right-click any department to see department-level detail
- **Custom Tooltips** — Hover over any visual for enriched context
- **Dynamic Slicers** — Filter by Gender, Marital Status, Education Field
- **Row Level Security** — Department managers see only their own data

---

## DAX Measures
- `Attrition Rate = DIVIDE([Total Attrition], [Total Employees], 0)`
- `Attrition Cost = CALCULATE(SUMX(employee, employee[MonthlyIncome] * 12 * 0.5), employee[Attrition] = "Yes")`
- `High Risk Count` — Employees matching all 4 criteria: left + overtime + low satisfaction + below avg salary

---

## Author
**Rohan Parkar**  
[LinkedIn](https://linkedin.com/in/rohanparkar10) · [GitHub](https://github.com/RohanParkar)
