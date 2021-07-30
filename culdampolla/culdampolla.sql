DROP DATABASE IF EXISTS CuldAmpolla;
CREATE DATABASE CuldAmpolla  DEFAULT CHARACTER SET utf8mb4;
USE CuldAmpolla;


-- table `CuldAmpolla`.`Direccion`
CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`Direccion` (
  `Direccion_id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(8) NOT NULL,
  `piso` VARCHAR(8) NULL,
  `puerta` VARCHAR(2) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`Direccion_id`))
ENGINE = InnoDB;

-- table  `CuldAmpolla`.`Provedor`
CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`Provedor` (
  `Provedor_id` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NULL,
  `fax` VARCHAR(45) NULL,
  `Direccion_id` INT NOT NULL,
  PRIMARY KEY (`Provedor_id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  INDEX `fk_Provedor_Direccion_index` (`Direccion_id` ASC),
  CONSTRAINT `fk_Provedor_Direccion`
    FOREIGN KEY (`Direccion_id`)
    REFERENCES `CuldAmpolla`.`Direccion` (`Direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--table  `CuldAmpolla`.Clientes`

CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`Clientes` (
  `Cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `fecha_de_registro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Direccion_id` INT NOT NULL,
  PRIMARY KEY (`Cliente_id`),
  INDEX `fk_Clientes_Direccion_index` (`Direccion_id` ASC),
  CONSTRAINT `fk_Clientes_Direccion`
    FOREIGN KEY (`Direccion_id`)
    REFERENCES `CuldAmpolla`.`Direccion` (`Direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`Empleados` (
  `Empleados_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Empleados_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`Gafas` (
  `Gafas_id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduación_derecha` VARCHAR(10) NULL,
  `graduación_izquierda` VARCHAR(10) NULL,
  `color_derecha` VARCHAR(10) NULL,
  `color_izquierda` VARCHAR(10) NULL,
  `muntura` VARCHAR(45) NULL,
  `color_muntura` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NULL,
  `Provedor_id` INT NOT NULL,
  PRIMARY KEY (`Gafas_id`),
  INDEX `fk_Gafas_Provedor_index` (`Provedor_id` ASC),
  CONSTRAINT `fk_Gafas_Provedor`
    FOREIGN KEY (`Provedor_id`)
    REFERENCES `CuldAmpolla`.`Provedor` (`Provedor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `CuldAmpolla`.`facturas` (
  `Factura_id` INT NOT NULL AUTO_INCREMENT,
  `Total` DECIMAL(6,2) NOT NULL,
  `Cliente_id` INT NOT NULL,
  `fecha_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Empleados_id` INT NOT NULL,
  `Gafas_id` INT NOT NULL,
  PRIMARY KEY (`Factura_id`),
  INDEX `fk_Facturas_Clientes_index` (`Cliente_id` ASC),
  INDEX `fk_Facturas_Empleados_index` (`Empleados_id` ASC),
  INDEX `fk_Facturas_Gafas_index` (`Gafas_id` ASC),
  CONSTRAINT `fk_Facturas_Clientes1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `CuldAmpolla`.`Clientes` (`Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facturas_Empleados`
    FOREIGN KEY (`Empleados_id`)
    REFERENCES `CuldAmpolla`.`Empleados` (`Empleados_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facturas_Gafas`
    FOREIGN KEY (`Gafas_id`)
    REFERENCES `CuldAmpolla`.`Gafas` (`Gafas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



INSERT INTO direccion(calle, numero, piso, puerta, ciudad, codigo_postal, pais) VALUES ('Sayeed', '145', '1', '1', 'Barcelona', '08006', 'ES');
INSERT INTO direccion(calle, numero, piso, puerta, ciudad, codigo_postal, pais) VALUES ('Omar', '200', '1', '1', 'Badalona', '08445', 'ES');
INSERT INTO direccion(calle, numero, piso, puerta, ciudad, codigo_postal, pais) VALUES ('Elena', '147', '1', '1', 'Barcelona', '08066', 'ES');


INSERT INTO clientes(nombre,  telefono, email,direccion_id) VALUES('Beron', '456464654', 'beron@email.com',3);
INSERT INTO clientes(nombre,  telefono, email,direccion_id) VALUES('Robin', '455454488', 'robin@outlook.com',2);
INSERT INTO clientes(nombre,  telefono, email,direccion_id) VALUES('David',  '789545445', 'david@gamil.com',2);
INSERT INTO provedor(nif,nombre, telefono, fax, direccion_id) VALUES('y677677s', 'Mike', '2211445566',null,1);
INSERT INTO provedor(nif,nombre, telefono, fax, direccion_id) VALUES('rrjkjlks', 'Osana', '11223344','12121565',2);

INSERT INTO gafas(marca, graduación_derecha, graduación_izquierda, color_derecha, color_izquierda, muntura, color_muntura, precio, provedor_id)
values ('Ray-ban', '-0.125', '0.6', 'rojo', 'rojo', 'basica', 'blanca', 120.89, 1);
INSERT INTO gafas(marca, graduación_derecha, graduación_izquierda, color_derecha, color_izquierda, muntura, color_muntura, precio, provedor_id)
values ('Boss', '3.25', '-0.6', 'rojo', 'rojo', 'standard', 'blanca', 199.5, 1);
INSERT INTO gafas(marca, graduación_derecha, graduación_izquierda, color_derecha, color_izquierda, muntura, color_muntura, precio, provedor_id)
values ('Ale', '0.25', '2.6', 'rojo', 'rojo', 'especial', 'blanca', 555.45, 1);
INSERT INTO gafas(marca, graduación_derecha, graduación_izquierda, color_derecha, color_izquierda, muntura, color_muntura, precio, provedor_id)
values ('Hangman', '0.75', '0.6', 'rojo', 'rojo', 'metal', 'blanca', 555.55, 2);


INSERT INTO Empleados(nombre) VALUES ('Simon ');
INSERT INTO Empleados(nombre) VALUES ('Priyam');
INSERT INTO Empleados(nombre) VALUES ('Josef');

INSERT INTO facturas(total, cliente_id, fecha_compra, empleados_id, gafas_id) VALUES (1000.34, 1, '2021-09-09 00:00:01', 1,3);
INSERT INTO facturas(total, cliente_id, fecha_compra, empleados_id, gafas_id) VALUES (1000.34, 3, '2021-08-10 00:00:01', 2,2);
INSERT INTO facturas(total, cliente_id, fecha_compra, empleados_id, gafas_id) VALUES (1000.34, 2, '2021-08-10 00:00:01', 3,1);

SELECT clientes.nombre, clientes.cliente_id, count(clientes.cliente_id) AS number_of_clientes
FROM facturas
JOIN clientes
ON clientes.cliente_id = facturas.cliente_id
WHERE facturas.fecha_compra > '2021-08-10 00:00:01'
GROUP BY facturas.cliente_id;

SELECT gafas.marca, provedor.provedor_id, provedor.nombre FROM gafas
JOIN provedor
ON gafas.provedor_id = provedor.provedor_id
JOIN facturas
ON gafas.gafas_id = facturas.factura_id
JOIN clientes
ON facturas.cliente_id = clientes.cliente_id
WHERE facturas.fecha_compra < '2021-09-09 00:00:01';

SELECT gafas.marca, empleados.nombre FROM gafas
JOIN facturas
ON facturas.gafas_id = gafas.gafas_id
JOIN empleados
ON facturas.empleados_id = empleados.empleados_id
WHERE facturas.fecha_compra >'2021-08-10';