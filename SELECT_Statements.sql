----------------------------------------
-- Literal SELECT Statements (Strings)--
----------------------------------------
SELECT 'Brewster Knowlton'
SELECT 'Brewster', 'Knowlton'
SELECT 'Fred Johnson'
SELECT 'Brewster''s SQL Training Class'
---------------------------------------------------------------------------
-- Literal SELECT Statements to evaluate mathmatical expressions (PEMDAS)--
---------------------------------------------------------------------------
SELECT 1 + 1
SELECT 5 - 3
SELECT 4 / 4
SELECT 7 * 4
SELECT (7 - 4) * 8
SELECT 'Day 1 of Training', 5 * 3
--------------------------------------------------------------------------------------------------------
-- Basic SELECT Statements (Simple SELECT statement as the front clause, with no filtering or sorting)--
--------------------------------------------------------------------------------------------------------
-- SELECT Clause is what data you want
-- FROM Clause is where you want the data from
-- Ex. SELECT [Column 1], [Column 2], ..., [Column N] FROM [Database Name].[Schema Name].[Table Name]
-- Que: SELECT [Attributes you need] FROM [Table you need them from]

USE AdventureWorks2012;
GO

SELECT FirstName FROM Person.Person;
SELECT FirstName, LastName FROM Person.Person;
SELECT FirstName, MiddleName, LastName FROM Person.Person;

-- Large Queries slow down query time and take resources, this can be fixed by using the TOP operator.
SELECT TOP 500 FirstName, MiddleName, LastName FROM Person.Person;
SELECT TOP 10 PERCENT FirstName, MiddleName, LastName FROM Person.Person;

SELECT * FROM Person.Person;
SELECT TOP 100 * FROM Production.Product;

-- Custom Alias' using the AS operator and [] brackets or "" quotes will not change the column name in the table but it will change the column name that is displayed in the query return.
SELECT TOP 100 FirstName AS [Customer First Name], MiddleName, LastName AS "Customer Last Name" FROM Person.Person;

-- Queriying Views instead of Tables
-- A view is a virtual table and prevent the need for excessive JOINs which we will touch later. Views also allow for consolidated and cleaner queries than tables. To make commonly accessed information easier.
-- The naming convention for a view is the same as a table but with a preceeding lowercase 'v'
SELECT * FROM HumanResources.vEmployee;
SELECT * FROM HumanResources.Employee;

SELECT TOP 10 FirstName, LastName, EmailAddress, PhoneNumber FROM Sales.vIndividualCustomer;
-----------------------
-- Practice Problems --
-----------------------
-- #1 Retrieve all rows from the HumanResources.Employee table. Return only the NationalIDNumber column.
SELECT NationalIDNumber FROM HumanResources.Employee;
-- #2 Retrieve all rows from the HumanResources.Employee table. Return the NationalIDNumber and JobTitle columns.
SELECT NationalIDNumber, JobTitle FROM HumanResources.Employee;
-- #3 Retrieve the top 20 percent of rows from the HumanResources.Employee table. Return the NationalIDNumber, JobTitle, and BirthDate columns.
SELECT TOP 20 PERCENT NationalIDNumber, JobTitle, BirthDate FROM HumanResources.Employee;
-- #4 Retrieve the top 500 rows from the HumanResources.Employee table. Return the NationalIDNumber, JobTitle, and BirthDate columns. Give the NationalIDNumber column an alias SSN, and the JobTitle column an alias Job Title.
SELECT TOP 500 NationalIDNumber AS "SSN", JobTitle AS "Job Title", BirthDate FROM HumanResources.Employee;
-- #5 Return all rows and all columns from the Sales.SalesOrderHeader table.
SELECT * FROM Sales.SalesOrderHeader;
-- #6 Return the top 50 percent of rows and all columns from the Sales.Customer table.
SELECT TOP 50 PERCENT * FROM Sales.Customer;
-- #7 Return the Name column from the Production.vProductAndDescription view. Give this column an alias Product’s Name.
SELECT Name AS "Product''s Name" FROM Production.vProductAndDescription;
-- #8 Return the top 400 rows from HumanResources.Department.
SELECT TOP 400 * FROM HumanResources.Department;
-- #9 Return all rows and columns from the table Production.BillOfMaterials.
SELECT * FROM Production.BillOfMaterials;
-- #10 Return the top 1500 rows and columns from the view Sales.vPersonDemographics.
SELECT TOP 1500 * FROM Sales.vPersonDemoGraphics;