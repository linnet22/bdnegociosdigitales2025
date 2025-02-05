--Consultas de agregafo (NOTA solo devuelven un solo registro )
-- sum ,avg, count, count(*), max y min

-- Cuantos clientes tengo 
-- count(*) cuenta los registros 

Select count(*) as 'Numero de clientes' from Customers

-- cuantas regiones hay 
select count(region ) from Customers
where region is null

select count(*) from Customers
where region is null

select region  from Customers
where region is not null 
order by region asc
-- Respuesta correcta 
select Count(distinct region)  from Customers
where region is not null 
