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
