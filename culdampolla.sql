DROP DATABASE IF EXISTS CuldAmpolla;
CREATE DATABASE CuldAmpolla  CHARACTER SET utf8mb4;
USE CuldAmpolla;


CREATE TABLE proveedores( 
proveedor_id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
calle VARCHAR(50),
numero INT(11),
piso VARCHAR(10),
puerta VARCHAR(20),
ciudad VARCHAR(50),
codigo_postal VARCHAR(50),
pais VARCHAR(50),
telefono   INT (11)
);

INSERT INTO `proveedores` (`proveedor_id`, `nombre`, `calle`, `numero`, `piso`, `puerta`, `ciudad`, `codigo_postal`, `pais`, `telefono`) VALUES
(1, 'Miguel', 'Hosplital clinic', 140, '3', '3', 'Barcelona', '08005', 'España', 2147483647),
(2, 'Jose', 'Sepulveda', 65, '1', '3', 'Barcelona', '08055', 'España', 65228999),
(3, 'Maria', 'Sol', 122, '1', '3', 'Madrid', '05689', 'España', 65228488);



CREATE TABLE tipos_de_monturas(
tipo_de_montura_id INT  AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50)
);


INSERT INTO `tipos_de_monturas` (`tipo_de_montura_id`, `nombre`) VALUES
(1, 'flotante'),
(2, 'pasta'),
(3, 'metalica');



CREATE TABLE gafas(
gafas_id INT  AUTO_INCREMENT PRIMARY KEY, 
la_marca VARCHAR(50),
la_graduacion VARCHAR(50),
tipo_de_montura_id INT,
color_de_la_montura VARCHAR(50),
color_de_cristal VARCHAR(50),
precio  DECIMAL(5,2),
proveedor_id INT,
FOREIGN KEY(tipo_de_montura_id ) REFERENCES tipos_de_monturas(tipo_de_montura_id),
FOREIGN KEY(proveedor_id ) REFERENCES proveedores(proveedor_id)

);

INSERT INTO `gafas` (`gafas_id`, `la_marca`, `la_graduacion`, `tipo_de_montura_id`, `color_de_la_montura`, `color_de_cristal`, `precio`,`proveedor_id`) VALUES
(1, 'ray ban', '-4.5', 1, 'Rojo', 'Negro', '132.22',1),
(2, 'Gucci', '-4.2', 3, 'Blanco', 'Gris', '122.56',1),
(3, 'Prada', '-6.5', 2, 'Amarillo', 'Verde', '145.00',2),
(4, 'Versace', '-6.5', 2, 'Azul', 'Blanco', '145.00',2),
(5, 'Burberry', '-6.5', 2, 'Verde', 'Negro', '145.00',3);


CREATE TABLE clientes(
client_id INT  AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50),
el_correo VARCHAR(100),
fetcha_de_registro DATETIME NOT NULL DEFAULT NOW()
);

INSERT INTO `clientes` (`client_id`, `nombre`, `el_correo`, `fetcha_de_registro`) VALUES
(1, 'elena', 'elena@gail.com', '2021-05-01 15:29:04'),
(2, 'maria', 'maria@gmail.com', '2021-05-01 15:29:05'),
(3, 'maria', 'maria.gamil.com', '2021-05-01 15:29:05');


CREATE TABLE empleados(
empleado_id INT AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50)
);


INSERT INTO `empleados` (`empleado_id`, `nombre`) VALUES
(1, 'sayeed'),
(2, 'robin');



CREATE TABLE facturas( 
fuctura_id INT AUTO_INCREMENT PRIMARY KEY,
client_id INT,
recomendado_id INT,
empleado_id INT,
gafas_id INT,
fetcha_de_registro DATETIME NOT NULL DEFAULT NOW(),
FOREIGN KEY(client_id) REFERENCES clientes(client_id),
FOREIGN KEY(recomendado_id) REFERENCES empleados(empleado_id),
FOREIGN KEY(empleado_id) REFERENCES empleados(empleado_id),
FOREIGN KEY(gafas_id) REFERENCES gafas(gafas_id)
);

INSERT INTO `facturas` (`fuctura_id`, `client_id`, `recomendado_id`, `empleado_id`,`gafas_id`,`fetcha_de_registro`) VALUES
(1, 1, 2, 2,1,'2021-05-01 15:29:04'),
(2, 2, 1, 1,2,'2021-05-01 15:29:04'),
(3, 2, 1, 1,3,'2021-05-01 12:29:04'),
(4, 2, 1, 1,3,'2020-05-01 15:29:04');


-- Lista el total de facturas de un cliente en un periodo determinado
SELECT * ,COUNT(*) as Total FROM `clientes` WHERE nombre='maria' AND fetcha_de_registro='2021-05-01 15:29:05';

-- Lista los diferentes modelos de gafas que ha vendido un empleado durante un año
SELECT * FROM facturas
JOIN gafas 
ON gafas.gafas_id= facturas.gafas_id
JOIN empleados
On empleados.empleado_id =facturas.empleado_id
WHERE facturas.fetcha_de_registro BETWEEN '2020-05-01' AND '2021-05-01';


-- Lista los diferentes proveedores que han suministrado gafas vendidas con éxito para la óptica
SELECT proveedores.nombre,gafas.la_marca FROM proveedores
JOIN gafas
ON gafas.proveedor_id = proveedores.proveedor_id
JOIN facturas
ON gafas.gafas_id = facturas.gafas_id




