-- lenguaje SQL-LMD (insert, update, delete, selectl - CRUD)
-- Consultas simples 
use Northwind;
-- mostrar  todos los clientes, provedores, categoriar, productos, ordenes , detalles de la orden, empleados  con todas las columnas de la empresa
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details]

-- Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock from  Products;

-- Seleccionar o mostrar el numero de empleado, su primer nombre, su cargo, ciudad y pais.

select * from Employees
select EmployeeID, FirstName, Title, City, Country  from  Employees;

-- Alias de columna
-- En base a la consulta anterior visualisar el employeeid como numero empleado,
--first name como primerNombre,
--Title como cargo, City como ciudad, Country como pais

select EmployeeID as [Numero Empleado] , FirstName  as primernombre, Title 'cargo' , City as ciudad, Country as país from Employees;

-- Campos calculados 
-- Seleccionar el importe de cada uno de los productos 
-- vendidos en una orden 

select *,(UnitPrice * Quantity) as importe from [Order Details] ;

-- Selecionar las fechas de orden de año, mes y dia , el cliente 
-- que las ordeno y el empleado que la realizo 

select OrderDate, year(OrderDate)as [Año de la orden], MONTH(OrderDate), day(OrderDate), CustomerID, EmployeeID from Orders
select OrderDate as 'Fecha', 
year (orderdate)as 'Año', 
MONTH(orderdate)as 'Mes', 
day(orderdate) as 'Dia de la orden',
CustomerID, EmployeeID from Orders;
-- Filas Duplicadas (Distinct) Quita datos repetidos
select * from Customers;
-- Mostrar los paises en donde se tienen clientes 
-- Mostrando pais solamente 
Select distinct Country from Customers
order by country

-- Clausula where 
--Operadores relacionales o test de comparacion (<,>,=,<=,>=, != o <>)

select CustomerID, CompanyName, City, country
from Customers 
where CustomerID = 'BOLID';
select * from Customers;
select customerid as Numero , CompanyName as Compañia, ContactName as [Nombre del contacto],
city as ciudad,
country as pais from Customers
where  country = 'germany'

-- Seleccionar todos los clientes que no sean de alemania 

select * from Customers;
select customerid as Numero , CompanyName as Compañia, ContactName as [Nombre del contacto],
city as ciudad,
country as pais from Customers
where  country != 'germany'

select * from Customers;
select customerid as Numero , CompanyName as Compañia, ContactName as [Nombre del contacto],
city as ciudad,
country as pais from Customers
where  country <> 'germany'

-- Seleccionar todos los productos mostrando su nombre de producto , categoria a la que pertenece, unidades de existencis, precio, pero solamente 
-- donde su precio sea mayor a 100 
select ProductName as 'Nombre de producto' , 
CategoryID as 'Categoria',
UnitsInStock 'Existencia', 
UnitPrice as 'Precio', (UnitPrice * UnitsInStock) as [Costo inventario]
from Products
where UnitPrice >100;
--b Seleccionar las ordenes de compra 
--Mostrando la fecha de orden, la fecha de entrega, la fecha de envio, el cliente a quien se vendio en 1996
select * from Orders;
select OrderDate as 'Fecha de orden',
RequiredDate as 'Fecha de entrega',
ShippedDate as 'Fecha de envio ', 
CustomerID as 'Nombre'
from Orders
where year(OrderDate) = '1996'

-- Mostrar todas las ordenes de compra donde la cantidad de productos comprados 
-- sea mayor a 40
select Quantity from [Order Details]
where Quantity >= 40

-- Mostrar el nombre completo del empleado, su numero de empleado, su fecha de nacimiento
-- ciudad, fecha de contratación debe ser de aquellos que fueron contratados despues de 1993
-- los resultados en sus encabezados deben ser mostrados en español

select EmployeeID as 'Numero', 
FirstName as 'Primer Nombre', 
LastName as 'Apellido', BirthDate as 'Fecha Nacimiento', 
city as 'Ciudad', HireDate as 'Fecha de Contratación'  
from Employees
where year(HireDate) > 1993


