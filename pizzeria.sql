DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;


CREATE TABLE clientes( 
cliente_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50),
apellidos VARCHAR(50),
direccion VARCHAR(50),
codigo_postal VARCHAR(50),
localidad_id INT,
provincia_id INT
-- FOREIGN KEY(localidad_id) REFERENCES localidades(localidad_id),
-- FOREIGN KEY(provincia_id) REFERENCES provincias(provincia_id)

);

CREATE TABLE localidades(
localidad_id INT PRIMARY KEY AUTO_INCREMENT,
nobmre VARCHAR(100)
);
CREATE TABLE provincias(
provincia_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (100)
);


CREATE TABLE pedidos(
	pedido_id  INT PRIMARY KEY AUTO_INCREMENT,
    fetcha DATETIME DEFAULT NOW(),
    tipos_de_pedido_id INT,
    cantidad_de_productos INT,
    total_price DECIMAL(5,2)
   -- FOREIGN KEY(tipos_de_pedido_id) REFERENCES tipos_de_pedidos(tipos_de_pedidos_id)
);

CREATE TABLE tipos_de_pedidos (
tipos_de_pedidos_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100)
);
CREATE TABLE productos(
producto_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
descripcion VARCHAR(255),
imagen VARCHAR(255),
precio DECIMAL(4,2),
categoria_id INT
-- FOREIGN KEY(categoria_id) REFERENCES categorias(categoria_id)
);

CREATE TABLE categorias(
	categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255)
);

CREATE TABLE tienda(
tienda_id INT PRIMARY KEY AUTO_INCREMENT,
direccion VARCHAR(255),
codigo_postal VARCHAR(100),
localidad VARCHAR(100),
provincia VARCHAR(100),
empleado_id INT 
-- FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

CREATE TABLE empleados(
empleado_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
apellidos  VARCHAR(100),
NIF  VARCHAR(100),
telefono  VARCHAR(100),
tipo_de_trabajo_id INT,
pedido_de_domicilio_id INT
-- FOREIGN KEY (tipo_de_trabajo_id) REFERENCES tipo_de_trabajos(tipo_de_trabajo_id) ,
-- FOREIGN KEY (pedido_de_domicilio_id) REFERENCES pedidos_de_domiciclio(pedido_de_domicilio_id)
);

CREATE TABLE tipo_de_trabajo (
tipo_de_trabajo_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100)
);
CREATE TABLE pedidos_de_domicilio(
pedido_de_domicilio_id INT PRIMARY KEY AUTO_INCREMENT,
empleado_id INT,
fetcha DATETIME DEFAULT NOW()
-- FOREIGN KEY(empleado_id) REFERENCES empleados(empleado_id)
);

ALTER TABLE clientes ADD FOREIGN KEY(localidad_id) REFERENCES localidades(localidad_id);
ALTER TABLE clientes ADD FOREIGN KEY(provincia_id) REFERENCES provincias(provincia_id);
ALTER TABLE pedidos ADD FOREIGN KEY(tipos_de_pedido_id)REFERENCES tipos_de_pedidos(tipos_de_pedidos_id);
ALTER TABLE productos ADD FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id);
ALTER TABLE tienda ADD FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id);
ALTER TABLE empleados ADD FOREIGN KEY(tipo_de_trabajo_id) REFERENCES tipo_de_trabajo(tipo_de_trabajo_id);
ALTER TABLE pedidos_de_domicilio ADD FOREIGN KEY(empleado_id) REFERENCES empleados(empleado_id);
ALTER TABLE empleados ADD FOREIGN KEY (pedido_de_domicilio_id) REFERENCES pedidos_de_domiciclio(pedido_de_domicilio_id)




