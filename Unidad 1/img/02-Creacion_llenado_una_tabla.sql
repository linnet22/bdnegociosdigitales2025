#Creación de la base de datos tienda1
# Crea la base de datos tienda1
create database tienda1;
# utilizar una base de datos
use tienda1;
#SQL-LDD
#crear la tabla categoria
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
#Tabla productos
 create table producto1(
 productoid int not null,
 nombreProducto varchar(20) not null,
 descripcion varchar(80) null,
 precio decimal(10,2) not null,
 existencia int not null,
 categoriaid int null,
 constraint pk_producto1
 primary key (productoid),
 constraint unico_descripcion 
 unique (nombreProducto ),
 constraint chk_precio
 check (precio>0.0 and precio<=100),
 constraint chk_existencia
 check (existencia>0 and existencia<=200),
 constraint fk_categoria_producto1
 foreign key (categoriaid)
 references categoria (categoriaid) 
 );
 
 insert into producto1
 values(1, 'Miguelito', 'Dulce sano para la lombriz', 34.45, 45, 5);
 insert into producto1
 values(2, 'Tupsi pop', 'Dulce re-sano para la lombriz', 1000, 200, 5);
 insert into producto1
 values(3, 'Plancha', 'Plancha facil el suit', 256.3, 134, 2);
 select * from producto1
 where categoriaid=5
 select * from categoria 
 
 