CREATE DATABASE hr_attrition;

USE hr_attrition;

CREATE TABLE employee (
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

ALTER TABLE employee
ADD COLUMN EmployeeCount INT,
ADD COLUMN Over18 VARCHAR(5),
ADD COLUMN StandardHours INT;

-- Update the path below to your local CSV file location before running
LOAD DATA INFILE 'your/path/to/WA_Fn-UseC_-HR-Employee-Attrition.csv'
INTO TABLE employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Age, Attrition, BusinessTravel, DailyRate, Department, DistanceFromHome,
Education, EducationField, EmployeeCount, EmployeeNumber, EnvironmentSatisfaction,
Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction,
MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, Over18, OverTime,
PercentSalaryHike, PerformanceRating, RelationshipSatisfaction, StandardHours,
StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance,
YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager);
