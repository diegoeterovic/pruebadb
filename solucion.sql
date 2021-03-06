psql
CREATE DATABASE prueba;
\c prueba

--Creacion tabla categorias
CREATE TABLE categorias(
    id VARCHAR(20),
    nombre VARCHAR(20),
    descripcion VARCHAR(20),
    PRIMARY KEY (id)
);

SELECT *  FROM categorias;

--insert de datos en categorias
INSERT INTO categorias (
    id, nombre, descripcion
) VALUES 
    (1, 'mecanica', 'comp mecanicos'),
    (2, 'exterior', 'comp de exterior'),
    (3, 'iluminacion', 'comp de ilumincacion');

--Creacion tabla productos

CREATE TABLE productos(
    id VARCHAR(20),
    nombre VARCHAR(50),
    descripcion VARCHAR(90),
    valor INT,
    id_categoria VARCHAR (20),
    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

-- ingreso de datos productos
INSERT INTO productos (
    id, nombre, descripcion, valor, id_categoria
) VALUES 
    ('MIT1234', 'capot lancer', 'Capot mitsubishi lancer 2002', 249990, '2'),
    ('MIT1235', 'Foco lancer', 'Foco mitsubishi lancer 2002', 129990, '3'),
    ('MIT1236', 'Motor lancer', 'Motor mitsubishi lancer 2002', 899990, '1'),
    ('MIT1237', 'Caja Lancer', 'Caja mitsubishi lancer 2002', 459990, '1'),
    ('MIT1238', 'Parachoque del Lancer', 'Parachoque Del mitsubishi lancer 2002', 239990, '2'),
    ('MIT1239', 'Puerta Tras Izq Lancer', 'Puerta Tras Izq mitsubishi lancer 2002', 249990, '2'),
    ('MIT1240', 'Foco Tras Izq Lancer', 'Foco Tras Izq mitsubishi lancer 2002', 122990, '3'),
    ('MIT1241', 'Foco retroceso lancer', 'Foco Retroceso mitsubishi lancer 2002', 79990, '3')
    ;
SELECT *  FROM productos;

--creacion tabla clientes
CREATE TABLE clientes(
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    rut VARCHAR(10) NOT NULL,
    addres VARCHAR(50),
    PRIMARY KEY (id)
);

--insertado de datos clientes
INSERT INTO clientes (
    id, nombre, rut, addres)
    VALUES
    (1, 'diego', '17407662-6', 'las condes'),
    (2, 'javier', '17407661-8', 'san bernardo'),
    (3, 'francisco', '17407660-9', 'la cisterna'),
    (4, 'ismael', '17407659-1', 'vina del mar'),
    (5, 'felipe', '17407658-k', 'maipu');

SELECT *  FROM clientes;

--creacion tabla facturas
CREATE TABLE facturas(
    id SERIAL,
    numero SERIAL,
    fecha DATE,
    subtotal INT,
    IVA INT,
    total INT,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);
-- ingreso facturas
INSERT INTO facturas(
    fecha, id_cliente, subtotal)
    VALUES
    ('2020-01-01', 1, 379980),
    ('2020-01-02', 1, 1489970),
    ('2020-01-03', 2, 612970),
    ('2020-01-04', 2, 379980),
    ('2020-01-05', 2, 949970),
    ('2020-01-06', 3, 129990),
    ('2020-01-07', 4, 699980),
    ('2020-01-08', 4, 1489970),
    ('2020-01-09', 4, 1849960),
    ('2020-01-09', 4, 899990)
;

SELECT *  FROM facturas;

--creacion tabla list_factura 
CREATE TABLE list_facturas(
    id INT,
    id_producto VARCHAR(20),
    valor_producto INT,
    cantidad_producto INT,
    total INT,
    id_factura INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_factura) REFERENCES facturas(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);
-- insert de items
INSERT INTO list_facturas(
    id, id_producto, cantidad_producto, id_factura)
    VALUES
    (1, 'MIT1234', 1, 1),
    (2, 'MIT1235', 1, 1),
    (3, 'MIT1235', 1, 2),
    (4, 'MIT1236', 1, 2),
    (5, 'MIT1237', 1, 2),
    (6, 'MIT1238', 1, 3),
    (7, 'MIT1239', 1, 3),
    (8, 'MIT1240', 1, 3),
    (9, 'MIT1234', 1, 4),
    (10, 'MIT1235', 1, 4),
    (11, 'MIT1237', 1, 5),
    (12, 'MIT1238', 1, 5),
    (13, 'MIT1239', 1, 5),
    (14, 'MIT1235', 1, 6),
    (15, 'MIT1237', 1, 7),
    (16, 'MIT1238', 1, 7),
    (17, 'MIT1235', 1, 8),
    (18, 'MIT1236', 1, 8),
    (19, 'MIT1237', 1, 8),
    (20, 'MIT1236', 1, 9),
    (21, 'MIT1237', 1, 9),
    (22, 'MIT1238', 1, 9),
    (23, 'MIT1239', 1, 9),
    (24, 'MIT1236', 1, 10);

--Querys
--pregunta 1 ¿Que cliente realizó la compra más cara?
SELECT nombre FROM clientes where id=(SELECT id_cliente FROM facturas ORDER BY subtotal DESC LIMIT 1);
--pregunta 2 ¿Que cliente pagó sobre 100 de monto?
SELECT id_cliente FROM facturas WHERE subtotal > 1000000 GROUP BY id_cliente ORDER BY id_cliente;
-- ¿Cuantos clientes han comprado el producto 6.
SELECT COUNT(DISTINCT id_cliente) FROM facturas INNER JOIN list_facturas ON facturas.numero=list_facturas.id_factura WHERE id_producto = 'MIT1236';



-- PRUEBAS
SELECT nombre FROM clientes INNER JOIN facturas ON clientes.id=facturas.id_cliente where id_cliente=1;

--me devuelve el nombre de la persona con su determinada factura
SELECT nombre FROM clientes where id=(SELECT id_cliente FROM FACTURAS where numero=2);
-- me devuelve facturas
(SELECT id_factura FROM list_facturas WHERE id_producto= 'MIT1236');

--me tira erro porque me devuelve una matriz
SELECT nombre FROM clientes where id=(SELECT id_cliente FROM FACTURAS where numero=(SELECT id_factura FROM list_facturas WHERE id_producto= 'MIT1236'));
