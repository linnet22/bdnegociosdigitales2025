# Ejercicio de pedidoscon store procedure 

- Realizar un pedido 
- Validar que el pedido noexista 
- Validar que el cliente, el empleado y producto  exista 
- Validar la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe (Multiplicando el precio del 
 producto por cantidad vendida )
- Actualizar el stock del producto (Restando el stockmenos la cantidad vendida ) 
``` sql
create or alter procedure spu_realizar_pedido
@numPedido int , @cliente int ,
@repre int, @fab char(3),
@producto char(5), @cantidad int
 as
 begin -- Validar que el pedido noexista 
   if exists(select 1 from Pedidos where Num_Pedido = @numPedido)
   begin 
   print('El pedido ya existe ')
   return
   end

		  if not exists(select 1 from Clientes where Num_Cli = @cliente) OR --Validar que el cliente, el empleado y producto  exista 
			 not exists (select 1 from Representantes where Num_Empl = @repre)OR 
			 not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)

	   begin 
	   print('Los DATOS no son validos')
	   return
	   end
			if @cantidad <=0
			BEGIN 
			PRINT 'La cantidad no puede ser 0 o negativo '
			return;
			end 
					declare @stockValido int 
					select Stock from Productos where Id_fab =@fab and Id_producto =@producto
						if @cantidad > @stockValido
						begin 
						print 'No hay suficiente stock'
						return;
						end 
						declare @precio money 
						declare @importe money 
						select @precio=Precio from Productos where Id_fab = @fab and Id_producto = @producto
						set @importe = @cantidad * @precio
						begin try 
						insert into Pedidos 
					values (@numPedido,getDate (), @cliente,@repre,@fab,@producto,@cantidad,@importe)
 update Productos
 set Stock = Stock - @cantidad
 where Id_fab = @fab and Id_producto =@producto;
 end try
 -- se inserto pedido 
 begin catch
 print 'Error al utilizar los datos'
 return;
 end catch
 end;
```  
## Peuebas
``` sql
 exec spu_realizar_pedido 
							@numPedido = 113070,
							@cliente =2117,
							@repre =101, @fab = 'ACI',
							@producto = '4100X', 
							@cantidad =20
```