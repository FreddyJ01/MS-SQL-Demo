----------------
-- INNER JOIN --
----------------
-- Join allows us to return columns from different tables in the same result set
-- Production.Product Contains the Name and ProductNumber we want, but Production.ProductSubCategory Contains the Category Name we want. 
-- Lets do and INNER JOIN
-- Schema.Table <TableAlias> : Production.Product P
-- INNER JOIN <Schema.Table> <Alias> : This is the table you want to join from
-- ON defines the join condition : These tables will only join ON rows where P.ProductSubcategoryID is equal to PS.ProductSubcategoryID, using their foreign key relationship. If a match exists, return the row with the match.
-- INNER JOIN only finds rows where the joining key appears in both tables.

SELECT P.Name, P.ProductNumber, PS.Name AS 'ProductSubCategory Name'
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID;


-- Find the SubCategory and Category Name in a single query
SELECT P.Name AS 'Product Category', PS.Name AS 'Product SubCategory'
FROM Production.ProductCategory P
INNER JOIN Production.ProductSubCategory PS
ON PS.ProductCategoryID = P.ProductCategoryID;

-- I want FirstName and LastName From Person.Person But the Email Address From Person.EmailAddress and Phone number from Person.PersonPhone
SELECT P.FirstName AS 'Employee First Name', P.LastName AS 'Employee Last Name', PP.PhoneNumber AS 'Employee Phone Number', PE.EmailAddress AS 'Employee Email Address'
FROM Person.Person P
INNER JOIN Person.EmailAddress PE
ON P.BusinessEntityID = PE.BusinessEntityID
INNER JOIN Person.PersonPhone PP
ON P.BusinessEntityID = PP.BusinessEntityID;

-- Really proud of this query
SELECT P.FirstName AS 'Employee First Name', P.LastName AS 'Employee Last Name', PP.PhoneNumber AS 'Employee Phone Number', PE.EmailAddress AS 'Employee Email Address'
FROM Person.Person P
INNER JOIN Person.EmailAddress PE
ON P.BusinessEntityID = PE.BusinessEntityID
INNER JOIN Person.PersonPhone PP
ON P.BusinessEntityID = PP.BusinessEntityID
WHERE P.FirstName LIKE '___'
ORDER BY 3;

----------------------------------
-- INNER JOIN Practice Problems --
----------------------------------
-- #1 Using the Person.Person and Person.Password tables, INNER JOIN the two tables using the BusinessEntityID column and return the FirstName and LastName columns from Person.Person and the PasswordHash column from Person.Password.
SELECT P.FirstName AS 'LastName', P.LastName AS "Last Name", PP.PasswordHash AS 'Hash'
FROM Person.Person P
INNER JOIN Person.Password PP
ON P.BusinessEntityID = PP.BusinessEntityID;

-- #2 Join the HumanResources.Employee and the HumanResources.EmployeeDepartmentHistory tables together via an INNER JOIN using the BusinessEntityID column. Return: BusinessEntityID NationalIDNumber JobTitle (from HumanResources.Employee) DepartmentID StartDate EndDate (from HumanResources.EmployeeDepartmentHistory) Notice the number of rows returned. Why is the row count what it is?
SELECT E.BusinessEntityID AS 'Biz Entity ID', E.NationalIDNumber, E.JobTitle, EDH.DepartmentID, EDH.StartDate, EDH.EndDate
FROM HumanResources.Employee E
INNER JOIN HumanResources.EmployeeDepartmentHistory EDH
ON E.BusinessEntityID = EDH.BusinessEntityID;

-- #3 Expand upon the query used in question 1. Using the existing query, add another INNER JOIN to the Person.EmailAddress table and include the EmailAddress column in your SELECT statement.
SELECT P.FirstName, P.LastName, PP.PasswordHash, PE.EmailAddress
FROM Person.Person P
INNER JOIN Person.Password PP
ON P.BusinessEntityID = PP.BusinessEntityID
INNER JOIN Person.EmailAddress PE
ON P.BusinessEntityID = PE.BusinessEntityID;

----------------------------------------
-- LEFT OUTER JOIN & RIGHT OUTER JOIN --
----------------------------------------
-- Converting an inner join to OUTER JOIN
SELECT P.Name, P.ProductNumber, PS.Name AS 'Product SubCategory ID'
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS
ON PS.ProductCategoryID = P.ProductSubcategoryID;

-- These 2 Queries return the exact same set:

