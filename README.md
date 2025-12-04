# Using MS SQL Server on Mac

## Running The Server On LocalHost

1. **Pull the image**
   ```bash
   docker pull mcr.microsoft.com/mssql/server:2019-latest
   ```
2. **Run the container**
   ```bash
   docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<password>" -p 1433:1433 —name ContainerName -h mssql -d mcr.microsoft.com/mssql/server:2019-latest
   ```
   - MySecretP@ssword21

## Connecting to the server using a VSCode Extension

1. Use the SQL Server (mssql) extension to connect to the db container
   - **Profile Name** - Name of the database connection
   - **Server name** - localhost
   - **Username** - sa
   - **Password** - whatever you set it to (Make sure its unique enough)

## Create a New DB using SQL

1. Create a .sql file and write some sql. Press CMD + SHIFT + E to execute
2. CREATE DATABASE "DB Name"

## Relational Database Design (SQL Server)

### Database:
* Collection of data organized for search and retrieval.

### Types of Databases:

* **Flat Files**
  * Spreadsheet or text file for storing data
  * Large, un-normalized tables with many columns
  * Easy view data
  * Difficult to update and maintain
  * Prone to redundancy and inaccuracy over time.
* **NoSQL Databases**
  * Data storage and retrieval is not modeled with tabular relations.
  * Used in big data and real-time apps
  * There are many types including Graph and Key-Value Databases.
* **Data Warehouses**
  * Optimized for reporting and data analysis
  * Used for historical data
* **Relational Databases (SQL)**
  * Relational Database Management Systems (RDMS) provide a standard approach for storing and querying data
  * Queried using SQL
  * Standardized data integrity
  * Minimized data redundancy

### Logical Design Vs. Physical Design

**Logical Design:**
* Arranging data into tables, defining attributes and relationships between tables.
* Entity relationship diagrams are often used in logical design

**Physical Design:**
* The actual process of creating tables, constraints and relationships using SQL.
* Rows are often referred to as records.

**Example - Creating a table:**
```sql
CREATE TABLE EMPLOYEES_TEST
(
    SSN VARCHAR(11),
    EMP_ID INT,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50)
);
```

## Data Integrity

* Data integrity is the accuracy and consistency of data.
* In Relational Databases we enforce integrity with table constraints.

### Important contraints:

* **Primary Key Constraints**
  * Ensures unique values in a column and prevents NULL values
  * Example:
    ```sql
    CREATE TABLE EMPLOYEES1
    (
        EMP_ID INT,
        EMP_LAST_NAME VARCHAR(50) NOT NULL,
        SALARY DECIMAL(12,2) NOT NULL,
        BONUS DECIMAL(12,2) NOT NULL,
        CONSTRAINT EMPLOYEES1_PK PRIMARY KEY (EMP_ID)
    );
    ```
* **Foreign Key Constraints**
* **Not null Constraints**
  * Constraints on a column that doesn't allow a null value to be inserted.
  * Need to be placed on any columns you deem mandatory to avoid errors.
  * Example:
    ```sql
    CREATE TABLE CLIENTS1
    (
        FIRST_NAME VARCHAR(50),
        MIDDLE_NAME VARCHAR(50),
        LAST_NAME VARCHAR(50) NOT NULL
    );
    ```

### Other Constraints:
* Unique Contraints
* Check Constraints

> **Note:** Null does not equal zero but the absence of information.

## Handling Nulls

* Nulls in mathematical operations result in NULL
  * Example: 65,000 + NULL = NULL
* Use ISNULL() function to replace nulls in queries:
```sql
SELECT
    EMP_ID,
    EMP_LAST_NAME,
    SALARY,
    BONUS,
    SALARY + ISNULL(BONUS, 0) AS TOTAL_COMPENSATION
FROM EMPLOYEES0;
```

* When filtering data, use IS NULL or IS NOT NULL:
```sql
-- This will NOT return NULL values
SELECT * FROM PRODUCTS99 WHERE MANUFACTURER_COUNTRY != 'Japan';

-- This will include NULL values
SELECT * FROM PRODUCTS99 
WHERE MANUFACTURER_COUNTRY != 'Japan' OR MANUFACTURER_COUNTRY IS NULL;
```

* Aggregate functions (COUNT, MAX, MIN) ignore nulls except COUNT(*):
```sql
-- This ignores NULL values in the count
SELECT COUNT(MANUFACTURER_COUNTRY) FROM PRODUCTS99;
```

## Basic SQL Operations (DML - Data Manipulation Language)

* **INSERT** - Add new records
  ```sql
  INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) 
  VALUES ('751-03-1503', 1, 'Andrew', 'Rivers');
  ```

* **SELECT** - Retrieve data
  ```sql
  -- Select specific columns
  SELECT SSN, EMP_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES_TEST;

  -- Select all columns
  SELECT * FROM EMPLOYEES_TEST;
  ```

* **UPDATE** - Modify existing records
  ```sql
  UPDATE EMPLOYEES_TEST
  SET LAST_NAME = 'Miller'
  WHERE EMP_ID = 5;
  ```

* **DELETE** - Remove records
  ```sql
  DELETE FROM EMPLOYEES_TEST WHERE EMP_ID = 1;
  ```

## Transactions

* Use transactions to group operations that can be committed or rolled back:
  ```sql
  BEGIN TRANSACTION;

  INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) 
  VALUES ('257-35-8088', 6, 'Nigel', 'Williams');

  -- Undo changes
  ROLLBACK;

  -- Or save changes
  COMMIT TRANSACTION;
  ```

## DDL (Data Definition Language)

* **CREATE TABLE** - Creates a new table
* **DROP TABLE** - Deletes a table
  ```sql
  DROP TABLE EMPLOYEES_TEST;
  ```

