--1

select FirstName, EmailAddress, CompanyName
from Customer
where CompanyName = 'Bike World'

--2

select CompanyName, City
from Customer a
left join CustomerAddress b
on a.CustomerID = b.CustomerID
left join Address c
on c.AddressID = b.AddressID
where City = 'Dallas'

--3

select COUNT(OrderQty) as 'no of items'
from SalesOrderDetail a
left join Product b 
on a.ProductID = b.ProductID
where ListPrice > 1000

--4

select CompanyName
from Customer a 
left join SalesOrderHeader b on a.CustomerID = b.CustomerID
where SubTotal + TaxAmt + Freight > 100000

--5

select SUM(a.OrderQty) AS 'Riding Cycles Orders'
from SalesOrderDetail a
left join Product b on a.ProductID  = b.ProductID
left join SalesOrderHeader c on a.SalesOrderID = c.SalesOrderID
left join Customer d on d.CustomerID = c.CustomerID
where Name = 'Racing Socks, L' 
and CompanyName = 'Riding Cycles'

--6

select SalesOrderID, UnitPrice
from SalesOrderDetail
where OrderQty = 1

--7

select a.Name, CompanyName
from ProductModel a
left join Product b on a.ProductModelID = b.ProductModelID
left join SalesOrderDetail c on b.ProductID = c.ProductID
left join SalesOrderHeader d on c.SalesOrderID = d.SalesOrderID
left join Customer e on d.CustomerID = e.CustomerID
where a.Name = 'Racing Socks'

--8

select Description 
from ProductDescription a
left join ProductModelProductDescription b on a.ProductDescriptionID = b.ProductDescriptionID
left join Product c on b.ProductModelID = c.ProductModelID
where Culture = 'fr'
and ProductID = 736

--9

select CompanyName, SubTotal, Weight
from Customer a
left join SalesOrderHeader b on a.CustomerID = b.CustomerID
left join SalesOrderDetail c on b.SalesOrderID = c.SalesOrderID
left join Product d on c.ProductID = d.ProductID
order by SubTotal desc

--10

select sum(*) as 'sold to London'
from SalesOrderDetail a
left join SalesOrderHeader b on a.SalesOrderID = b.SalesOrderID
left join Address c on b.ShipToAddressID = c.AddressID
left join Product d on a.ProductID = d.ProductID
left join ProductCategory e on d.ProductCategoryID = e.ProductCategoryID
where City = 'London' 
and e.Name = 'Cranksets'

--11

select a.CompanyName,
max(case when AddressType = 'Main Office' then AddressLine1 else '' end) AS 'Main Office',
max(case when AddressType = 'Shipping' then AddressLine1 else '' end) AS 'Shipping Address'
from SalesLT.Customer a
join SalesLT.CustomerAddress b
on a.CustomerID = b.CustomerID
join [SalesLT].[Address] c
on b.AddressID = c.AddressID
where c.City = 'Dallas'
group by a.CompanyName

--12

select a.SalesOrderID, a.SubTotal,
sum(OrderQty*UnitPrice) AS 'SubTotal',
sum(OrderQty*ListPrice) AS 'SubTotal'
from SalesLT.SalesOrderHeader a
left join SalesLT.SalesOrderDetail b
on a.SalesOrderID = b.SalesOrderID
left join SalesLT.Product c
on b.ProductID = c.ProductID
group by SubTotal, a.SalesOrderID

--13

select top 1 Sum(OrderQty * UnitPrice) AS Value, a.[Name]
from SalesLT.Product a
left join SalesLT.SalesOrderDetail b
on a.ProductID = b.ProductID
group by a.[Name]
order by Value desc

--14
