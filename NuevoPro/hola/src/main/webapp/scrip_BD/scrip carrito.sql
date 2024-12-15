---------------------------------------
-- Base de datos : tienda2024
-- Autor : Jose Garcia La Riva
---------------------------------------
CREATE DATABASE IF NOT EXISTS tienda2024;
USE tienda2024;

-- Tabla : Categorias
DROP TABLE IF EXISTS Categorias;
CREATE TABLE Categorias(
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY (IdCategoria),
    CHECK(Estado IN ('0','1'))
);


-- Insertar filas en la tabla Categorias
INSERT INTO Categorias VALUES('CAT001','Helados','helado-categoria.jpg','1');
INSERT INTO Categorias VALUES('CAT002','Bebidas','bebidas-categoria.jpg','1');
INSERT INTO Categorias VALUES('CAT003','Comidas','comida-categorias.jpg','1');



SELECT *from Categorias;
USE tienda2024;

-- Tabla : Carrunsel
DROP TABLE IF EXISTS Carrunsel;
create table Carrunsel(
 IdCarrunsel CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    CHECK(Estado IN ('0','1'))
);
-- Insertar filas en la tabla Carrunsel
INSERT INTO Carrunsel VALUES('CAR001','PANES','producto-carrusel2.jpg','1');
INSERT INTO Carrunsel VALUES('CAR002','Post','producto-carrusel2.jpg','1');


-- Tabla : Productos
DROP TABLE IF EXISTS Productos;
CREATE TABLE Productos(
    IdProducto CHAR(8) NOT NULL,
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Stock INT NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdProducto),
    FOREIGN KEY(IdCategoria) REFERENCES Categorias(IdCategoria),
    CHECK(PrecioUnidad > 0),
    CHECK(Stock > 0),
    CHECK(Estado IN ('0','1'))
);


-- Insertar filas en la tabla Productos
INSERT INTO Productos VALUES('PRO00001','CAT001','helado-sinParar',
50,10,'helado-sinParar.jpeg','1');
INSERT INTO Productos VALUES('PRO00002','CAT001','helado-sadwich vainilla',
70,10,'helado-sadwich.jpg','1');
INSERT INTO Productos VALUES('PRO00003','CAT001','helado-kitKat',
50,10,'helado-kitKat.jpg','1');
INSERT INTO Productos VALUES('PRO00004','CAT001','helado-frioRico',
60,10,'helado-frioRico.jpg','1');
INSERT INTO Productos VALUES('PRO00005','CAT001','helado-chocolate-Gelatico',
60,10,'helado-chocolate-Gelatico.jpg','1');
INSERT INTO Productos VALUES('PRO00006','CAT001','helado-bombom',
60,10,'helado-bombom.jpg','1');
INSERT INTO Productos VALUES('PRO00007','CAT001','helado-sublime ',
60,10,'helado-sublime.jpg','1');






INSERT INTO Productos VALUES('PRO00013','CAT002','bebida-Suerox',
15,10,'bebida-Suerox.jpg','1');
INSERT INTO Productos VALUES('PRO00014','CAT002','bebida-SporadeUva',
12,10,'bebida-SporadeUva.jpg','1');
INSERT INTO Productos VALUES('PRO00015','CAT002','bebida-guarana',
15,10,'bebida-guarana.jpg','1');
INSERT INTO Productos VALUES('PRO00016','CAT002','bebida-Energizante-redBull',
15,10,'bebida-Energizante-redBull.jpg','1');
INSERT INTO Productos VALUES('PRO00017','CAT002','bebida-BioPet',
15,10,'bebida-BioPet.jpg','1');
INSERT INTO Productos VALUES('PRO00018','CAT002','bebida-aguaSanLuis',
15,10,'bebida-aguaSanLuis.jpg','1');
INSERT INTO Productos VALUES('PRO00019','CAT002','bebida-aguaMineral-pack2',
15,10,'bebida-aguaMineral-pack2.jpg','1');




INSERT INTO Productos VALUES('PRO00025','CAT003',' TripleJamon',
10,10,'comida-TripleJamon.jpg','1');
INSERT INTO Productos VALUES('PRO00026','CAT003',' panChoriburguer',
8,10,'comida-panChoriburguer.jpg','1');
INSERT INTO Productos VALUES('PRO00027','CAT003',' pack tortaHelada',
13,10,'comida-pack-TortaHelada.jpg','1');
INSERT INTO Productos VALUES('PRO00028','CAT003',' pack Hamburguesa CocaCola',
13,10,'comida-pack-Hamburguesa-CocaCola.jpg','1');
INSERT INTO Productos VALUES('PRO00029','CAT003',' Enrollado de Pollo',
13,10,'comida-EnrolladoPollo.jpg','1');
INSERT INTO Productos VALUES('PRO00030','CAT003',' Cheesecake de maracuya',
13,10,'comida-Cheesecake.jpg','1');
INSERT INTO Productos VALUES('PRO00031','CAT003','Alfajor',
13,10,'comida-Alfajor.jpg','1');









