USE hr_attrition;

-- 1 — Overall Attrition Rate
-- -----------------------------------------------------------------------
SELECT 
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TotalAttrition,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM employee;
-- Result: 1,470 employees | 237 left | 16.12% attrition rate


-- 2 — Attrition by Department
-- -----------------------------------------------------------------------
SELECT 
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TotalAttrition,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM employee
GROUP BY Department
ORDER BY AttritionRate DESC;
-- Result: Sales 20.63% | HR 19.05% | R&D 13.84%


-- 3 — Attrition by Age Band
-- -----------------------------------------------------------------------
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+' 
    END AS AgeBand,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TotalAttrition,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM employee
GROUP BY AgeBand
ORDER BY AttritionRate DESC;
-- Result: Under 25 = 39.18% (highest risk)


-- 4 — Avg Salary: Leavers vs Stayers
-- -----------------------------------------------------------------------
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome,
    ROUND(AVG(TotalWorkingYears), 1) AS AvgYearsExperience
FROM employee
GROUP BY Attrition;
-- Result: Leavers avg $4,787/mo vs Stayers avg $6,833/mo


-- 5 — Attrition by Overtime
-- -----------------------------------------------------------------------
SELECT 
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM employee
GROUP BY OverTime;
-- Result: No OT = 10.44% | Yes OT = 30.53% (nearly 3x higher)


-- 6 — High Risk Employee Profile
-- Criteria: Left + Overtime + Low Satisfaction + Below Avg Salary
-- -----------------------------------------------------------------------
SELECT 
    JobRole,
    COUNT(*) AS HighRiskCount
FROM employee
WHERE Attrition = 'Yes'
    AND OverTime = 'Yes'
    AND JobSatisfaction <= 2
    AND MonthlyIncome < (SELECT AVG(MonthlyIncome) FROM employee)
GROUP BY JobRole
ORDER BY HighRiskCount DESC;
-- Result: Research Scientist (15) | Lab Technician (12) | Sales Rep (7)


-- 7 — Estimated Cost of Attrition by Department
-- Using 50% of annual salary as replacement cost benchmark (SHRM standard)
-- -----------------------------------------------------------------------
SELECT 
    Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS EmployeesLost,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END) * 12, 2) AS AvgAnnualSalaryLost,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END) * 12 * 0.5, 2) AS EstimatedAttritionCost
FROM employee
GROUP BY Department
ORDER BY EstimatedAttritionCost DESC;
-- Result: R&D $3.28M | Sales $3.26M | HR $0.27M | Total ~$6.81M


/**
Key Insights:
1.  16.12% overall attrition — roughly 1 in 6 employees is leaving
2.  Sales & HR are bleeding talent — nearly 1 in 5 employees leaving in both departments
3.  Young employees are the biggest risk — Under 25s have the highest attrition at 39.18%
4.  Compensation is a clear driver — leavers earn ~$2,000/month less than stayers
5.  Overtime is burning people out — OT employees leave at nearly 3x the rate
6.  Research Scientists & Lab Technicians are highest risk profiles — underpaid for their qualifications
7.  R&D and Sales account for ~96% of total attrition cost ($6.54M of $6.81M)
8.  HR attrition cost ($0.27M) looks small but their rate is disproportionately high for their headcount
**/
