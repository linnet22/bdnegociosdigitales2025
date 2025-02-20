select pr.Descripcion,pr.Precio,pr.Id_fab,pr.Id_fab,pr.Id_producto,pr.Precio from Pedidos as p 
inner join Productos as pr 
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto

