# Consultas Simples
```
SQL
--CONSULTAS SIMPLES

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

select EmployeeID as [Numero Empleado] , FirstName  as primernombre, Title 'cargo' , City as ciudad, Country as pa�s from Employees;

-- Campos calculados 
-- Seleccionar el importe de cada uno de los productos 
-- vendidos en una orden 

select *,(UnitPrice * Quantity) as importe from [Order Details] ;

-- Selecionar las fechas de orden de a�o, mes y dia , el cliente 
-- que las ordeno y el empleado que la realizo 

select OrderDate, year(OrderDate)as [A�o de la orden], MONTH(OrderDate), day(OrderDate), CustomerID, EmployeeID from Orders
select OrderDate as 'Fecha', 
year (orderdate)as 'A�o', 
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
select customerid as Numero , CompanyName as Compa�ia, ContactName as [Nombre del contacto],
city as ciudad,
country as pais from Customers
where  country = 'germany'

-- Seleccionar todos los clientes que no sean de alemania 

select * from Customers;
select customerid as Numero , CompanyName as Compa�ia, ContactName as [Nombre del contacto],
city as ciudad,
country as pais from Customers
where  country != 'germany'

select * from Customers;
select customerid as Numero , CompanyName as Compa�ia, ContactName as [Nombre del contacto],
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
-- ciudad, fecha de contrataci�n debe ser de aquellos que fueron contratados despues de 1993
-- los resultados en sus encabezados deben ser mostrados en espa�ol
select EmployeeID as 'Numero',
(FirstName, + 'Nombre',  + LastName )  
BirthDate as 'Fecha de nacimiento', City as 'Ciudad', HireDate as 'FechaContrato'
from Employees
where year(HireDate) >1993

select EmployeeID as 'Numero',
concat(FirstName,  ' ', LastName, '-', Title ) as [NombreCompleto]  
BirthDate as 'Fecha de nacimiento', City as 'Ciudad', HireDate as 'FechaContrato'
from Employees
where year(HireDate) >1993
-- Mostrar los empleados que no son dirigidos por el jefe 2
select EmployeeID from Employees
--Seleccionar los empleados que no tengan 

```