------------------
-- WHERE CLAUSE --
------------------
-- WHERE [Column Name] {Comparison Operator} [Some Value]
-- WHERE clause filters rows of data based on specific column values
---------------
-- Operators --
---------------
/*
< : Less Than
> : Greater Than
<= : Less Than or Equal To
>= : Greater Than or Equal To
= : Equal To
!= / <> : Not Equal To
*/
SELECT *
FROM Production.Product
WHERE ListPrice >= 10;
---------------------
-- Practice Queries--
---------------------
SELECT *
FROM Production.Product
WHERE ListPrice > 10;

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName = 'Chris';

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName != 'Chris';

-- Filter Dates, SQL does a good job of interpreting date values
SELECT *
FROM HumanResources.Employee
WHERE BirthDate >= '1-1-1980';

SELECT *
FROM HumanResources.Employee
WHERE BirthDate <= '1-1-1980';

-- AND, OR operators to comibine filtering criteria
SELECT *
FROM HumanResources.Employee
WHERE BirthDate >= '1-1-1980' AND Gender = 'F';

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'M';

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' OR Gender = 'M';

-- Additional Complexity (Conjunction - AND operations) (Disjunctions - OR operations) Otherwise known as (Logic PEMDAS)
-- We can use Parenthesis to force SQL to evaluate logic in a specific order
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND (Gender = 'M' OR OrganizationLevel = 4);

SELECT *
FROM Production.Product
WHERE ListPrice > 100 AND Color = 'Red' OR StandardCost > 30;

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department = 'Research and Development' OR (StartDate < '1-1-2005' AND Department = 'Executive');

Select FirstName
FROM
(
    SELECT FirstName, LOWER(LEFT(TRIM(FirstName), 1)) AS FirstLetter, LOWER(RIGHT(FirstName, 1)) AS LastLetter FROM Person.Person
) AS Subquery
WHERE
(
    FirstLetter = 'a' OR FirstLetter = 'e' OR FirstLetter = 'i' OR FirstLetter = 'o' OR FirstLetter = 'u'
) AND
(
    LastLetter = 'a' OR LastLetter = 'e' OR LastLetter = 'i' OR LastLetter = 'o' OR LastLetter = 'u'
);

SELECT FirstName
FROM 
(
    SELECT FirstName, LOWER(LEFT(TRIM(FirstName), 1)) AS FirstLetter, LOWER(RIGHT(FirstName, 1)) AS LastLetter FROM Person.Person
) AS Subquery
WHERE 
(
    FirstLetter IN ('a', 'e', 'i', 'o', 'u') AND LastLetter IN ('a', 'e', 'i', 'o', 'u')
);

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE '[a,e,i,o,u]%[a,e,i,o,u]';
------------------------------
-- IN and BETWEEN Operators -- 
--   WILDCARD Characters    --
------------------------------
SELECT *
FROM HumanResources.vEmployee
WHERE FirstName = 'Chris' OR FirstName = 'Steve' OR FirstName = 'Thomas';

-- IN is a list of possible values
SELECT *
FROM HumanResources.vEmployee
WHERE FirstName IN ('Chris', 'Steve', 'Thomas');

-- BETWEEN is a range
SELECT *
FROM Sales.vStoreWithDemographics
WHERE AnnualSales >= 1000000 AND AnnualSales <= 2000000;

SELECT *
FROM Sales.vStoreWithDemographics
WHERE AnnualSales BETWEEN 1000000 AND 2000000;

-- Wildcard Operators, 
-- LIKE operator tells SQL to expect a wildcard character. 
-- The % is the wildcard character for 0 to many characters.
SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'Mi%'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE '%s'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE '%h%'

-- _ is the wildcard character for a single character.
SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'Mi__'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'D[a,o]n'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'D[a-f, r-z]n'

-- ^ is a negation
SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'D[^a-f, r-z]n'

-- Filtering NULL Values
SELECT *
FROM Person.Person
WHERE MiddleName IS NULL;

-----------------------
-- Practice Problems --
-----------------------
-- #1 Return the FirstName and LastName columns from Person.Person where the FirstName column is equal to "Mark".
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName = 'Mark';

-- #2 Find the top 100 rows from Production.Product where the ListPrice is not equal to 0.00.
SELECT TOP 100 *
FROM Production.Product
WHERE ListPrice != 0.00;

-- #3 Return all rows and columns from the view HumanResources.vEmployee where the employee’s last name starts with a letter less than "D".
SELECT *
FROM HumanResources.vEmployee
WHERE LastName < 'D';

-- #4 Return all rows and columns from Person.StateProvince where the CountryRegionCode column is equal to "CA".
SELECT *
FROM Person.StateProvince
WHERE CountryRegionCode = 'CA';

-- #5 Return the FirstName and LastName columns from the view Sales.vIndividualCustomer where the LastName is equal to "Smith". Give the column aliases "Customer First Name" and "Customer Last Name" respectively.
SELECT FirstName AS 'Customer First Name', LastName AS 'Customer Last Name'
FROM Sales.vIndividualCustomer
WHERE LastName = 'Smith';

-- #6 Using the Sales.vIndividualCustomer view, find: all customers with a CountryRegionName equal to "Australia", OR customers who have a PhoneNumberType equal to "Cell" AND an EmailPromotion value equal to 0.
SELECT *
FROM Sales.vIndividualCustomer
WHERE CountryRegionName = 'Australia' OR (PhoneNumberType = 'Cell' AND EmailPromotion = 0);

-- #7 Find all employees from the view HumanResources.vEmployeeDepartment who have a Department value in: "Executive" "Tool Design" "Engineering" Complete this query twice: once using the IN operator once using multiple OR operators
SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department IN ('Executive', 'Tool Design', 'Engineering');

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department = 'Executive' OR Department = 'Tool Design' OR Department = 'Engineering';

-- #8 Using HumanResources.vEmployeeDepartment, find all employees who have a StartDate between July 1, 2000 and June 30, 2002. Use BETWEEN and >= <=.
SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate BETWEEN '7-1-2010' AND '6-30-2011';

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate >= '7-1-2010' AND StartDate <= '6-30-2011';

-- #9 Find all customers from the view Sales.vIndividualCustomer whose LastName starts with the letter "R".
SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName LIKE 'R%';

-- #10 Find all customers from the view Sales.vIndividualCustomer whose LastName ends with the letter "r".
SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName LIKE '%r';

-- #11 Find all customers from the view Sales.vIndividualCustomer whose: LastName is "Lopez", "Martin", or "Wood", AND FirstName starts with any letter between "C" and "L".
SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName IN ('Lopez', 'Martin', 'Wood') AND FirstName LIKE '[c-l]%';

-- #12 Return all columns from Sales.SalesOrderHeader for all sales associated with a salesperson (i.e., SalesPersonID is NOT NULL).
SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL;

-- #13 Return the SalesPersonID and TotalDue columns from Sales.SalesOrderHeader where: SalesPersonID is NOT NULL TotalDue exceeds $70,000
SELECT SalesPersonID, TotalDue
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL AND TotalDue > 70000;