--Consultas de agregafo (NOTA solo devuelven un solo registro )
-- sum ,avg, count, count(*), max y min

-- Cuantos clientes tengo 
-- count(*) cuenta los registros 

Select count(*) as 'Numero de clientes' from Customers

-- cuantas regiones hay 
select count(region ) from Customers
where region is null

select count(*) from Customers
where region is null

select region  from Customers
where region is not null 
order by region asc
-- Respuesta correcta 
select Count(distinct region)  from Customers
where region is not null 

select * from Orders
select count(*) from Orders
select count(ShipRegion) from Orders


select * from Products
-- selecciona el precio mas bajo de los productos 

select min(UnitPrice), max(UnitPrice), avg(UnitsInStock), sum(UnitsInStock)
from Products

-- seleccionar cuantos pedidos existen 

select count(*) as [Numero de pedidos] from Orders


-- calcula el total de dinero  vendido

select sum(UnitPrice * Quantity )from [Order Details]

select sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) as [Total] from [Order Details]

-- calcula el total de unidades en stock de todos los productos

select sum(UnitsInStock) as [Total de stock] from Products

-- Seleccionar el total de dinero que se gano en el ultimo trimestre de 1996

-- seleccionar el numero de productos por categoria 
select count(CategoryID), count(*) from Products

select CategoryID, count(*) as [Numero de producto] from Products
group by CategoryID

select  count(*) from Categories as c
inner join Products as p on c.CategoryID = p.CategoryID

select Categories.CategoryName, count(*) as [Numero de productos ]
from Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName

-- calcular el precio promedio de los productos por cada categoria 

select CategoryID, avg(UnitPrice)as [Precio promedio] from Products
group by CategoryID

-- Seleccionar el numero de pedidos realizados por cada empleado por el ultimo trimestre de 1996

select EmployeeID, count(EmployeeID)as [Numero de pedidos ]
from Orders
group by EmployeeID

select EmployeeID,count(*) from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID

-- seleccionar la suma total de unidades vendidas 

select ProductID,sum(Quantity)  from [Order Details]
group by ProductID

select * from [Order Details]
------------------------
select ProductID,sum(Quantity) as [Numero de productos vendidos ]  from [Order Details]
group by ProductID
order by 1 desc

-------------------------------
select OrderID,ProductID,sum(Quantity) as [Numero de productos vendidos ]  from [Order Details]
group by OrderID, ProductID
order by 2 desc

-- Seleccionar el numero de productos por categoria pero solo aquellos que tengan mas de 10 productos 		
-- paso 1 
select * from Products
--select distinct CategoryID from Products
-- paso 2
select CategoryID, UnitsInStock from Products
where CategoryID in (2,4,8)
order by CategoryID
-- paso 3
select CategoryID, sum(UnitsInStock) from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID
-- paso 4
select CategoryID, sum(UnitsInStock) from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*)>10
order by CategoryID

-- listar las ordenes agrupadas por empleado, pero que solo muestre aquellos que hayan 
-- gestionado mas de 10 pedidos 

select EmployeeID, count(OrderID) as [Ordenes ] from Orders
group by EmployeeID
having count(*)>10

select