-- This says we want everything from Production.Product AND anything from Production.ProductSubCategory IF it meets our ON condition.
SELECT P.Name, P.ProductNumber, PS.Name AS 'Product SubCategory ID'
FROM Production.Product P -- Left Table
LEFT OUTER JOIN Production.ProductSubcategory PS -- Right Table
ON PS.ProductCategoryID = P.ProductSubcategoryID;

-- This says we want everything from Production.Product AND anything from Production.ProductSubCategory IF it meets our ON condition.
SELECT P.Name, P.ProductNumber, PS.Name AS 'Product SubCategory ID'
FROM Production.ProductSubcategory PS -- Left Table
RIGHT OUTER JOIN Production.Product P -- Right Table
ON PS.ProductCategoryID = P.ProductSubcategoryID;

SELECT P.FirstName, P.LastName, SOH.SalesOrderNumber, SOH.TotalDue AS 'Sales Amount', ST.Name AS 'Territory Name'
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesPerson SP
ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT OUTER JOIN HumanResources.Employee E
ON SP.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Person.Person P
ON P.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID;

SELECT P.FirstName, P.LastName, SOH.SalesOrderNumber, SOH.TotalDue AS 'Sales Amount', ST.Name AS 'Territory Name'
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesPerson SP
ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT OUTER JOIN HumanResources.Employee E
ON SP.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Person.Person P
ON P.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest';

SELECT P.FirstName, P.LastName, SOH.SalesOrderNumber, SOH.TotalDue AS 'Sales Amount', ST.Name AS 'Territory Name'
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesPerson SP
ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT OUTER JOIN HumanResources.Employee E
ON SP.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Person.Person P
ON P.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest'
ORDER BY 4 DESC;
--------------------------------------
-- LEFT & RIGHT OUTER JOIN PRACTICE --
--------------------------------------
/* 
#1
- Return the BusinessEntityID and SalesYTD columns from the Sales.SalesPerson table.
- Join this table to the Sales.SalesTerritory table in such a way that every salesperson is returned, regardless of whether or not they are assigned to a territory.
- Also return the Name column from Sales.SalesTerritory.
- Give this column the alias "Territory Name".
*/

SELECT SP.BusinessEntityID, SP.SalesYTD, ST.Name AS 'Territory Name'
FROM Sales.SalesPerson SP -- Left Table
LEFT OUTER JOIN Sales.SalesTerritory ST -- Right Table
ON SP.TerritoryID = ST.TerritoryID;

/*
#2
Using the previous example as your foundation, join to the Person.Person table to return the salesperson’s first name and last name.
Now, only include rows where the territory’s name is either "Northeast" or "Central".
*/

SELECT P.FirstName, P.LastName, SP.BusinessEntityID, SP.SalesYTD, ST.Name AS 'Territory Name'
FROM Sales.SalesPerson SP
LEFT OUTER JOIN Sales.SalesTerritory ST
ON SP.TerritoryID = ST.TerritoryID
INNER JOIN Person.Person P
ON SP.BusinessEntityID = P.BusinessEntityID
WHERE ST.Name IN ('Northeast', 'Central');

/*
#3
Return the Name and ListPrice columns from Production.Product.
For each product, regardless of whether or not it has an assigned ProductSubcategoryID, return:
The Name column from Production.ProductSubcategory
The Name column from Production.ProductCategory
Use the following column aliases:
Production.Product.Name → ProductName
Production.ProductSubcategory.Name → ProductSubcategoryName
Production.ProductCategory.Name → ProductCategoryName
Order the results by:
ProductCategoryName (descending)
ProductSubcategoryName (ascending)
*/

SELECT P.Name AS 'ProductName', P.ListPrice, PSC.Name AS 'ProductSubCategoryName', PC.Name AS 'ProductCategoryName'
FROM Production.Product P -- Left Table
LEFT OUTER JOIN Production.ProductCategory PC
ON P.ProductSubcategoryID = PC.ProductCategoryID
LEFT OUTER JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
ORDER BY PC.Name DESC, PSC.Name;

---------------------
-- FULL OUTER JOIN --
---------------------
-- I believe this says, we want all the data from Production.Product AND Production.ProductSubCategory WHERE P.ProductID is NOT Found in Production.ProductSubCategory. Essentially we are finding the data that is not related between the Tables.
SELECT P.Name AS 'Product Name', PS.Name AS 'Product SubCategory Name'
FROM Production.Product P
FULL OUTER JOIN Production.ProductSubcategory PS
ON P.ProductID = PS.ProductSubcategoryID;