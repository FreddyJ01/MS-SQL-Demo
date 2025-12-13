---------------------------------------
-- GROUP BY clause for grouping data --
---------------------------------------
-- GROUP BY [Column Name]
-- If not an Aggregate, all Selected Columns in your SELECT Statement to be in your GROUP BY clause.

SELECT SalesPersonID, SUM(TotalDue) AS 'TotalSales'
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID;

SELECT ProductID, SUM(Quantity) AS 'Total Quantiy', COUNT(*) AS 'Total Locations'
FROM Production.ProductInventory
GROUP BY ProductID;

SELECT 
    P.FirstName + ' ' + P.LastName AS 'Full Name', -- Concatanates the two
    SOH.TerritoryID, SOH.SalesPersonID, 
    SUM(TotalDue) AS 'Total Sales'
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesPerson SP
ON SOH.SalesPersonID = SP.BusinessEntityID
INNER JOIN Person.Person P
ON SP.BusinessEntityID = P.BusinessEntityID
WHERE OrderDate BETWEEN '1/1/2010' AND '12/31/2015'
GROUP BY SOH.TerritoryID, SOH.SalesPersonID, P.FirstName + ' ' + P.LastName
ORDER BY SOH.TerritoryID, SOH.SalesPersonID;

-----------------------
-- Practice Problems --
-----------------------
/*
1) In the Person.Person table, how many people are associated with each PersonType?
*/

SELECT PersonType, COUNT(*) AS 'Quanity'
FROM Person.Person
GROUP BY PersonType;

/*
2) Using only one query, find out how many products in Production.Product are the color “red” and how many are “black”.
*/

SELECT Color, COUNT(*) AS Quantity
FROM Production.Product
WHERE Color IN ('Red', 'Black')
GROUP BY Color;

/*
3) Using Sales.SalesOrderHeader, how many sales occurred in each territory between July 1, 2011 and December 31, 2012?
Order the results by the sale count in descending order.
*/

SELECT ST.Name, COUNT(SOH.OrderDate) AS SaleCount
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE SOH.OrderDate BETWEEN '7/1/2011' AND '12/31/2012'
GROUP BY ST.Name
ORDER BY 2 DESC;

/*
4) Expanding on the previous example, group the results not by the TerritoryID but by the name of the territory (found in the Sales.SalesTerritory table).
*/

SELECT ST.Name, COUNT(SOH.OrderDate) AS SaleCount
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE SOH.OrderDate BETWEEN '7/1/2011' AND '12/31/2012'
GROUP BY ST.Name
ORDER BY 2 DESC;