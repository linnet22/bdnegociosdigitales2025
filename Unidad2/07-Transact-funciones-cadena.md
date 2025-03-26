# Transtact-Funciones-cadena
```
SQL
-- Funciones de cadena
-- Las funciones de cadena permite manipular tipos de datos como varchar,nvarchar,char y nchar
-- Funcion Len -> devuelve la longitud de una cadena 
--Declaraci�n de una variable


DEclare @numero int;
set @numero =10;
print @numero
-- Obtener el tama�o de la cadena almacenada en la variable texto

--declare @Texto varchar (50) = 'Hola, Mundo!';

select LEN(@Texto ) AS [Longitud]

select CompanyName, LEN(CompanyName) from Customers 

-- Funcion left 
-- Extrae un numero especifico de caracteres desde
---el inicio de la cadena 
--declare @Texto varchar (50) = 'Hola, Mundo!';
select LEFT(@Texto, 4) as Inicio
-- Rigt 
--Extrae un determinado de caracteres
--del final de la cadena
--eclare @Texto varchar (50) = 'Hola, Mundo!';
select RIGHT(@Texto, 6) as Final

-- Substring -> Esxtrae una parte de la cadena 
-- cuenta desde la posicion indicada hasta el margen que agregas 
--su recorrido o sea el numero de caracteres 
--declare @Texto varchar (50) = 'Hola, Mundo!';
select SUBSTRING(@Texto,7,5) as 'Sub Cadena'

-- replace -> Reemplaza una sub cadena por otra
--REPLACE( string_expresion, string_pattern, String_replacement )

--declare @Texto varchar (50) = 'Hola, Mundo!';
select replace(@Texto, 'Mundo', 'Amigo')

-- CharIndex 
--declare @Texto varchar (50) = 'Hola, Mundo!';
select CHARINDEX('Mundo', @Texto)

-- UPPER cOMBIERTE UNA CADENA EN MAYUSCULAS 
--declare @Texto varchar (50) = 'Hola, Mundo!';
select UPPER(@Texto) as Mayusculas

--declare @Texto varchar (50) = 'Hola, Mundo!';
Select CONCAT(
			LEFT(@Texto,6),
			UPPER(SUBSTRING(@Texto,7,5)),
			RIGHT(@Texto,1)
			) as TextoNuevo
UPDATE Customers
SET CompanyName = UPPER(CompanyName)
where Country in('Mexico', 'Germany')

select * from Customers


--TRIM QUITA ESPACIOS EN BLANCO DE UNA CADENA
--SELECT TRIM( '     test    ') AS Result;
declare @Texto varchar (50) = 'Hola, Mundo!';
SELECT TRIM(@Texto) as Result;

-- CREar un store procedure para seleccionar todos los clientes 
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


------------------------------------
select CompanyName, LEN(CompanyName) as 'Numero de Caracteres',
LEFT(CompanyName, 4) as Inicio,
 RIGHT(CompanyName, 6) as Final
from Customers 

```