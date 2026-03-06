use healthcare_analytics;

-- select * from medical_data;

-- Hospital Performance: Disease rates by facility
SELECT 
Hospital,
COUNT(*) as Total_Patients,
ROUND(AVG(CASE WHEN Diagnosis='Heart Disease' THEN 1.0 ELSE 0 END)*100,1) as Heart_Disease_Pct,
ROUND(AVG(CASE WHEN Diagnosis='Diabetes' THEN 1.0 ELSE 0 END)*100,1) as Diabetes_Pct,
ROUND(AVG(CASE WHEN Diagnosis='Healthy' THEN 1.0 ELSE 0 END)*100,1) as Healthy_Pct
FROM medical_data 
GROUP BY Hospital 
ORDER BY Heart_Disease_Pct DESC;

-- Doctor Effectiveness: % Healthy patients per doctor
SELECT 
Doctor,
COUNT(*) as Total_Patients,
SUM(CASE WHEN Diagnosis='Healthy' THEN 1 ELSE 0 END) as Healthy_Count,
ROUND(SUM(CASE WHEN Diagnosis='Healthy' THEN 1.0 ELSE 0 END)*100/COUNT(*),1) as Healthy_Pct
FROM medical_data 
GROUP BY Doctor 
ORDER BY Healthy_Pct DESC 
LIMIT 10;

-- High-risk patients (Triple risk factors)
SELECT 
Hospital,
COUNT(*) as High_Risk_Count,
ROUND(COUNT(*)*100.0 / SUM(SUM(CASE WHEN BMI>35 AND Age>60 AND Cholesterol>250 THEN 1 ELSE 0 END)) OVER(),1) as High_Risk_Pct
FROM medical_data 
WHERE BMI > 35 AND Age > 60 AND Cholesterol > 250
GROUP BY Hospital
ORDER BY High_Risk_Count DESC;

-- Medication outcomes: Healthy % by drug
SELECT 
Medication,
COUNT(*) as Patients_On_Med,
SUM(CASE WHEN Diagnosis='Healthy' THEN 1 ELSE 0 END) as Healthy_On_Med,
ROUND(SUM(CASE WHEN Diagnosis='Healthy' THEN 1.0 ELSE 0 END)*100/COUNT(*),1) as Healthy_Pct
FROM medical_data 
WHERE Medication != 'None'
GROUP BY Medication 
ORDER BY Healthy_Pct DESC;

-- Diagnosis trends over time
SELECT 
DATE_FORMAT(Visit_Date, '%Y-%m') as Visit_Month,
Diagnosis,
COUNT(*) as Case_Count
FROM medical_data 
GROUP BY Visit_Month, Diagnosis 
ORDER BY Visit_Month DESC, Case_Count DESC;

