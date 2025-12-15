# MS SQL Server Demo - Comprehensive SQL Notes

A comprehensive guide to MS SQL Server fundamentals with practical examples using the AdventureWorks2012 database.

---

## Table of Contents
1. [Basic SELECT Statements](#basic-select-statements)
2. [The 6 Basic SQL Clauses](#the-6-basic-sql-clauses)
3. [WHERE Clause Operators](#where-clause-operators)
4. [IN and BETWEEN Operators](#in-and-between-operators)
5. [Wildcard Operators](#wildcard-operators)
6. [Column and Table Aliases](#column-and-table-aliases)
7. [JOIN Operations](#join-operations)
8. [Aggregate Functions](#aggregate-functions)
9. [Views vs Tables](#views-vs-tables)
10. [Best Practices](#best-practices)

---

## Basic SELECT Statements

### Literal SELECT Statements
You can use SELECT to evaluate strings and mathematical expressions without querying a table:

```sql
-- String literals
SELECT 'Brewster Knowlton'
SELECT 'Brewster', 'Knowlton'
SELECT 'Brewster''s SQL Training Class'  -- Use two single quotes to escape

-- Mathematical expressions (follows PEMDAS)
SELECT 1 + 1
SELECT 5 - 3
SELECT 4 / 4
SELECT 7 * 4
SELECT (7 - 4) * 8
SELECT 'Day 1 of Training', 5 * 3
```

### Basic Query Syntax
```sql
SELECT [Column1], [Column2], ..., [ColumnN] 
FROM [DatabaseName].[SchemaName].[TableName]
```

### Examples
```sql
USE AdventureWorks2012;
GO

-- Single column
SELECT FirstName FROM Person.Person;

-- Multiple columns
SELECT FirstName, LastName FROM Person.Person;
SELECT FirstName, MiddleName, LastName FROM Person.Person;

-- All columns
SELECT * FROM Person.Person;
```

### Limiting Results with TOP

**TOP** limits the number of rows returned to improve query performance:

```sql
-- Return top 500 rows
SELECT TOP 500 FirstName, MiddleName, LastName FROM Person.Person;

-- Return top 10% of rows
SELECT TOP 10 PERCENT FirstName, MiddleName, LastName FROM Person.Person;

-- Combine with all columns
SELECT TOP 100 * FROM Production.Product;
```

---

## The 6 Basic SQL Clauses

### 1. SELECT Clause
Specifies which columns to retrieve from the database.

```sql
SELECT FirstName, LastName
SELECT *  -- All columns
SELECT TOP 100 FirstName
SELECT TOP 10 PERCENT *
```

### 2. FROM Clause
Specifies the table or view to query data from.

```sql
FROM Person.Person
FROM Sales.SalesOrderHeader
FROM HumanResources.vEmployee  -- View
```

### 3. WHERE Clause
Filters rows based on specified conditions.

```sql
SELECT * 
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer'

SELECT * 
FROM Production.Product
WHERE ListPrice > 100
```

### 4. GROUP BY Clause
Groups rows that have the same values in specified columns, typically used with aggregate functions.

```sql
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle
```

### 5. HAVING Clause
Filters grouped rows (used after GROUP BY), similar to WHERE but for aggregated data.

```sql
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING COUNT(*) > 5
```

### 6. ORDER BY Clause
Sorts the result set by one or more columns.

```sql
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName ASC

SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName DESC, FirstName ASC
```

---

## WHERE Clause Operators

### Comparison Operators
- `=` Equal to
- `>` Greater than
- `<` Less than
- `>=` Greater than or equal to
- `<=` Less than or equal to
- `<>` or `!=` Not equal to

### Logical Operators
- `AND` - All conditions must be true
- `OR` - At least one condition must be true
- `NOT` - Negates a condition

```sql
SELECT * 
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer' AND Gender = 'M'

SELECT * 
FROM Production.Product
WHERE Color = 'Red' OR Color = 'Blue'

SELECT * 
FROM HumanResources.Employee
WHERE NOT JobTitle = 'Design Engineer'
```

---

## IN and BETWEEN Operators

### IN Operator
Checks if a value matches any value in a list. More efficient and readable than multiple OR conditions.

```sql
-- Instead of: WHERE Color = 'Red' OR Color = 'Blue' OR Color = 'Black'
SELECT * 
FROM Production.Product
WHERE Color IN ('Red', 'Blue', 'Black')

-- With NOT
SELECT * 
FROM Production.Product
WHERE Color NOT IN ('Red', 'Blue', 'Black')

-- With numbers
SELECT * 
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (11000, 11001, 11002)
```

### BETWEEN Operator
Checks if a value falls within a specified range (inclusive).

```sql
-- Numeric range
SELECT * 
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 500

-- Date range
SELECT * 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2008-01-01' AND '2008-12-31'

-- With NOT
SELECT * 
FROM Production.Product
WHERE ListPrice NOT BETWEEN 100 AND 500
```

---

## Wildcard Operators

Wildcards are used with the **LIKE** operator for pattern matching in strings.

### Wildcard Characters

| Wildcard | Description | Example |
|----------|-------------|---------|
| `%` | Matches any string of zero or more characters | `'A%'` matches anything starting with A |
| `_` | Matches any single character | `'A_'` matches A followed by any single character |
| `[]` | Matches any single character within the brackets | `'[ABC]%'` matches starting with A, B, or C |
| `[^]` | Matches any single character NOT in the brackets | `'[^ABC]%'` doesn't start with A, B, or C |
| `-` | Specifies a range of characters | `'[A-C]%'` matches starting with A, B, or C |

### Examples

```sql
-- Starts with 'A'
SELECT * 
FROM Person.Person
WHERE FirstName LIKE 'A%'

-- Ends with 'son'
SELECT * 
FROM Person.Person
WHERE LastName LIKE '%son'

-- Contains 'ann'
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '%ann%'

-- Second character is 'o'
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '_o%'

-- Starts with A, B, or C
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '[ABC]%'

-- Does NOT start with A, B, or C
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '[^ABC]%'

-- Starts with letters A through M
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '[A-M]%'

-- Exactly 4 characters
SELECT * 
FROM Person.Person
WHERE FirstName LIKE '____'
```

---

## Column and Table Aliases

### Column Aliases

Aliases rename columns in the query output using the **AS** keyword (optional but recommended for readability).

```sql
-- Using AS keyword
SELECT TOP 100 
    FirstName AS [Customer First Name], 
    MiddleName, 
    LastName AS "Customer Last Name" 
FROM Person.Person;

-- Without AS keyword (still works)
SELECT 
    NationalIDNumber SSN,
    JobTitle "Job Title",
    BirthDate
FROM HumanResources.Employee;

-- Handling aliases with special characters
SELECT Name AS "Product's Name" 
FROM Production.vProductAndDescription;
```

**Note:** Column aliases do NOT change the actual column names in the database; they only affect the query output.

### Table Aliases

Table aliases simplify queries, especially when working with JOINs.

```sql
-- Simple alias
SELECT e.FirstName, e.LastName, e.JobTitle
FROM HumanResources.Employee AS e

-- Multiple tables with aliases
SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM Person.Person AS p
INNER JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
```

---

## JOIN Operations

JOINs combine rows from two or more tables based on related columns.

### Types of JOINs

#### INNER JOIN
Returns only matching rows from both tables.

```sql
SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM Person.Person AS p
INNER JOIN HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID
```

#### LEFT JOIN (LEFT OUTER JOIN)
Returns all rows from the left table and matching rows from the right table. Non-matching rows from the right table will have NULL values.

```sql
SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID
```

#### RIGHT JOIN (RIGHT OUTER JOIN)
Returns all rows from the right table and matching rows from the left table. Non-matching rows from the left table will have NULL values.

```sql
SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM Person.Person AS p
RIGHT JOIN HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID
```

#### FULL JOIN (FULL OUTER JOIN)
Returns all rows when there is a match in either table. Non-matching rows will have NULL values.

```sql
SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM Person.Person AS p
FULL JOIN HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID
```

#### CROSS JOIN
Returns the Cartesian product of both tables (every row from the first table combined with every row from the second table).

```sql
SELECT 
    p.FirstName, 
    c.Color
FROM Person.Person AS p
CROSS JOIN Production.Product AS c
```

### Self JOIN
Joins a table to itself.

```sql
SELECT 
    e1.FirstName AS Employee, 
    e2.FirstName AS Manager
FROM HumanResources.Employee AS e1
LEFT JOIN HumanResources.Employee AS e2 
    ON e1.ManagerID = e2.BusinessEntityID
```

---

## Aggregate Functions

Aggregate functions perform calculations on a set of values and return a single value.

### Common Aggregate Functions

#### COUNT()
Counts the number of rows.

```sql
-- Count all rows
SELECT COUNT(*) AS TotalEmployees
FROM HumanResources.Employee

-- Count non-NULL values in a specific column
SELECT COUNT(MiddleName) AS EmployeesWithMiddleName
FROM Person.Person

-- Count distinct values
SELECT COUNT(DISTINCT JobTitle) AS UniqueJobTitles
FROM HumanResources.Employee
```

#### SUM()
Calculates the total sum of a numeric column.

```sql
SELECT SUM(ListPrice) AS TotalListPrice
FROM Production.Product

SELECT SUM(OrderQty) AS TotalQuantityOrdered
FROM Sales.SalesOrderDetail
```

#### AVG()
Calculates the average value of a numeric column.

```sql
SELECT AVG(ListPrice) AS AveragePrice
FROM Production.Product

SELECT AVG(OrderQty) AS AverageQuantity
FROM Sales.SalesOrderDetail
```

#### MIN()
Returns the minimum value.

```sql
SELECT MIN(ListPrice) AS CheapestProduct
FROM Production.Product

SELECT MIN(OrderDate) AS FirstOrder
FROM Sales.SalesOrderHeader
```

#### MAX()
Returns the maximum value.

```sql
SELECT MAX(ListPrice) AS MostExpensiveProduct
FROM Production.Product

SELECT MAX(OrderDate) AS MostRecentOrder
FROM Sales.SalesOrderHeader
```

### Using Aggregate Functions with GROUP BY

```sql
-- Count employees by job title
SELECT 
    JobTitle, 
    COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle

-- Average price by product category
SELECT 
    ProductCategoryID, 
    AVG(ListPrice) AS AveragePrice,
    COUNT(*) AS ProductCount
FROM Production.Product
GROUP BY ProductCategoryID

-- Total sales by customer
SELECT 
    CustomerID, 
    SUM(TotalDue) AS TotalSales,
    COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
```

### Using HAVING with Aggregate Functions

```sql
-- Job titles with more than 5 employees
SELECT 
    JobTitle, 
    COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING COUNT(*) > 5

-- Product categories with average price over 500
SELECT 
    ProductCategoryID, 
    AVG(ListPrice) AS AveragePrice
FROM Production.Product
GROUP BY ProductCategoryID
HAVING AVG(ListPrice) > 500
```

---

## Views vs Tables

### What is a View?
A **view** is a virtual table based on the result of a SQL query. Views simplify complex queries, reduce the need for excessive JOINs, and provide a layer of abstraction.

### Naming Convention
Views follow the same naming convention as tables but with a preceding lowercase 'v':
- Table: `HumanResources.Employee`
- View: `HumanResources.vEmployee`

### Benefits of Views
1. **Simplified Queries**: Consolidate complex JOINs into a single view
2. **Security**: Hide sensitive columns from users
3. **Consistency**: Ensure consistent data access patterns
4. **Reusability**: Use the same complex query in multiple places

### Example

```sql
-- Querying a view
SELECT * FROM HumanResources.vEmployee;
SELECT * FROM Sales.vIndividualCustomer;
SELECT TOP 10 FirstName, LastName, EmailAddress, PhoneNumber 
FROM Sales.vIndividualCustomer;

-- Comparing view vs table
SELECT * FROM HumanResources.vEmployee;  -- Pre-joined data
SELECT * FROM HumanResources.Employee;   -- Raw table data
```

---

## Best Practices

### Performance Optimization
1. **Use TOP to limit results** when working with large datasets
   ```sql
   SELECT TOP 500 * FROM LargeTable;
   ```

2. **Select only needed columns** instead of using `SELECT *`
   ```sql
   -- Good
   SELECT FirstName, LastName FROM Person.Person;
   
   -- Avoid (unless necessary)
   SELECT * FROM Person.Person;
   ```

3. **Use appropriate indexes** on frequently queried columns

4. **Use EXISTS instead of IN** for subqueries when checking existence

### Query Organization
1. **Use consistent formatting** and indentation
2. **Add comments** to explain complex logic
3. **Use meaningful aliases** for tables and columns
4. **Group related conditions** in WHERE clauses with parentheses

### Code Style
```sql
-- Good formatting example
SELECT 
    p.FirstName AS [First Name],
    p.LastName AS [Last Name],
    e.JobTitle AS [Job Title],
    e.HireDate
FROM Person.Person AS p
INNER JOIN HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.JobTitle LIKE '%Engineer%'
    AND e.HireDate >= '2008-01-01'
ORDER BY e.HireDate DESC;
```

### Common Pitfalls to Avoid
1. **Forgetting to use TOP** with large tables
2. **Using SELECT *** in production code
3. **Not handling NULL values** properly
4. **Using OR when IN would be cleaner**
5. **Forgetting to specify sort order** (ASC/DESC) in ORDER BY

---

## Database Context

This repository uses the **AdventureWorks2012** sample database. Always ensure you're in the correct database context:

```sql
USE AdventureWorks2012;
GO
```

---

## Additional Resources

- Practice problems included in each SQL file
- Covers HumanResources, Sales, Production schemas
- Examples use real-world scenarios from AdventureWorks2012

---

## Repository Structure

```
.
├── SELECT_Statements.sql      # Basic SELECT queries and TOP operator
├── WHERE_Statements.sql       # Filtering with WHERE clause
├── ORDER_BY_Statements.sql    # Sorting results
├── GROUP_BY_Statements.sql    # Grouping data
├── HAVING_Statements.sql      # Filtering grouped data
├── JOIN.sql                   # JOIN operations
├── AggregateFunctions.sql     # Aggregate functions (COUNT, SUM, AVG, etc.)
└── README.md                  # This file
```

---

## Getting Started

1. Ensure you have MS SQL Server installed
2. Install the AdventureWorks2012 sample database
3. Open SQL Server Management Studio (SSMS) or Azure Data Studio
4. Run the queries in each file to learn and practice

---

## Practice Approach

Each SQL file contains:
- Conceptual explanations
- Practical examples
- Practice problems with solutions

Work through the files in order for a structured learning path:
1. SELECT_Statements.sql
2. WHERE_Statements.sql
3. ORDER_BY_Statements.sql
4. AggregateFunctions.sql
5. GROUP_BY_Statements.sql
6. HAVING_Statements.sql
7. JOIN.sql

---

## Notes

- All queries in this repo use the AdventureWorks2012 database
- Examples progress from simple to complex
- Comments explain the purpose and logic of each query
- Practice problems help reinforce concepts

---

**Happy Querying! 🚀**