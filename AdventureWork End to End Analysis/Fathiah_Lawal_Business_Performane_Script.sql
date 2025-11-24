
USE AdventureWorks2022;
GO

SELECT
    -------------------------------------------------------------------
    -- Primary Keys
    -------------------------------------------------------------------
    soh.SalesOrderID,
    sod.SalesOrderDetailID,
    p.ProductID,
    c.CustomerID,
    soh.TerritoryID,

    -------------------------------------------------------------------
    -- Product Information
    -------------------------------------------------------------------
    p.Name AS ProductName,
    p.ProductNumber,
    pc.Name AS ProductCategory,
    psc.Name AS ProductSubcategory,
    p.StandardCost,
    p.ListPrice,

    -------------------------------------------------------------------
    -- Sales Order Detail (Line-Level Facts)
    -------------------------------------------------------------------
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal,   -- revenue before cost


    -------------------------------------------------------------------
    -- Sales Order Header (Transaction-Level Info)
    -------------------------------------------------------------------
    soh.OrderDate,
    soh.DueDate,
    soh.ShipDate,
    soh.Status AS OrderStatus,
    soh.SubTotal AS OrderSubTotal,
    soh.TaxAmt,
    soh.Freight,
    soh.TotalDue,
    soh.OnlineOrderFlag,

    -------------------------------------------------------------------
    -- Customer Info
    -------------------------------------------------------------------
    CASE 
        WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
        ELSE 'Individual'
    END AS CustomerType,

    p2.FirstName AS CustomerFirstName,
    p2.LastName AS CustomerLastName,
    p2.EmailPromotion,

    -------------------------------------------------------------------
    -- Territory Info
    -------------------------------------------------------------------
    st.Name AS TerritoryName,
    st.CountryRegionCode,
    st.[Group] AS SalesGroup

FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh 
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p 
    ON sod.ProductID = p.ProductID
LEFT JOIN Production.ProductSubcategory psc 
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc 
    ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.Customer c 
    ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person p2 
    ON c.PersonID = p2.BusinessEntityID
LEFT JOIN Sales.Store s 
    ON c.StoreID = s.BusinessEntityID
LEFT JOIN Sales.SalesTerritory st 
    ON soh.TerritoryID = st.TerritoryID
WHERE p.StandardCost > 0;

