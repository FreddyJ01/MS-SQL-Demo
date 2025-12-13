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

---------------------
-- LEFT OUTER JOIN --
---------------------







----------------------
-- RIGHT OUTER JOIN --
----------------------

---------------------
-- FULL OUTER JOIN --
---------------------