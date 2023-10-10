-- Data Cleaning

-- Steps:
--1. Find and remove duplicate rows of data
--2. Handle null values and values like <5
--3. Change a few of the column data types to the correct type.
--4. Add new columns as needed.

--Looking at duplicate rows of data using a CTE and row_num window function

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time;

WITH RowNumCTE AS(
SELECT *,
    ROW_NUMBER() OVER (
	PARTITION BY fiscal_year,
	             health_authority,
				 hospital_name,
				 procedure_group,
				 waiting,
				 completed,
				 completed_50th_percentile,
				 completed_90th_percentile
				 ORDER BY
				 fiscal_year
				 ) AS row_num
FROM healthcare_data.bc_healthcare.surgical_wait_time
)

SELECT *
FROM RowNumCTE
WHERE row_num >1;

-- 0 rows returned which indicates that there are no duplicate rows within the dataset.

-- Null values

-- Since most of the null values are in the columns of completed_50th_percentiles and completed_90th_percentiles which we are not planning to use at this point. We will leave the null values in their places.

-- Finding and Replacing values <5 with 2.5
-- ( 2.5 is selected as it is the expected value of <5 values to reduce bias and preserve the mean and variance of the columns)

--Looking at the columns with the changed values and comparing with the original columns
SELECT waiting, completed,
       REPLACE(waiting, '<5', '2.5') AS updated_waiting,
       REPLACE(completed,'<5', '2.5') AS updated_completed
FROM healthcare_data.bc_healthcare.surgical_wait_time
ORDER BY 3;

-- Updating the column of waiting by replacing the value of <5 with 2.5.

UPDATE healthcare_data.bc_healthcare.surgical_wait_time
SET waiting = REPLACE(waiting, '<5', '2.5');

--Checking if the values are changed

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE waiting = '2.5';

--Updating the columns of completed by replacing the value of <5 with 2.5.

UPDATE healthcare_data.bc_healthcare.surgical_wait_time
SET completed = REPLACE(completed, '<5', '2.5');

--Checking if the values are changed

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE completed = '2.5';

-- Let's split the column of fiscal_year into fiscal_year_start and fiscal_year_end

SELECT *,
    SPLIT_PART(fiscal_year, '/', 1) AS fiscal_year_start,
    SPLIT_PART(fiscal_year, '/', 2) AS fiscal_year_end
FROM healthcare_data.bc_healthcare.surgical_wait_time;

-- Adding new columns of fiscal_year_start and fiscal_year_end

-- Adding fiscal_year_start column

Alter Table healthcare_data.bc_healthcare.surgical_wait_time
Add fiscal_year_start varchar(50);

Update healthcare_data.bc_healthcare.surgical_wait_time
SET fiscal_year_start = SPLIT_PART(fiscal_year, '/', 1);

-- Adding fiscal_year_end column

Alter Table healthcare_data.bc_healthcare.surgical_wait_time
Add fiscal_year_end varchar(50);

Update healthcare_data.bc_healthcare.surgical_wait_time
SET fiscal_year_end =  SPLIT_PART(fiscal_year, '/', 2);

--Checking if new columns are added;

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time;

-- Let's change/ fix the value of fiscal_year_end with proper values( adding 20 in front of values)

SELECT *,
CONCAT('20',fiscal_year_end) AS fiscal_year_end_updated
FROM healthcare_data.bc_healthcare.surgical_wait_time;

--Updating this column of fiscal_year_end

Update healthcare_data.bc_healthcare.surgical_wait_time
SET fiscal_year_end = CONCAT('20',fiscal_year_end);

--Checking if the fiscal_year_end column values are updated
SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time;

-- Removing special characters
--Checking the waiting column values containing commas

SELECT count(*)
FROM healthcare_data.bc_healthcare.surgical_wait_time
WHERE  waiting like '%,%';

-- Let's remove comma in waiting column using replace function

UPDATE healthcare_data.bc_healthcare.surgical_wait_time SET waiting = replace (waiting, ',', '');

--Let's remove comma in the completed column using replace function like above;

UPDATE healthcare_data.bc_healthcare.surgical_wait_time SET completed = replace (completed, ',', '');

--Let's check if the commas are removed in both the columns

SELECT waiting,
       completed
    FROM healthcare_data.bc_healthcare.surgical_wait_time;

ALTER TABLE healthcare_data.bc_healthcare.surgical_wait_time
    ALTER COLUMN waiting TYPE double precision USING (waiting::double precision);

SELECT SUM(CAST(waiting AS double precision)) AS total_waiting
FROM healthcare_data.bc_healthcare.surgical_wait_time
GROUP BY health_authority;

-- Converting data types of waiting, completed, fiscal_year_start and fiscal_year_end columns

--Converting the waiting column from string to double precision;

ALTER TABLE healthcare_data.bc_healthcare.surgical_wait_time
    ALTER COLUMN waiting TYPE double precision USING (waiting::double precision);

--Converting the completed column from string to double precision;

ALTER TABLE healthcare_data.bc_healthcare.surgical_wait_time
    ALTER COLUMN completed TYPE double precision USING (completed::double precision);

--Looking at the dataset again

SELECT *
FROM healthcare_data.bc_healthcare.surgical_wait_time;















