CREATE TABLE Cliente (
    num_cliente INT PRIMARY KEY,
    Curp CHAR(18),
    Nombre_Cliente VARCHAR(50),
    ap_pat_cliente VARCHAR(50),
    ap_mat_cliente VARCHAR(50),
    fecha_nacimiento VARCHAR(10),
    Rfc_telefono INT
);

CREATE TABLE compra (
    Num_producto INT,
    Num_Cliente INT,
    PRIMARY KEY (Num_producto, Num_Cliente),
    FOREIGN KEY (Num_producto) REFERENCES producto(Num_producto),
    FOREIGN KEY (Num_Cliente) REFERENCES Cliente(num_cliente)
);

CREATE TABLE producto (
    Num_producto INT PRIMARY KEY,
    precio INT,
    tamalo VARCHAR(50),
    id_nombre INT,
    codigo INT
);

CREATE TABLE Venta (
    Num_producto INT,
    Num_vendedor INT,
    PRIMARY KEY (Num_producto, Num_vendedor),
    FOREIGN KEY (Num_producto) REFERENCES producto(Num_producto),
    FOREIGN KEY (Num_vendedor) REFERENCES vendedor(Num_vendedor)
);

CREATE TABLE vendedor (
    Num_vendedor INT PRIMARY KEY,
    Nombre_vendedor VARCHAR(50),
    Apellido_pat VARCHAR(50),
    Apellido_mat VARCHAR(50),
    RFC VARCHAR(13),
    Rfc_telefono INT
);

CREATE TABLE Suministra (
    Num_producto INT,
    Num_provedor INT,
    PRIMARY KEY (Num_producto, Num_provedor),
    FOREIGN KEY (Num_producto) REFERENCES producto(Num_producto),
    FOREIGN KEY (Num_provedor) REFERENCES Proveedor(Num_provedor)
);

CREATE TABLE Proveedor (
    Nombre_provedor VARCHAR(50),
    Apellido_paterno VARCHAR(50),
    Apellido_materno VARCHAR(50),
    Num_provedor INT PRIMARY KEY,
    NIF VARCHAR(50),
    Curp CHAR(18),
    Rfc_telefono INT
);

CREATE TABLE telefono (
    id_telefono INT PRIMARY KEY,
    Numero_Telefono VARCHAR(15)
);



INSERT INTO Cliente VALUES
(1, 'CURP001234567890', 'Juan', 'Perez', 'Gomez', '1980-01-01', 1),
(2, 'CURP002345678901', 'Maria', 'Garcia', 'Lopez', '1990-02-02', 2),
(3, 'CURP003456789012', 'Luis', 'Rodriguez', 'Martinez', '1985-03-03', 3),
(4, 'CURP004567890123', 'Ana', 'Hernandez', 'Gonzalez', '1995-04-04', 4),
(5, 'CURP005678901234', 'Carlos', 'Martinez', 'Sanchez', '1982-05-05', 5);


INSERT INTO producto VALUES
(1, 100, 'pequeño', 1, 1001),
(2, 200, 'mediano', 2, 1002),
(3, 300, 'grande', 3, 1003),
(4, 400, 'extra-grande', 4, 1004),



INSERT INTO compra VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO vendedor VALUES
(1, 'Pedro', 'Sanchez', 'Lopez', 'RFC123456789', 1),
(2, 'Lucia', 'Ramirez', 'Martinez', 'RFC234567890', 2),
(3, 'Jose', 'Fernandez', 'Gonzalez', 'RFC345678901', 3),
(4, 'Elena', 'Torres', 'Perez', 'RFC456789012', 4),
(5, 'Miguel', 'Ortiz', 'Hernandez', 'RFC567890123', 5);


INSERT INTO Venta VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO Proveedor VALUES
('Pablo', 'hernandez', 'lopez', 1, 'NIFA001', 'P0HE3L934NP27N763', 1),
('Marta', 'martinez', 'martinez', 2, 'NIFB002', 'M0MA3M934NP27N763', 2),
('Rufino', 'Mendosa', 'Lopez', 3, 'NIFC003', 'R0ME3L934NP27N763', 3),
('', 'PaternoD', 'MaternoD', 4, 'NIFD004', 'CURPD004567890123', 4),
('Proveedor E', 'PaternoE', 'MaternoE', 5, 'NIFE005', 'CURPE005678901234', 5);


INSERT INTO Suministra VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO telefono VALUES
(1, '9531234567'),
(2, '5552345678'),
(3, '9533456789'),
(4, '5554567890'),
(5, '9535678901');


/*1. SELECT * FROM Cliente;*/
SELECT * FROM Cliente;

/*2. SELECT * FROM Producto;*/
SELECT * FROM Producto;

/*3. SELECT * FROM Compra JOIN Cliente ON Compra.Num_Cliente = Cliente.num_cliente;*/
SELECT * FROM Compra
JOIN Cliente ON Compra.Num_Cliente = Cliente.num_cliente;

/*4. SELECT * FROM Venta JOIN Vendedor ON Venta.Num_vendedor = Vendedor.Num_vendedor;*/
SELECT * FROM Venta
JOIN Vendedor ON Venta.Num_vendedor = Vendedor.Num_vendedor;

/*5. JOIN entre Compra y Producto;*/
SELECT c.Num_producto, p.precio, p.tamalo
FROM Compra c
JOIN Producto p ON c.Num_producto = p.Num_producto;

/*6. SELECT * FROM Proveedor WHERE Nombre_provedor = 'Pablo';*/
SELECT * FROM Proveedor WHERE Nombre_provedor = 'Pablo';

/*7. Suma total de ventas por vendedor;*/
SELECT v.Nombre_vendedor, COUNT(vt.Num_producto) AS total_ventas
FROM Vendedor v
JOIN Venta vt ON v.Num_vendedor = vt.Num_vendedor
GROUP BY v.Nombre_vendedor;

/*8. Proveedores que suministran más de un producto;*/
SELECT s.Num_provedor, p.Nombre_provedor, COUNT(s.Num_producto) AS total_productos
FROM Suministra s
JOIN Proveedor p ON s.Num_provedor = p.Num_provedor
GROUP BY s.Num_provedor, p.Nombre_provedor
HAVING COUNT(s.Num_producto) > 1;

/*9. Productos con nombre más corto que 6 caracteres;*/
SELECT p.*
FROM Producto p
WHERE LENGTH(p.tamalo) < 6;