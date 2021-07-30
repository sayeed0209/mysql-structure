DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;


CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `Provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Provincia_id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `Localidad_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `Provincia_id` INT NOT NULL,
  PRIMARY KEY (`Localidad_id`),
  INDEX `fk_localidad_provincia_index` (`Provincia_id` ASC),
  CONSTRAINT `fk_localidad_provincia`
    FOREIGN KEY (`Provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`Provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`direccion` (
  `Direccion_id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(5) NOT NULL,
  `localidad_id` INT NOT NULL,
  PRIMARY KEY (`Direccion_id`),
  INDEX `fk_Direccion_Localidad_index` (`Localidad_id` ASC),
  CONSTRAINT `fk_Direccion_Localidad`
    FOREIGN KEY (`Localidad_id`)
    REFERENCES `pizzeria`.`Localidad` (`Localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `Cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `Direccion_id` INT NOT NULL,
  PRIMARY KEY (`Cliente_id`),
  INDEX `fk_Cliente_Direccion_index` (`Direccion_id` ASC),
  CONSTRAINT `fk_cliente_Direccion`
    FOREIGN KEY (`Direccion_id`)
    REFERENCES `pizzeria`.`Direccion` (`Direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `Tienda_id` INT NOT NULL AUTO_INCREMENT,
  `Direccion_id` INT NOT NULL,
  PRIMARY KEY (`Tienda_id`),
  INDEX `fk_Tienda_Direccion_index` (`Direccion_id` ASC),
  CONSTRAINT `fk_Botiga_Direccion`
    FOREIGN KEY (`Direccion_id`)
    REFERENCES `pizzeria`.`Direccion` (`Direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `Empleado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apelldos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `tarea` VARCHAR(45) NOT NULL,
  `Tienda_id` INT NOT NULL,
  PRIMARY KEY (`Empleado_id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  INDEX `fk_empleado_Tienda_index` (`Tienda_id` ASC),
  CONSTRAINT `fk_Empleado_Tienda`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `pizzeria`.`Tienda` (`Tienda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`facturas` (
  `Factura_id` INT NOT NULL AUTO_INCREMENT,
  `fecha_de_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `repartir` TINYINT NOT NULL COMMENT '1 repertir a domicili, 0 per a recoger en tienda',
  `precio_total` DECIMAL(6,2) NOT NULL,
  `Tienda_id` INT NOT NULL,
  `Cliente_id` INT NOT NULL,
  `Empleado_id` INT NOT NULL,
  PRIMARY KEY (`Factura_id`),
  INDEX `fk_Facutra_Tienda_index` (`Tienda_id` ASC),
  INDEX `fk_Facutra_cliente1_index` (`Cliente_id` ASC),
  INDEX `fk_Facutra_empleat1_index` (`Empleado_id` ASC),
  CONSTRAINT `fk_Facutra_Tienda`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`Tienda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facutra_cliente`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `pizzeria`.`clientes` (`Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facutra_empleado`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `pizzeria`.`empleados` (`Empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `pizzeria`.`entregas` (
  `Entrega_id` INT NOT NULL AUTO_INCREMENT,
  `Factura_id` INT NOT NULL,
  `fecha_de_entrega` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Entrega_id`),
  INDEX `fk_Empleado_Factura_index` (`Factura_id` ASC),
  CONSTRAINT `fk_Empleado_Factura`
    FOREIGN KEY (`Factura_id`)
    REFERENCES `pizzeria`.`facturas` (`Factura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `Categoria_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Categoria_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `Producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `image_url` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `Categoria_id` INT NULL,
  PRIMARY KEY (`producto_id`),
  INDEX `fk_Producto_Categoria_index` (`Categoria_id` ASC),
  CONSTRAINT `fk_Producto_Categoria`
    FOREIGN KEY (`Categoria_id`)
    REFERENCES `pizzeria`.`categoria` (`Categoria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `pizzeria`.`detalles_de_factura` (
  `Detalles_de_factura_id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` TINYINT NOT NULL,
  `precio_cada_uno_ing` DECIMAL(6,2) NOT NULL,
  `Producto_id` INT NOT NULL,
  `Factura_id` INT NOT NULL,
  PRIMARY KEY (`Detalles_de_factura_id`),
  INDEX `fk_Detalles_de_factura_index` (`Producto_id` ASC),
  INDEX `fk_Detalles_de_factura_fuctura_index` (`Factura_id` ASC),
  CONSTRAINT `fk_Detalles_de_factura`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `pizzeria`.`productos` (`Producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalles_de_factura1`
    FOREIGN KEY (`Factura_id`)
    REFERENCES `pizzeria`.`facturas` (`Factura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO categoria(nombre) VALUES ('Vegetarianas');
INSERT INTO categoria(nombre) VALUES ('Veganas');
INSERT INTO categoria(nombre) VALUES ('Tradicionales');


INSERT INTO productos(nombre, tipo, descripcion, image_url, precio, categoria_id) VALUES('Fanta', 'Bebida',null, 'https://images.unsplash.com/photo-1598419161288-9f2f26c85590?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80', 4.50, null);
INSERT INTO productos(nombre, tipo, descripcion, image_url, precio, categoria_id) VALUES('4 quesos', 'Pizza',null, null, 9.90, null);
INSERT INTO productos(nombre, tipo, descripcion, image_url, precio, categoria_id) VALUES('Neapolitan', 'Pizza',null,'https://images.unsplash.com/photo-1458642849426-cfb724f15ef7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmFwb2xpdGFuJTIwcGl6emF8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60', 8.50, null);

INSERT INTO provincia(nombre) VALUES ('Barcelona');
INSERT INTO provincia(nombre) VALUES ('Madrid');
INSERT INTO provincia(nombre) VALUES ('Sevilla');

INSERT INTO localidad(nombre, provincia_id) VALUES ('Sabadell', 2);
INSERT INTO localidad(nombre, provincia_id) VALUES ('Iguldad', 1);
INSERT INTO localidad(nombre, provincia_id) VALUES ('Madrid', 3);


INSERT INTO direccion(direccion, codigo_postal, localidad_id) VALUES ('Comote_de_urgell 24', '08011', 2);
INSERT INTO direccion(direccion, codigo_postal, localidad_id) VALUES ('Cathdedral 16', '08001', 1);
INSERT INTO direccion(direccion, codigo_postal, localidad_id) VALUES ('Arc de triomf', '080555', 3);


INSERT INTO tienda(direccion_id) VALUES (1);
INSERT INTO tienda(direccion_id) VALUES (2);
INSERT INTO tienda(direccion_id) VALUES (3);


INSERT INTO empleados(nombre, apelldos, nif, telefono, tarea, tienda_id) VALUES ('Sayeed', 'Abu', 'yjyhjhjh', '545644', 'repartidor',1);
INSERT INTO empleados(nombre, apelldos, nif, telefono, tarea, tienda_id) VALUES ('Omar', 'Mejor', 'ydassse', '545644', 'cocinero',2);


INSERT INTO clientes(nombre, apellidos, telefono, direccion_id) VALUES ('Mike', 'Cuin', '45546565', 1);
INSERT INTO clientes(nombre, apellidos, telefono, direccion_id) VALUES ('Priyam', 'Gahr', '45546565', 2);


INSERT INTO facturas(fecha_de_compra, repartir, precio_total, tienda_id, cliente_id, empleado_id) VALUES ('2021-08-20 00:00:01', 1, 20.98, 3,1,2);
INSERT INTO facturas(fecha_de_compra, repartir, precio_total, tienda_id, cliente_id, empleado_id) VALUES ('2021-09-20 00:00:01', 1, 25.88, 1,2,2);
INSERT INTO facturas(fecha_de_compra, repartir, precio_total, tienda_id, cliente_id, empleado_id) VALUES ('2021-10-20 00:00:01', 0, 36.77, 2,1,1);


INSERT INTO detalles_de_factura(cantidad, precio_cada_uno_ing, producto_id, factura_id) VALUES(2, 6.50, 3, 2);
INSERT INTO detalles_de_factura(cantidad, precio_cada_uno_ing, producto_id, factura_id) VALUES(1, 6.50, 1, 3);
INSERT INTO detalles_de_factura(cantidad, precio_cada_uno_ing, producto_id, factura_id) VALUES(3, 6.50, 2, 1);

INSERT INTO entregas(factura_id, fecha_de_entrega) VALUES (1, '2021-08-20 00:00:01');
INSERT INTO entregas(factura_id, fecha_de_entrega) VALUES (2, '2021-09-20 00:00:01');
INSERT INTO entregas(factura_id, fecha_de_entrega) VALUES (3, '2021-10-20 00:00:01');


SELECT l.nombre, sum(cd.cantidad) as cantidad_de_bebida
FROM detalles_de_factura cd
JOIN facturas f
ON f.factura_id = cd.factura_id
JOIN  productos p
ON cd.producto_id = p.producto_id
JOIN tienda t
ON t.tienda_id = f.tienda_id
JOIN direccion d
ON t.direccion_id = d.direccion_id
JOIN localidad l
ON l.localidad_id = d.localidad_id
WHERE p.tipo = 'bebida'
group by l.nombre;

SELECT e.nombre, count(f.factura_id) as cantidad_de_pedidos
FROM facturas f
JOIN empleados e
ON f.empleado_id = e.empleado_id
GROUP BY e.nombre;