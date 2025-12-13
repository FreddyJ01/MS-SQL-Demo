-------------------------
-- Aggregate Functions --
-------------------------
/*
Perform operation against set of values to return a specified value.
Aggregate functions are essential when using GROUP BY and HAVING Clauses
MAX, MIN, COUNT, DISTINCT
SUM, AVG, STDEV
ROUND(<value_to_round>, <decimals to round to>)
*/

-- We want to return the Largest TotalDue Row in Sales.SalesOrderHeader
SELECT MAX(TotalDue)
FROM Sales.SalesOrderHeader;

SELECT MIN(TotalDue)
FROM Sales.SalesOrderHeader;

SELECT COUNT(*) -- Count the Number of rows in this table
FROM Sales.SalesOrderHeader;

SELECT COUNT(*)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL;

SELECT COUNT(TotalDue) -- Counts NON NULL Values
FROM Sales.SalesOrderHeader;

SELECT COUNT(DISTINCT FirstName)
FROM Person.Person;

SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader;

SELECT SUM(TotalDue)
FROM Sales.SalesOrderHeader;

SELECT STDEV(TotalDue)
FROM Sales.SalesOrderHeader;

SELECT TotalDue
FROM Sales.SalesOrderHeader
ORDER BY 1 DESC;

SELECT SUM(TotalDue)
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1-1-2006' AND '12-31-2006';

-----------------------
-- Practice Problems --
-----------------------
/*
#1
How many rows are in the Person.Person table?
Use an aggregate function NOT SELECT *.
*/

SELECT COUNT(*)
FROM Person.Person;

/*
#2
How many rows in the Person.Person table do not have a NULL value in the MiddleName column?
*/

SELECT COUNT(*)
FROM Person.Person
WHERE MiddleName IS NOT NULL;

/*
#3
What is the average StandardCost (located in Production.Product) for each product where the StandardCost is greater than $0.00?
*/

SELECT ROUND(AVG(StandardCost), 2) AS 'Standard Cost Average'
FROM Production.Product
WHERE StandardCost > 0.00;

/*
#4
What is the average Freight amount for each sale (found in Sales.SalesOrderHeader) where the sale took place in TerritoryID 4?
*/

SELECT ROUND(AVG(Freight), 2) AS 'Average Freight In Territory 4'
FROM Sales.SalesOrderHeader
WHERE TerritoryID = 4;

/*
#5
How expensive is the most expensive product, by ListPrice, in the table Production.Product?
*/

SELECT ROUND(MAX(ListPrice), 0) AS 'Most Expensive Product'
FROM Production.Product;

/*
#6
Join the Production.Product table and the Production.ProductInventory table for only the products that appear in both tables.
Use ProductID as the joining column.
Production.ProductInventory contains the quantity of each product.
Several rows can appear for each product to indicate the product appears in multiple locations.
Goal:
Determine how much money would be earned if every product were sold at its list price for each product with a ListPrice greater than $0.
*/

SELECT SUM(ListPrice*PI.Quantity) AS 'Total List Price'
FROM Production.Product P
INNER JOIN Production.ProductInventory PI
ON P.ProductID = PI.ProductID
WHERE P.ListPrice > 0;