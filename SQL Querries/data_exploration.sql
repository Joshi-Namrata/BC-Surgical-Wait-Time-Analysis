-- Looking at the table
SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time;

--There are 8 columns in the dataset.

--Looking at the row count in the dataset

SELECT COUNT(*) AS number_of_rows
FROM healthcare_data.bc_healthcare.surgical_wait_time;

--There are 48057 rows in the dataset.

--Looking at the date range in the dataset

SELECT DISTINCT fiscal_year
FROM healthcare_data.bc_healthcare.surgical_wait_time
ORDER BY fiscal_year;

--The date range of the dataset is 2009 to 2023

--Looking at unique health authorities

SELECT DISTINCT health_authority
FROM healthcare_data.bc_healthcare.surgical_wait_time;

--Looking specifically at 'All Health Authorities'

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE health_authority = 'All Health Authorities';

--Looking at unique facilities

SELECT DISTINCT hospital_name
FROM healthcare_data.bc_healthcare.surgical_wait_time
ORDER BY hospital_name;

--Looking at unique procedures

SELECT DISTINCT procedure_group
FROM healthcare_data.bc_healthcare.surgical_wait_time
ORDER BY procedure_group;

--There are 85 unique procedure groups including 'All Procedures' and 'All Other Procedures'

--Looking specifically at all health authorities and all procedures and all other procedures data

SELECT *
FROM  healthcare_data.bc_healthcare.surgical_wait_time
WHERE health_authority = 'All Health Authorities'
  AND procedure_group IN ('All Procedures','All Other Procedures');

-- The output shows total waiting, completed and completed 50th and 90th percentiles data for all procedure and all other procedures for each of the 14 years.

-- Looking at null values

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE surgical_wait_time.completed_50th_percentile IS NULL
  AND surgical_wait_time.completed_90th_percentile IS NULL
AND completed IN ('<5','0');

--It seems there are 9573 total null values in the columns of completed 50th percentiles and completed 90th percentiles out of which 9541 rows have completed surgeries of <5 including 0.

--Looking at <5 values in waiting and completed columns

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE surgical_wait_time.waiting = '<5'
  OR surgical_wait_time.completed = '<5'
AND completed IN ('<5','0');

--There are 17,872 rows of data containing <5 values in the columns of either waiting or completed.