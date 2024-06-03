CREATE TABLE Cliente (
    num_cliente INT PRIMARY KEY,
    curp CHAR(18) NOT NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    ap_pat_cliente VARCHAR(50) NOT NULL,
    ap_mat_cliente VARCHAR(50),
    fecha_nacimiento DATE,
    id_telefono INT,
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono)
);

CREATE TABLE Producto (
    num_producto INT PRIMARY KEY,
    precio DECIMAL(10, 2) NOT NULL,
    tamano VARCHAR(50),
    id_nombre INT,
    codigo INT
);

CREATE TABLE Compra (
    num_producto INT,
    num_cliente INT,
    PRIMARY KEY (num_producto, num_cliente),
    FOREIGN KEY (num_producto) REFERENCES Producto(num_producto),
    FOREIGN KEY (num_cliente) REFERENCES Cliente(num_cliente)
);

CREATE TABLE Vendedor (
    num_vendedor INT PRIMARY KEY,
    nombre_vendedor VARCHAR(50) NOT NULL,
    apellido_pat VARCHAR(50) NOT NULL,
    apellido_mat VARCHAR(50),
    rfc VARCHAR(13) NOT NULL,
    id_telefono INT,
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono)
);

CREATE TABLE Venta (
    num_producto INT,
    num_vendedor INT,
    PRIMARY KEY (num_producto, num_vendedor),
    FOREIGN KEY (num_producto) REFERENCES Producto(num_producto),
    FOREIGN KEY (num_vendedor) REFERENCES Vendedor(num_vendedor)
);

CREATE TABLE Proveedor (
    num_proveedor INT PRIMARY KEY,
    nombre_proveedor VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    nif VARCHAR(50) NOT NULL,
    curp CHAR(18) NOT NULL,
    id_telefono INT,
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono)
);

CREATE TABLE Suministra (
    num_producto INT,
    num_proveedor INT,
    PRIMARY KEY (num_producto, num_proveedor),
    FOREIGN KEY (num_producto) REFERENCES Producto(num_producto),
    FOREIGN KEY (num_proveedor) REFERENCES Proveedor(num_proveedor)
);

CREATE TABLE Telefono (
    id_telefono INT PRIMARY KEY,
    numero_telefono VARCHAR(15) NOT NULL
);


INSERT INTO Cliente (num_cliente, curp, nombre_cliente, ap_pat_cliente, ap_mat_cliente, fecha_nacimiento, id_telefono) VALUES
(1, 'CURP001234567890', 'Juan', 'Perez', 'Gomez', '1980-01-01', 1),
(2, 'CURP002345678901', 'Maria', 'Garcia', 'Lopez', '1990-02-02', 2),
(3, 'CURP003456789012', 'Luis', 'Rodriguez', 'Martinez', '1985-03-03', 3),
(4, 'CURP004567890123', 'Ana', 'Hernandez', 'Gonzalez', '1995-04-04', 4),
(5, 'CURP005678901234', 'Carlos', 'Martinez', 'Sanchez', '1982-05-05', 5);


INSERT INTO Producto (num_producto, precio, tamano, id_nombre, codigo) VALUES
(1, 100.00, 'pequeño', 1, 1001),
(2, 200.00, 'mediano', 2, 1002),
(3, 300.00, 'grande', 3, 1003),
(4, 400.00, 'extra-grande', 4, 1004);


INSERT INTO Compra (num_producto, num_cliente) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);


INSERT INTO Vendedor (num_vendedor, nombre_vendedor, apellido_pat, apellido_mat, rfc, id_telefono) VALUES
(1, 'Pedro', 'Sanchez', 'Lopez', 'RFC123456789', 1),
(2, 'Lucia', 'Ramirez', 'Martinez', 'RFC234567890', 2),
(3, 'Jose', 'Fernandez', 'Gonzalez', 'RFC345678901', 3),
(4, 'Elena', 'Torres', 'Perez', 'RFC456789012', 4),
(5, 'Miguel', 'Ortiz', 'Hernandez', 'RFC567890123', 5);


INSERT INTO Venta (num_producto, num_vendedor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);


INSERT INTO Proveedor (num_proveedor, nombre_proveedor, apellido_paterno, apellido_materno, nif, curp, id_telefono) VALUES
(1, 'Pablo', 'Hernandez', 'Lopez', 'NIFA001', 'P0HE3L934NP27N763', 1),
(2, 'Marta', 'Martinez', 'Martinez', 'NIFB002', 'M0MA3M934NP27N763', 2),
(3, 'Rufino', 'Mendosa', 'Lopez', 'NIFC003', 'R0ME3L934NP27N763', 3),
(4, '', 'PaternoD', 'MaternoD', 'NIFD004', 'CURPD004567890123', 4),
(5, 'Proveedor E', 'PaternoE', 'MaternoE', 'NIFE005', 'CURPE005678901234', 5);


INSERT INTO Suministra (num_producto, num_proveedor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO Telefono (id_telefono, numero_telefono) VALUES
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