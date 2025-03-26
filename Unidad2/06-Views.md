```
SQL
-- views 
-- sintaxis
/*create view  nnombtreVista
AS 
select columnasfrom tabla
wherre condicion
*/

--- create or alter view

use Northwind;
go

create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description] ,Picture 
from Categories;
GO

select * from VistaCategoriasTodas
where CategoryName = 'Beverages'

-- crear una vista que permita visualizar los clientes de mexico y blazil
go
 create or alter view VistaClientesLatinos
 as
select * from Customers
where  country  in('Brazil' , 'Mexico')

drop view VistaClientesLatinos

select vcl.country from Orders
as o 
inner join  VistaClientesLatinos as vcl
on vcl.customerID = o.CustomerID

-- crear una vista que contenga los datos de todas las ordenes los productos categorias de productos,empleados y clientes  en la orden 
-- calcular el importe 
go
create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as [Numero Orden],
o.OrderDate as [Fecha de Orden], 
o.RequiredDate as [Fecha de Requisicion],
CONCAT(e.FirstName, ' ', e.LastName) as [Nombre Empleado],
cu.CompanyName as [Nombre Clientes],
p.ProductName as [Nombre Producto],
c.CategoryName as [Nombre Categoria],
od.UnitPrice as [Precio de Venta],
od.Quantity as [Cantidad Vendida],
(od.Quantity * od.UnitPrice ) as [Importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID



select count(distinct[numero orden]) as [Numeor de Ordenes]
from vistaordenescompra

select sum([Cantidad Vendida] * [Precio de Venta]) as [Importe Total]
from vistaordenescompra

select sum(Importe) as [Importe Total]
from vistaordenescompra
where year ([Fecha de Orden]) between '1995' and '1996'
go

go 
create or alter view vista_ordenes_1995_1996
as
select [Nombre Clientes] as 'Nombre Cliente',
sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden])
between '1995' and '1996'  
group by [Nombre Clientes]
having count(*)>2



create schema rh

create table rh.tablarh (
id int primary key,
nombre nvarchar(50)
)

-- vista rorixontal
create or alter view rh.viewcategoriasproductos
as 
select c.CategoryID, CategoryName, p.ProductID, p.ProductName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
go


select * from rh.viewcategoriasproductos

```