select EmployeeID as 'Numero', 
(FirstName + '  ' + LastName) as 'Nombre Completo' , BirthDate as 'Fecha Nacimiento', 
city as 'Ciudad', HireDate as 'Fecha de Contratación'  
from Employees
where year(HireDate) > 1993


select EmployeeID as 'Numero', 
Concat(FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo]
,BirthDate as 'Fecha Nacimiento', 
city as 'Ciudad', HireDate as 'Fecha de Contratación'  
from Employees
where year(HireDate) > 1993

-- Mostrar los empleados que no son dirigidos por el jefe Fuller Andrew

select EmployeeID as 'Numero', 
Concat(FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo]
,BirthDate as 'Fecha Nacimiento', 
city as 'Ciudad', HireDate as 'Fecha de Contratación', ReportsTo as 'Jefe' 
from Employees
where ReportsTo != 2

-- Seleccionar los empleados que no tengan jefe
select * from Employees
where ReportsTo is null

-- Operadore logicos (or, and y not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50 

select ProductName as 'Nombre', UnitPrice 'Precio', UnitsInStock as 'Existencias' from Products
where UnitPrice  >= 10
and UnitPrice<=50;

-- Mostrar todos los pedidos realizados por clientes que no son enviados  a alemania 

select * from Orders
where ShipCountry <> 'Germani'

select * from Orders
where NOT ShipCountry = 'Germany'

-- Seleccionar clientes de Mexico o USA 

select City as 'ciudad' from Customers
where Country = 'Mexico' or Country = 'USA'

-- Seleccionar Empleados que nacieron entre 1955 y 1958 y que viven

select * from Employees
where year(BirthDate)>=1955 and year(BirthDate)<=1958
and City = 'London'

-- sELECCIONAR LOS PEDIDOS CON FLETE DE PESO (freight) mayor a 100 
-- y enviados a Francia o España

select OrderID, OrderDate, ShipCountry, Freight from Orders

where Freight>100 and (ShipCountry='France' or  ShipCountry='Spain')

-- Seleccionar las top cinco ordenes de compra 

select top 5 * from Orders 

-- Seleccionar Productos conprecio entre 10 y 50 
-- que no esten descontinuados y tengan mas de 20 unidades en stock

select  ProductName, UnitPrice, UnitsInStock, Discontinued from Products

where (UnitPrice >=10 and UnitPrice <=50)  and Discontinued =0 
and UnitsInStock >20

-- pedidos enviados a francia o alemania 
--pero con un flete menor a 50

select OrderID, ShipCountry, Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight<50

-- Clientes  que no  sean de mexico o usa y que tengan fax registrado 

select CompanyName, Country, City,Fax from Customers
where not(Country='Mexico' or Country='USA') and Fax is NOT NULL

--V sELECCIONAR PEDIDOS CON UN FLETE MAYOR A 100
-- enviados a Brasil o Argentina 
-- pero no enviados pero no por el transportista 

select * from Shippers

-- Seleccionar empleados que no viven en londres o seattle 
-- y que fueron contratados despues de 1992

select concat(FirstName, '', LastName) as nombrempleado, HireDate,city, Country  from Employees
where City <> 'London' and city <> 'London' and City <> 'Sattle'
and year(HireDate) >=1992

--Clausula IN (or)
--Seleccionar los productos con categoria 1,3 y 5 

select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 

select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1,3,5);

-- Seleccionar todas las ordenes de una region RJ, Tachira y que no tengan 
-- region asignada 

select OrderID, OrderDate,ShipRegion from Orders
where ShipRegion in ('RJ', 'Táchira')
or ShipRegion is null 
-- Seleccionar las ordenes que tengan cantidades de 12, 9 y 40 
-- y descuento de 0.15 y 0.05

select OrderID, Discount,Quantity from [Order Details]
where Quantity in (12,9,40) and  Discount in (0.15,0.05)


--Clausula Between

