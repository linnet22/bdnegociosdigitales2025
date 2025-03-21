--MOSTRAR NOMBRE DEL CLIENTE IDENTIFICADOR Y NOMBRE COMPLLETO DEL EMPLEADO , FECHA DE LA ORDEN ENVIO Y FRAME 

--NOBRE DE CLIENTE,PRECIO UNITARIO Y IMPORTE 
use Northwind;
go
create view vista_pedidos_clientes
as
select o.orderId,c.CompanyName as cliente , (e.firstname + ''+ e.LastName) as [Nombre de empleado], o.orderDate
   from orders as o  
inner join customers as c 
on o.customerid = c.customerid
inner join Employees e 
on e.EmployeeID = o.EmployeeID

--2
go
create view vista_detalle_pedidos
as 
select od.OrderID,p.ProductName,od.Quantity,od.UnitPrice,c.CategoryName, (od.Quantity* od.UnitPrice) as [importe] from [Order Details] as od  
inner join Products as p 
on od.ProductID =p.ProductID
inner join Categories as c 
on c.CategoryID = p.CategoryID
-------------------3
go 


CREATE PROCEDURE sp_registrarnuevopedido
    @CustomerID NVARCHAR(5),
    @EmployeeID INT,
    @OrderDate DATETIME,
    @RequiredDate DATETIME,
    @ShipVia INT,
    @Freight MONEY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Verificar si el cliente existe
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
        BEGIN
            RAISERROR ('-1 Cliente no existe', 16, 1);
            RETURN -1;
        END

        -- Verificar si el empleado existe
        IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
        BEGIN
            RAISERROR ('-2 Empleado no existe', 16, 1);
            RETURN -2;
        END

        -- Validar que la fecha requerida sea posterior a la fecha del pedido
        IF @RequiredDate <= @OrderDate
        BEGIN
            RAISERROR ('-3 Fecha requerida no es válida', 16, 1);
            RETURN -3;
        END

        -- Insertar el nuevo pedido
        INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipVia, Freight)
        VALUES (@CustomerID, @EmployeeID, @OrderDate, @RequiredDate, @ShipVia, @Freight);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RAISERROR ('-4 Error inesperado', 16, 1);
        RETURN -4;
    END CATCH
END;

 --------
 go 

 CREATE VIEW OrderedProductsDetails AS
SELECT 
    P.ProductName AS Product_Name,
    P.UnitPrice AS Product_Price,
    OD.Quantity AS Quantity_Sold,
    (OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Sale_Price,
    O.OrderDate AS Order_Date,
    C.CompanyName AS Customer_Name,
    C.Country AS Customer_Country
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID;

SELECT * FROM OrderedProductsDetails 
WHERE Order_Date BETWEEN '1997-01-01' AND '1997-12-31';
