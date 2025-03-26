```
SQL
-- Consultas avanzadas

-- Seleccionar  todas las categorias y productos 
use Northwind

select * from 
Categories
inner join
Products
on categories.CategoryID = products.CategoryID;

select categories.CategoryID, CategoryName,ProductName,UnitsInStock,UnitPrice from 
Categories
inner join
Products
on categories.CategoryID = products.CategoryID;

select c.CategoryID as [Numero de categoria ], 
CategoryName as [Nombre de la categoria ],ProductName as [Nombre del producto],UnitsInStock as [Existencia],UnitPrice as precio from 
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;

-- seleccionar los productos de la categoria y condiments donde 
-- la existencia este entre 18 y 30

select * from Categories as ca  join Products as p
on p.CategoryID = ca.CategoryID
where (ca.CategoryName = 'Beverages'or ca.CategoryName = 'Condiments')

and (p.UnitsInStock>=18 and p.UnitsInStock<=30)

select * from Categories as ca  join Products as p
on p.CategoryID = ca.CategoryID
where ca.CategoryName in ('Beverages', 'Condiments')
and (p.UnitsInStock>=18 and p.UnitsInStock<=30)

-- seleccionar los productos y sus importes  realizados de marzo a junio de 
-- 1996 , mostrando la fecha de la orden el id del producto y el importe 

 select o.OrderID , o.OrderDate, od.ProductID,
 (od.UnitPrice * od.Quantity) as importe 
 from Orders as o join [Order Details] as od
 on od.OrderID = o.OrderID
 where o.OrderDate between '1996-07-01' and '1996-10-31'

 -- Mostrar el importe total de ventas de la consulta anterios
 select concat('$','',sum(od.Quantity * od.UnitPrice))
  from Orders as o join [Order Details] as od
 on od.OrderID = o.OrderID
 where o.OrderDate between '1996-07-01' and '1996-10-31'
-- Consultas basicas con inner join 
-- 1 Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos 

select c.CompanyName as 'Nombre del cliente ', o.ShipCountry as 'Pais de envio '
from orders as o inner join Customers as c
on c.CustomerID = o.CustomerID
order by 2 desc

---
select c.CompanyName, o.ShipCountry
from orders as o inner join Customers as c
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc

--2 obtener los productos  y sus respectivos provedores 
select p.ProductName as 'Nombre producto', s.CompanyName 'Nombre Provedor'
from Products as p inner join 
Suppliers as s
on p.SupplierID = s.SupplierID

-- obtener los pedidos y los empleados que los registraron 
select o.OrderID, concat(e.Title, '-' ,e.FirstName, ' ') as 'Nombre ' 
from Orders as o inner join Employees as e
on o.EmployeeID = e.EmployeeID

-- 4 Listar los productos junto con sus precios y la categoria a la que pertenecen 
select p.ProductName as 'nombre del producto', p.UnitPrice as 'Precio', c.CategoryID as 'Categoria '  
from Categories as c inner join Products as p
on c.CategoryID = p.CategoryID

-- 5 Obtener el nombre del cliente , el numero de orden y la fecha de orden 
select c.ContactName as 'Nombre del cliente ', o.OrderID as 'numero de orden ' , o.OrderDate as 'Fecha de la orden' 
from Customers as c inner join Orders as o
on c.CustomerID = o.CustomerID

--6. listar las ordenes mos trando el numero de orden , el nombre del producto 
-- y la cantidad que se vendio 
select  od.OrderID as 'numero de orden ' , p.ProductName as 'Nombre del producto ', od.Quantity as 'Cantidad vendida ' from [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc
---------------
select top 5 od.OrderID as 'numero de orden ' , p.ProductName as 'Nombre del producto ', od.Quantity as 'Cantidad vendida ' from [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc
-----------------
select  od.OrderID as 'numero de orden ' , p.ProductName as 'Nombre del producto ', od.Quantity as 'Cantidad vendida ' from [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
where od.OrderID = '11031'
order by od.Quantity desc
------------------
select  od.OrderID as 'numero de orden ', count(*) as 'Cantidad de productos vendidos '  from [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
group by od.OrderID
order by od.OrderID desc
--------------------------
 select * from [Order Details] as od 
 where od.OrderID = 11077

-- 7 obtener los empleados y los respectivos jefes  consulta especial
select concat(e1.FirstName,' ',e1.LastName)as Empleado,
concat(j1.FirstName,'',j1.LastName) as Jefe from Employees as e1 inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID
-- 8 Listar los pedidos y el nombre de la empresa de transporte utilizada 
select o.OrderID as 'Numero de orden ', s,CompanyName as 'Nombre de empresa' from Orders as o inner join Shippers as s
on s.ShipperID = o.ShipVia
--- consultas inner join intermedias 
--9 obtener la cantidad total de productos vendidos por categoria 
select sum(Quantity) from [Order Details]

select c.CategoryName as 'Nombre categoria' ,
sum(Quantity) as 'Productos vendidos ' from Categories as c  
inner join Products as p
on  c.CategoryID =p.CategoryID
INNER JOIN [Order Details] as od 
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

--10 obtener el total de ventas por empleado 
select sum(Quantity) from [Order Details] 

select sum(Quantity) as 'Productos vendidos' from Orders as o 
inner join Employees as e 
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od 

on od.OrderID = o.OrderID
group by e.EmployeeID
order by e.EmployeeID
-------------------------
select concat(e.FirstName, '', e.LastName ) as nombre ,
sum((od.Quantity * od.UnitPrice)-
(od.Quantity * od.UnitPrice) * od.Discount)
as Total 
from Orders as o
inner join Employees as e 
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName
-- 11 listar los clientes y la cantidad de pedidos que han realizado 
SELECT C.CustomerID, C.CompanyName, COUNT(O.OrderID) AS TotalPedidos
FROM Customers as C
INNER JOIN Orders as O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalPedidos DESC;

--12 Obtener los empleados que han gestionado pedidos enviados a alemania 
select distinct concat(e.FirstName,'', e.LastName) as [Nombre] from Employees as e 
inner join Orders as o 
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'


-- 13 Listar los productos junto con el nombre del provedor y el pais  de origen 
select p.ProductName as Producto, 
s.CompanyName as Proveedor, 
s.Country as [Pais Origen]
from Products as p
join Suppliers as s 
on p.SupplierID = s.SupplierID;

-- 14 obtener los pedidos agrupados por pais de envio 
select ShipCountry AS [PAIS DE ENVIO], COUNT(o.OrderID) as [numero de pedidos] from Orders as o
group by  ShipCountry

-- 15 obtener los empleados y la cantidad de territorio en los que tranajan 
select distinct CONCAT(e.FirstName,'',e.LastName)  as territorio, COUNT(et.TerritoryID)  from Employees as e 
inner join EmployeeTerritories as et
on e.EmployeeID= et.EmployeeID
group by e.FirstName,e.LastName

select distinct CONCAT(e.FirstName,'',e.LastName)  as territorio, COUNT(et.TerritoryID), t.TerritoryDescription  from Employees as e 
inner join EmployeeTerritories as et
on e.EmployeeID= et.EmployeeID
inner join Territories as t 
on et.TerritoryID = t.TerritoryID
group by e.FirstName,e.LastName,et.TerritoryID,t.TerritoryDescription
order by territorio , t.TerritoryDescription desc

-- 16 listar las categorias y la cantidad de productos que tienen 
select c.CategoryName as categoria , COUNT(p.ProductID) as [cantidad de productos]  from Categories as c 
inner join Products as p 
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc
--17 obtener la cantidad total de productos vendidos por proveedor 
select s.CompanyName as provedor, SUM(od.Quantity)  as [Total de productos vendidos]from Products as p inner join Suppliers as s
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by s.CompanyName

-- 18 obtener la cantidad de pedidos enviados por cada empresa de transporte 

select  s.CompanyName as [Transportista],COUNT(*) as [Total de pedicos] from Orders as o
 inner join Shippers as s
 on o.ShipVia = s.ShipperID
group by s.CompanyName



---Consultas avanzadas 
-- 19 obtener los clientes que han realizado pedidos con mas de un producto

select c.CompanyName, COUNT(distinct ProductID) as [Numero de productos]  from  Customers as c
inner join  Orders as o
on c.CustomerID = o.CustomerID 
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc
------------------------
select distinct ProductID as [Numero de productos]  from  Customers as c
inner join  Orders as o
on c.CustomerID = o.CustomerID 
inner join [Order Details] as od
on od.OrderID = o.OrderID
order by 1 desc

--20.Listar los empleados con la cantidad total de pedidos que han gestionado y a que  clientes
--les han vendido agrupandolos por nombre completo y dentro de este nombre por cliente ordenandolos 
--por la cantidad mayor de pedidos 
select CONCAT(e.FirstName,'',e.LastName) [Nombre]
,COUNT(OrderID) as [numero de ordenes]  from  Employees as e
inner join Orders as o 
on e.EmployeeID = o.EmployeeID
group by e.FirstName,e.LastName
order by [Nombre] asc

select CONCAT(e.FirstName,'',e.LastName) [Nombre]
,c.CompanyName as [Cliente] 
,COUNT(OrderID) as [numero de ordenes]  from  Employees as e
inner join Orders as o 
on e.EmployeeID = o.EmployeeID
inner join  Customers as c
on c.CustomerID = o.CustomerID
group by e.FirstName,e.LastName, c.CompanyName
order by [Nombre] asc,[Cliente]
-- 21. Listar las categorias con el total de ingresos mostrando generados por sus productos 
select c.CategoryID ,sum (od.Quantity*od.UnitPrice) as [total]  from Categories as c 
inner join Products as p 
on c.CategoryID = p.CategoryID
inner join [Order Details] as od 
on p.ProductID = od.ProductID
group by  c.CategoryID
order by [total]
-- 22 listar los clientes con el total que ha gastado en pedidos 
select c.CustomerID,SUM(od.Quantity * od.UnitPrice - Discount) as [total] from Customers as c 
inner join Orders as o 
on c.CustomerID = o .CustomerID
inner join [Order Details] as od 
on o.OrderID = od.OrderID
group by c.CustomerID
order by c.CustomerID
--23  listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total de dinero 
select o.OrderID,o.OrderDate,SUM(od.Quantity *  od.UnitPrice) from Orders as o 
inner join [Order Details] as od 
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate,o.OrderID

-- 24 listar los productos con las categorias beverages, Seafood, Confections
select c.CategoryID,p.ProductName, c.CategoryName from Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID
where (c.CategoryName= 'Beverages' or c.CategoryName='Seafood' or c.CategoryName='Confections')
group by c.CategoryID,p.ProductName,c.CategoryName
-- 25  listar los clientes ubicados en alemania y que hayan realizado pedidos antes  del 1 de enero de 1997
select c.CustomerID,c.Country, o.OrderDate from  Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
where c.Country = 'Germany' and o.OrderDate<'1997-01-01'

-- 26  Listar los clientes que han realizado pedidos con un total entre 500 y 2000
select c.CompanyName, SUM(od.Quantity * od.UnitPrice) as total from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.CompanyName
having  SUM(od.Quantity * od.UnitPrice) between 500 and 2000

-- Left JOin, Right Join, Full Join, Cross Join 
-- Seleccionar los datos  que se van a utilizar para insertar en tabla products_new
--product_id, productName, customer, category, UnitePrice, discontinued, inserted_date

```