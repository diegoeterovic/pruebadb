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
    fecha, id_cliente)
    VALUES
    ('2020-01-01', 1),
    ('2020-01-02', 1),
    ('2020-01-03', 2),
    ('2020-01-04', 2),
    ('2020-01-05', 2),
    ('2020-01-06', 3),
    ('2020-01-07', 4),
    ('2020-01-08', 4),
    ('2020-01-09', 4),
    ('2020-01-09', 4)
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
INSERT INTO list_facturas(
    id, id_producto, cantidad_producto, id_factura)
    VALUES
    (1, 'MIT1234', 1, 1),
    (2, 'MIT1235', 1, 1),
    (3, 'MIT1235', 1, 1),
    (4, 'MIT1236', 1, 1),
    (5, 'MIT1237', 1, 1),
    (6, 'MIT1238', 1, 1),
    (7, 'MIT1239', 1, 1),
    (8, 'MIT1240', 1, 1),
    (9, 'MIT1234', 1, 1),
    (10, 'MIT1235', 1, 1),
    (11, 'MIT1237', 1, 1),
    (12, 'MIT1238', 1, 1),
    (13, 'MIT1239', 1, 1),
    (14, 'MIT1235', 1, 1),
    (15, 'MIT1237', 1, 1),
    (16, 'MIT1238', 1, 1),
    (17, 'MIT1235', 1, 1),
    (18, 'MIT1236', 1, 1),
    (19, 'MIT1237', 1, 1),
    (20, 'MIT1236', 1, 1),
    (21, 'MIT1237', 1, 1),
    (22, 'MIT1238', 1, 1),
    (23, 'MIT1239', 1, 1),
    (24, 'MIT1236', 1, 1);