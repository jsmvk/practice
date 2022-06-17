# AdventureWorks.sql SQL exercises link - https://sqlzoo.net/wiki/AdventureWorks

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

select SUM(a.OrderQty) as 'Riding Cycles Orders'
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
max(case when AddressType = 'Main Office' then AddressLine1 else '' end) as 'Main Office',
max(case when AddressType = 'Shipping' then AddressLine1 else '' end) as 'Shipping Address'
from SalesLT.Customer a
join SalesLT.CustomerAddress b
on a.CustomerID = b.CustomerID
join [SalesLT].[Address] c
on b.AddressID = c.AddressID
where c.City = 'Dallas'
group by a.CompanyName

--12

select a.SalesOrderID, a.SubTotal,
sum(OrderQty*UnitPrice) as 'SubTotal',
sum(OrderQty*ListPrice) as 'SubTotal'
from SalesLT.SalesOrderHeader a
left join SalesLT.SalesOrderDetail b
on a.SalesOrderID = b.SalesOrderID
left join SalesLT.Product c
on b.ProductID = c.ProductID
group by SubTotal, a.SalesOrderID

--13

select top 1 Sum(OrderQty * UnitPrice) as Value, a.[Name]
from SalesLT.Product a
left join SalesLT.SalesOrderDetail b
on a.ProductID = b.ProductID
group by a.[Name]
order by Value desc

--14

select
z.range as 'range',
count(z.total) as 'Num of Orders',
sum(z.total) as 'Value'
from (
select 
case
when SalesOrderDetail.UnitPrice * SalesOrderDetail.OrderQty between 0 and 99 
then '0 - 99'
when SalesOrderDetail.UnitPrice * SalesOrderDetail.OrderQty between 100 and 999 
then '100 - 999' 
when SalesOrderDetail.UnitPrice * SalesOrderDetail.OrderQty between 1000 and 9999 
then '1000 - 9999' 
when SalesOrderDetail.UnitPrice * SalesOrderDetail.OrderQty >= 10000 
then '>= 10000'
end as 'range',
SalesOrderDetail.UnitPrice * SalesOrderDetail.OrderQty as 'Total'
from SalesLT.SalesOrderDetail) as z
group by range

--15

--city, product category, total_value, top 3 needed

select top 3 e.City, a.[Name], sum(OrderQty * UnitPrice) as 'Total value'
from SalesLT.ProductCategory as a
left join SalesLT.Product as b
on a.ProductCategoryID = b.ProductCategoryID
left join SalesLT.SalesOrderDetail as c
on b.ProductID = c.ProductID
left join SalesLT.SalesOrderHeader as d
on c.SalesOrderID = d.SalesOrderID
left join SalesLT.[Address] as e
on d.ShipToAddressID = e.AddressID
where e.City is not null
group by e.City, a.[name]
order by sum(OrderQty * UnitPrice) desc

--16

select CompanyName, SalesOrderNumber
from SalesLT.SalesOrderHeader a
left join SalesLT.Customer b
on a.CustomerID = b.CustomerID
where CompanyName like 'Good Toys'
or CompanyName like 'Bike World'

--17

select CompanyName, OrderQty, [name] as 'Product Name'
from SalesLT.Product a
left join SalesLT.SalesOrderDetail b
on a.ProductID = b.ProductID
left join SalesLT.SalesOrderHeader c
on b.SalesOrderID = c.SalesOrderID 
left join SalesLT.Customer d
on c.CustomerID = d.CustomerID
where CompanyName = 'Futuristic Bikes'
