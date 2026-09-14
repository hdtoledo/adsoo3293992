-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Laura Valentina Parra Urriago
-- Número de Ficha:     3293992
-- Fecha:               10 de Septiembre
-- ==============================================================================

-- INSTRUCCIONES:
-- 1. Complete cada uno de los bloques señalados con [TODO: ...].
-- 2. Ejecute el script secuencialmente en MySQL Workbench o DBeaver.
-- 3. Verifique que no queden errores en la consola (Action Output en verde).
-- 4. Guarde este archivo como: taller_sistema_ventas_[su_nombre].sql

-- ------------------------------------------------------------------------------
-- FASE 1: CREACIÓN DE LA BASE DE DATOS (DDL)
-- ------------------------------------------------------------------------------

-- [TODO 1.1]: Escriba la sentencia para eliminar la base de datos 'taller_ventas_adso' si ya existe.

DROP DATABASE IF EXISTS taller_ventas_adso;
   
-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.

CREATE DATABASE taller_ventas_adso
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;


-- [TODO 1.3]: Ponga en uso la base de datos creada.

USE taller_ventas_adso

-- ------------------------------------------------------------------------------
-- FASE 2: DEFINICIÓN DE TABLAS Y RESTRICCIONES (DDL)
-- ------------------------------------------------------------------------------

-- [TODO 2.1]: Crear la tabla 'usuarios' con las siguientes columnas y restricciones:
--   - id: Entero autoincremental, Llave primaria.
--   - documento: Cadena hasta 20 caracteres, obligatorio y valor ÚNICO.
--   - nombres: Cadena hasta 100 caracteres, obligatorio.
--   - email: Cadena hasta 120 caracteres, obligatorio y ÚNICO.
--   - rol: Solo puede ser 'ADMIN', 'VENDEDOR' o 'CLIENTE'. Por defecto 'CLIENTE'.
--   - activo: Booleano, obligatorio, por defecto TRUE (1).
--   - creado_en: Fecha y hora actual por defecto.

CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `documento` varchar(20) NOT NULL UNIQUE,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL UNIQUE,
  `rol` enum('ADMIN','VENDEDOR','CLIENTE') DEFAULT 1,
  `activo` boolean DEFAULT '1',
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
) ENGINE=InnoDB


-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.

CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` varchar(60) NOT NULL UNIQUE,
  `descripcion` text NULL,
  `activo` boolean DEFAULT '1',
) ENGINE=InnoDB 


-- [TODO 2.3]: Crear la tabla 'productos':
--   - id: Entero autoincremental, Llave primaria.
--   - codigo_barras: Cadena hasta 50 caracteres, obligatorio y ÚNICO.
--   - nombre: Cadena hasta 120 caracteres, obligatorio.
--   - precio: Decimal(10,2), obligatorio.
--   - stock: Entero, obligatorio, por defecto 0.
--   - categoria_id: Entero, obligatorio.
--   - RESTRICCIÓN FK: 'categoria_id' debe referenciar a 'id' de la tabla 'categorias'.
--                     Regla al eliminar: RESTRICT. Regla al actualizar: CASCADE.

CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `codigo_barras` varchar(120) NOT NULL UNIQUE,
  `nombre` varchar(120) NOT NULL,
  `precio` decimal NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `categoria_id` int NOT NULL,

  
  CONSTRAINT `fk_productos_categorias` 
  FOREIGN KEY (`categoria_id`) 
  REFERENCES `categorias` (`id`) 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE
) ENGINE=InnoDB

-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
INSERT INTO `usuarios` VALUES ('55064656','Claudia Marcela Duran','claudia@gmail.com',1),('550646767','Samcho Perez','sanchitocochinito@gmail.com',2),('107746767','Susana Olarte','susanitaxxx@gmail.com',3);


-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
INSERT INTO `categorias` VALUES ('Limpieza','Productos para mantener limpio el hogar'),('Comida','Comestibles frescos y empaquetados pai'),('Plasticos','Elementos extra');


-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
INSERT INTO `productos` VALUES ('001111',2300,30,1,'Fabuloso'),('001112',5000,9,2,'Pan Bimbo'),('001113',9800,10,2,'Libra de Cuajada'),('001114',3600,15,3,'Plástico para envolver');



-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
UPDATE productos
SET precio = 4000
WHERE codigo_barras = '001114'

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
UPDATE usuarios
SET activo = FALSE
WHERE documento = '107746767'

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
DELETE FROM productos 
WHERE id = 2;

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:

ALTER TABLE usuarios
ADD telefono VARCHAR (20) UNIQUE;

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).

-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:

/* El eliminar la categoría con el id=1 dejaría huérfanos a todo producto asociadoa dicha categoría en la tabla productos, por ende dicho comando sería bloqueado por la regla RESTRICT añadida en el CONSTRAINT botando el error.
  
Respuesta:
  
/*Error code 1451, cannot delete or update a parent row: a foreign key constraint fails.
