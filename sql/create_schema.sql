-- CREATE DEDICATED USER FOR THIS PROJECT ONLY
CREATE USER 'healthcare_user'@'localhost' IDENTIFIED BY 'Password'; -- replace 'Password' with a strong password
GRANT ALL PRIVILEGES ON Healthcare_Analytics.* TO 'healthcare_user'@'localhost';
FLUSH PRIVILEGES;

-- Verify user created
SELECT User, Host FROM mysql.user WHERE User='healthcare_user';
-- DROP ANY OLD Healthcare_Analytics (if exists)
DROP DATABASE IF EXISTS Healthcare_Analytics;
-- FRESH PROJECT DATABASE
CREATE DATABASE Healthcare_Analytics;
GRANT ALL ON Healthcare_Analytics.* TO 'healthcare_user'@'localhost';

USE Healthcare_Analytics;

-- SINGLE TABLE FOR SIMPLICITY
CREATE TABLE medical_data (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    Height_cm INT,
    Weight_kg INT,
    BMI DECIMAL(4,1),
    Systolic INT,
    Diastolic INT,
    Heart_Rate INT,
    Blood_Sugar INT,
    Cholesterol INT,
    Diagnosis VARCHAR(20),
    Medication VARCHAR(20),
    Doctor VARCHAR(30),
    Hospital VARCHAR(20),
    Visit_Date DATE
);
