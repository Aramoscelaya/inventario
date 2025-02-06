#ALTER TABLE categorias MODIFY COLUMN fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
#ALTER TABLE areas MODIFY COLUMN fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
#ALTER TABLE logs MODIFY COLUMN fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

CREATE SCHEMA `Inventario` ;

CREATE TABLE `inventario`.`categorias` (
	`id_categoria` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_categoria` VARCHAR(100) NOT NULL UNIQUE,
    `descripcion_categoria` TEXT,
    `estatus` TINYINT(1) NOT NULL DEFAULT 1,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
COMMENT = 'Tabla para clasificar el producto o equipo';

CREATE TABLE `inventario`.`areas` (
	`id_area` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nombre_area` VARCHAR(45) NOT NULL,
	`estatus` TINYINT(1) NOT NULL,
	`fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
COMMENT = 'Tabla para identificar las campañas (areas) que contienen equipos de computo';

CREATE TABLE `inventario`.`productos` (
	`id_producto` VARCHAR(250) NOT NULL PRIMARY KEY,
    `nombre_producto` VARCHAR(150) NOT NULL,
    `modelo` VARCHAR(150) NOT NULL,
    `marca` VARCHAR(150) NOT NULL,
    `hostname` VARCHAR(50) NULL,
    `descripcion_producto` TEXT,
    `stock` INT NOT NULL DEFAULT 1,
    `estatus`TINYINT(1) NOT NULL DEFAULT 1,
    `id_area` INT,    
    `id_categoria` INT,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`fecha_modificacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`usuario_modificacion` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`id_area`) REFERENCES areas(`id_area`) ON DELETE SET NULL,
	FOREIGN KEY (`id_categoria`) REFERENCES categorias(`id_categoria`) ON DELETE SET NULL)
COMMENT = 'Tabla para almacenar productos pc - lap - ups';

CREATE TABLE `inventario`.`usuarios` (
    `id_usuario` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nombre` VARCHAR(150) NOT NULL,
	`usuario` VARCHAR(150) NOT NULL,
    `contrasena` VARCHAR(255) NULL,
    `rol` ENUM('admin', 'colaborador') NOT NULL DEFAULT 'colaborador',
    `estatus`TINYINT(1) NOT NULL DEFAULT 1,
    `id_area` INT,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`fecha_modificacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`usuario_modificacion` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`id_area`) REFERENCES areas(`id_area`) ON DELETE SET NULL)
COMMENT = 'Tabla para usuarios del sisitema TI - agentes A - Supervisor S';

CREATE TABLE `inventario`.`mantenimientos` (
    `id_mantenimiento` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `estado_manto` INT NOT NULL DEFAULT 1,
    `descripcion_manto` TEXT,
    `estatus`TINYINT(1) NOT NULL DEFAULT 1,
    `id_producto` VARCHAR(250),
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`fecha_modificacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`usuario_modificacion` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`id_producto`) REFERENCES productos(`id_producto`) ON DELETE SET NULL)
COMMENT = 'estado_manto / Pendiente 1 - Diagnóstico 2 - En curso 3 - Manto preventivo 4 - Manto correctivo 5 - Listo 6';

CREATE TABLE `inventario`.`asignaciones` (
    `id_asinacion` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `estatus`TINYINT(1) NOT NULL DEFAULT 1,
    `id_usuario` INT,
	`id_producto` VARCHAR(250),
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`fecha_modificacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`usuario_modificacion` VARCHAR(50) NOT NULL,
    FOREIGN KEY (`id_usuario`) REFERENCES usuarios(`id_usuario`) ON DELETE SET NULL,
    FOREIGN KEY (`id_producto`) REFERENCES productos(`id_producto`) ON DELETE SET NULL)
COMMENT = 'Tabla para tener registro de las asignaciones Estatus / entregado 1 - devuelto 2 - perdido 3';

CREATE TABLE `inventario`.`logs` (
	`id_log` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `vista` VARCHAR(100) NOT NULL,
    `categoria` VARCHAR(100) NOT NULL,
    `descripcion_log` TEXT,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
COMMENT = 'Tabla para clasificar los logs';

/*
id_producto-PF4HD0K,
nombre_producto-Laptop,
modelo-E14,
marca-Lenovo,
hostname-WPHI002
https://es.qr-code-generator.com
*/

INSERT INTO categorias (nombre_categoria, descripcion_categoria, estatus)
VALUES ('CPU', 'Equipo de escritorio', 1), ('UPS', 'Equipo regulador de corriente', 1),
('Laptop', 'Equipo de computo portatil', 1), ('Monitor', 'Equipo de video', 1);

INSERT INTO areas (nombre_area, estatus)
VALUES ('Sistemas', 1), ('Nexus Service', 1), ('Nexus Sales', 1), ('Avis', 1), ('Honest Inmigration', 1), ('W2FLY', 1);

INSERT INTO productos (id_producto, nombre_producto, modelo, marca, hostname, descripcion_producto, estatus, id_area, id_categoria, usuario_modificacion)
VALUES ('8CCDN02', 'CPU Dell', 'optiplex 3090', '', 'WPNXT30-PC', 'PC de NXT servicios', 1, 1, 1, 'WPSIS07');

INSERT INTO usuarios (nombre, usuario, contrasena, rol, estatus, id_area, usuario_modificacion)
VALUES ('Alejandro Ramos Celaya', 'WPSIS07', '0006', 'admin', 1, 1, 'admin');

INSERT INTO mantenimientos (descripcion_manto, estatus, id_producto, usuario_modificacion)
VALUES ('test pendiente', 1, '8CCDN02', 'WPSIS07');

INSERT INTO asignaciones (id_usuario, id_producto, usuario_modificacion)
VALUES (1, '8CCDN02', 'WPSIS07');
