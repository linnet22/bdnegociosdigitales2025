#Creación de la base de datos tienda1
-- Crea la base de datos tienda1
create database tienda1;
-- utilizar una base de datos
use tienda1;
-- SQL-LDD
-- crear la tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar (20) not null,
constraint pk_categoria
primary key(categoriaid),
constraint unico_nombre
unique(nombre)
);

#Agregar registros a la tabla categoria 
insert into  categoria 
values(1, 'Carnes frias');

insert into  categoria(categoriaid,nombre)
values(2, 'Linea Blanca');

insert into  categoria(nombre,categoriaid)
values( 'Vinos y Licores', 3);

insert into categoria 
values (4, 'Ropa'),
		(5, 'Dulces'),
        (6, 'Lacteos');

insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria', 8),
		('Jugueteria', 9);
insert into categoria
values(10, 'panaderia');

select * from categoria
order by categoriaid asc;