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