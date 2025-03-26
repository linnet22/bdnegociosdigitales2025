
```
SQL
-- Tareas de consultas simples 

use Northwind

--1.    Productos con categor�a 1, 3 o 5
select CategoryID from Products
where CategoryID in (1, 3, 5)

--2.    Clientes de M�xico, Brasil o Argentina
select * from Customers
where Country in ('Mexico', 'Brazil', 'Argentina');


--3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
select * from Orders 
where ShipVia in (1, 2, 3) 
and Freight > 50;


--4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
select * from Employees 
where City in ('London', 'Seattle', 'Buenos Aires');


--5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
select * from Orders
where ShipCountry in ('France', 'Germany') and Freight <100

--6.    Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados
select * from Products 
where CategoryID in (2, 4, 6) 
and Discontinued = 0;


--7.    Clientes que NO son de Alemania, Reino Unido ni Canad�
select * from Customers 
where Country NOT IN ('Germany', 'UK', 'Canada');


--8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad�
select * from Orders 
where ShipVia in (2, 3) 
and ShipCountry not in ('USA', 'Canada');



--9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995
select concat(FirstName, '', LastName)as [Nombre Completo],
HireDate, City, Country
from Employees
where City in ('London','Sattle')
and year(HireDate) >=1995

--10.    Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados
select * from Products 
where CategoryID in (1, 3, 5) 
and UnitsInStock > 50 and Discontinued = 0;
```
-- Tareas de consultas simples 

use Northwind

--1.    Productos con categor�a 1, 3 o 5
select CategoryID from Products
where CategoryID in (1, 3, 5)

--2.    Clientes de M�xico, Brasil o Argentina
select * from Customers
where Country in ('Mexico', 'Brazil', 'Argentina');


--3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
select * from Orders 
where ShipVia in (1, 2, 3) 
and Freight > 50;


--4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
select * from Employees 
where City in ('London', 'Seattle', 'Buenos Aires');


--5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
select * from Orders
where ShipCountry in ('France', 'Germany') and Freight <100

--6.    Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados
select * from Products 
where CategoryID in (2, 4, 6) 
and Discontinued = 0;


--7.    Clientes que NO son de Alemania, Reino Unido ni Canad�
select * from Customers 
where Country NOT IN ('Germany', 'UK', 'Canada');


--8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad�
select * from Orders 
where ShipVia in (2, 3) 
and ShipCountry not in ('USA', 'Canada');



--9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995
select concat(FirstName, '', LastName)as [Nombre Completo],
HireDate, City, Country
from Employees
where City in ('London','Sattle')
and year(HireDate) >=1995

--10.    Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados
select * from Products 
where CategoryID in (1, 3, 5) 
and UnitsInStock > 50 and Discontinued = 0;