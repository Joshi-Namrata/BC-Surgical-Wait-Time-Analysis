# **SQL querries documentation**

## **Tools Used**
* **DataGrip for database management environment**
* **PostgreSQL**

## **Step 1: Creating a database and a table**

* Created a database **healthcare_data** within **DataGrip** and a schema named **bc_healthcare** for my project. 
* Created a table structure of the **surgical_wait_time** with the column names and the corresponding data types.
* Used string type for some of the columns containing numeric data and dates as it would require some additional cleaning before they could correctly store the corresponding data.
* Imported the data from the saved CSV file to be used for my project.

## **Step 2: Data Exploration**

* Quickly explored the data to look at the size of the dataset including number of rows and columns.
* Looked at the date range of the dataset (2009-2023).
* Looked at unique health authorities, facilities and the procedure groups.
* Further explored some of the aggregated data already present in the dataset including all health authorities, all facilities, all procedures and all other procedures.
* Looked at the number of null values in the dataset and columns containing those null values.
* Looked at data containing small values like **<5** or **0** in the columns of **waiting** and **completed**.

## **Step 3: Data Cleaning**

* Looked at the presence of **duplicate rows** within the dataset using a CTE and a window function.
  * Found **No duplicate** rows to be removed.

* Handled small values containing special characters like **<5** in columns of **waiting** and **completed**.
  * Updated the columns with the expected value of **2.5** in place of **<5** using a **replace** function ( **2.5** is selected in order to preserve the mean and variance of the columns)
* Removed a **Comma** in the **waiting** and **completed** columns using replace function so that it can be easier to change the data type of those columns to numeric types later.
* Created new columns of **fiscal_year_start** and **fiscal_year_end** from the existing **fiscal_year** column.
   * **fiscal_year** column is split into the 2 new columns mentioned above using **SPLIT_PART** function.
   * **fiscal_year_end** table is further updated with the correct values using a **concat** function where 20 is added in front of all the values in the column indicating the year.
* Converted the data types of **waiting** and **completed** columns with the numeric type (**double precision**).
* Null values are kept as such as the columns of **completed_50th_percentile** and **completed_90th_percentile** are not be used for analysis at this time.