use tienda2024;
-- Tabla : Clientes
DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes(
    IdCliente CHAR(8) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    Nombres VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Tipo CHAR(1) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdCliente),
    CHECK(Sexo IN ('M','F')),
    CHECK(Estado IN ('0','1')),
    CHECK(Tipo IN ('A','U'))
);

INSERT INTO Clientes VALUES('ADM00001','Admin','Tino',
'AV.BRASIL 123-BREÑA','2005-03-05','M','tino@gmail.com','A','1234','1');
INSERT INTO Clientes VALUES('CLI00001','Casas Estrella','Salvador andre',
'AV.LIMA 1234-Santa-Anita','2003-05-01','M','Salvador@gmail.com','U','1234','1');
INSERT INTO Clientes VALUES('CLI00002','TORRES Esmeralda','CLAUDIA',
'AV.PRIMAVERA 1234-SURCO','1991-07-11','F','torres@gmail.com','U','1234','1');
INSERT INTO Clientes VALUES('CLI00003','VILLAR RAMOS','David ISMAEL',
'AV.ARENALES 1525-LINCE','1989-12-01','M','villar@gmail.com','U','1234','1');

SELECT * FROM Clientes;


-- Tabla : Ventas
DROP TABLE IF EXISTS Ventas;
CREATE TABLE Ventas(
    IdVenta CHAR(10) NOT NULL,
    IdCliente CHAR(8) NOT NULL,
    FechaVenta DATE NOT NULL,
    MontoTotal DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdCliente,IdVenta),
    CHECK(MontoTotal > 0),
    CHECK(Estado IN ('0','1'))
);

-- Tabla : Detalle
DROP TABLE IF EXISTS Detalle;
CREATE TABLE Detalle(
    IdVenta CHAR(10) NOT NULL,
    IdProducto CHAR(8) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdVenta, IdProducto),
    CHECK(Cantidad > 0),
    CHECK(PrecioUnidad >0),
    CHECK(Estado IN ('0','1'))
);

-- PROCEDIMIENTOS ALMACENADOS
-- Store Procedure : ListarCategorias
DROP PROCEDURE IF EXISTS ListarCategorias;
DELIMITER @@
CREATE PROCEDURE ListarCategorias()
BEGIN
    SELECT * FROM Categorias;
END @@
DELIMITER ;

-- Llamada al procedimiento almacenado ListarCategorias
CALL ListarCategorias();

-- Store Procedure : InfoProducto
DROP PROCEDURE IF EXISTS InfoProducto;
DELIMITER @@
CREATE PROCEDURE InfoProducto(IdProd CHAR(8))
BEGIN
    SELECT * FROM Productos WHERE IdProducto=IdProd;
END @@
DELIMITER ;

-- Llamada al procedimiento almacenado InfoProducto
CALL InfoProducto('PRO00003');

-- Store Procedure : ListarProductos
DROP PROCEDURE IF EXISTS ListarProductos;
DELIMITER @@
CREATE PROCEDURE ListarProductos()
BEGIN
    SELECT * FROM Productos;
END @@
DELIMITER ;

-- Llamada al procedimiento almacenado ListarProductos
CALL ListarProductos();

-- Store Procedure : ListarProductosXCategoria
DROP PROCEDURE IF EXISTS ListarProductosXCategoria;
DELIMITER //
CREATE PROCEDURE ListarProductosXCategoria(IdCat CHAR(6))
BEGIN
    SELECT * FROM Productos
    WHERE IdCategoria = IdCat;
END //
DELIMITER ;

-- Llamada al procedimiento almacenado ListarProductosXCategoria
CALL ListarProductosXCategoria('CAT001');

-- Store Procedure : InfoCliente
DROP PROCEDURE IF EXISTS InfoCliente;
DELIMITER @@
CREATE PROCEDURE InfoCliente(IdCli CHAR(8))
BEGIN
    SELECT * FROM Clientes
    WHERE IdCliente = IdCli;
END @@
DELIMITER ;

-- Llamada al procedimiento almacenado InfoCliente
CALL InfoCliente('CLI00001');

-- Store Procedure : InsertaVenta
DROP PROCEDURE IF EXISTS InsertaVenta;
DELIMITER @@
CREATE PROCEDURE InsertaVenta(
    IdVenta CHAR(10),
    IdCliente CHAR(8),
    FechaVenta DATE,
    MontoTotal DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Ventas VALUES(IdVenta,IdCliente,FechaVenta,MontoTotal,Estado);
END @@
DELIMITER ;

-- Store Procedure : InsertaDetalle
DROP PROCEDURE IF EXISTS InsertaDetalle;
DELIMITER @@
CREATE PROCEDURE InsertaDetalle(
    IdVenta CHAR(10),
    IdProducto CHAR(8),
    Cantidad INT,
    PrecioUnidad DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Detalle VALUES(IdVenta,IdProducto,Cantidad,PrecioUnidad,Estado);
END @@
DELIMITER ;
