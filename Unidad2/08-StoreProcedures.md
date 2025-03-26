# StoreProcedures
```
SQL

-- Crear un store procedure para seleccionar todos los clientes 
-- es un conjunto de instrucciones
go
create or alter procedure spu_mostrar_clientes 
AS
begin

	select * from Customers;
	end;
	go
-- Ejecutar un store transact
exec spu_mostrar_clientes 

-- Crear un sp que muestre un pais
-- parametros de entrada 


create or alter proc spu_customersporpais
--Parametros

@pais nvarchar(15), 
@pais2 nvarchar(15)--Parametro de entrada
as
begin
	select * from Customers
	where Country in (@pais, @pais2);
end;
--fin del store 


-- Ejecuta un sotre 

Declare @p1 nvarchar(15) = 'spain';
Declare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go

-- generar un reporte que permita visualoizar los datos de compra 
-- de un determinado cliente en un rango de fechas mostrando el monto total de compras 
-- por producto mediante un sp

select * from vistaordenescompra

create or alter proc spu_informe_ventas_clientes
--parametros
@nombre nvarchar (40) = 'Berglunds snabbk�p',-- parametro de entrada con valor por default 
@fechaInicial Datetime,
@fechaFinal Datetime
as 
begin 
select [Nombre Producto],[Nombre Clientes], SUM(importe) as [Monto total]
from vistaordenescompra
where [Nombre Clientes] = @nombre
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [Nombre Producto],[Nombre Clientes]
end;
go

select * from Customers
select GETDATE()

--- Ejecucion de un estor con parametros de entrada 

exec spu_informe_ventas_clientes
'Berglunds snabbk�p',
'1996-07-04','1997-01-01'


--Ejecucion de un store procedure con parametros de diferente posici�n 
exec spu_informe_ventas_clientes
@fechaInicial = '1996-07-04',
@fechaFinal = '1997-01-01'
-- Ejecucion de un store procedure con valor por default con 
--un campo que tiene un valor por default 
exec spu_informe_ventas_clientes
@fechaFinal = '1997-01-01',
@nombre = 'Berglunds snabbk�p',
@fechaInicial = '1996-07-04'
go
-- Store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes 
@customerid nchar(5),   -- parametroo de entrada
@totalCustomers int output -- parametro de salida 
as 
begin 
	select @totalCustomers=COUNT(*) from Customers
	where CustomerID = @customerid;
end;
go

declare  @numero int ;
exec spu_obtener_numero_clientes @customerid = 'ANATR',
								@totalCustomers = @numero output;
print @numero;
go
-- CREAR UN STORE PROCEDURE QUE  PERMITA SABER SI UN ALUMNO APROBO O REPROBO

create or alter procedure spu_comparar_calificacion
@calificacion decimal (10,2) -- parametro de entrada 
as 
begin 
		if @calificacion>=0 and @calificacion>=10
		begin 
				if @calificacion>=8 
				print 'La calificacion es aprobatoria'
				else 
				print 'La calificacion es reprobatoria'
		end 
		else 
		print 'Calificacion no valida '
end ;
go 
exec spu_comparar_calificacion @calificacion =11


-- crear un sp que permita verificar si un cliente existe antes de 
-- devolver su informacio 
go
create or alter proc spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
as 
begin 
		if exists (select 1 from Customers where CustomerID = @numeroCliente )
			select * from Customers where CustomerID = @numeroCliente;
		else 
		print 'El cliente no existe '
end;
go 

EXEC spu_obtener_cliente_siexiste @numeroCliente = 'AROUT'
EXEC spu_obtener_cliente_siexiste @numeroCliente = 'victor'

select * from Customers
select 1 from Customers where CustomerID = 'AROUT'

-- crear un store procedure que permita insertar un cliente pero
-- se deve verificar primero que no exista
go
create or alter procedure spu_agregar_cliente
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @id)
	begin
	print ('El cliente ya existe')
	return 1
	end

	insert into Customers(CustomerID, CompanyName)
	values(@id,@nombre);
	print 'Cliente insertado exitosamente';
	return 0;
end;

exec spu_agregar_cliente 'ALFKI', 'PATITO DE HULE'

go
create or alter procedure spu_agregar_cliente_try_catch
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
	begin try
		insert into Customers(CustomerID, CompanyName)
		values(@id,@nombre);
		print 'Cliente insertado exitosamente';
	end try

	begin catch
	print 'Cliente insertado exitosamente';
	end catch

end;
go

exec spu_agregar_cliente_try_catch 'ALFKI', 'Mu�eca vieja'

-- Manejode ciclos en strores 
-- imprimir el numero de veces que indique el ususario
go
create or alter procedure spu_imprimir 
@numero int 
as
begin

	if @numero <=0
	begin
	print ('El numero no puede ser 0 o negativo ')
	return 
	end
			declare  @i int 
			set @i = 1 
			while (@i <= @numero )
			begin
			print concat( 'Numero' , @i)
			set @i = @i + 1
			end
end;

exec spu_imprimir  @numero = 10

```