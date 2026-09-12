-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: ________________________________________________________
-- Número de Ficha:     ________________________________________________________
-- Fecha:               7 de Septiembre
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


-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.

CREATE DATABASE IF NOT EXISTS taller_ventas_adso
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- [TODO 1.3]: Ponga en uso la base de datos creada.

USE taller_ventas_adso;

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


CREATE TABLE usuarios (
	id INT PRIMARY KEY auto_increment,
  documento VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    rol ENUM('ADMIN', 'VENDEDOR', 'CLIENTE') DEFAULT 'CLIENTE',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.

CREATE TABLE categorias (
	id INT PRIMARY KEY auto_increment,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    activo BOOLEAN DEFAULT TRUE
);

-- [TODO 2.3]: Crear la tabla 'productos':
--   - id: Entero autoincremental, Llave primaria.
--   - codigo_barras: Cadena hasta 50 caracteres, obligatorio y ÚNICO.
--   - nombre: Cadena hasta 120 caracteres, obligatorio.
--   - precio: Decimal(10,2), obligatorio.
--   - stock: Entero, obligatorio, por defecto 0.
--   - categoria_id: Entero, obligatorio.
--   - RESTRICCIÓN FK: 'categoria_id' debe referenciar a 'id' de la tabla 'categorias'.
--                     Regla al eliminar: RESTRICT. Regla al actualizar: CASCADE.

CREATE TABLE productos (
	id INT PRIMARY KEY auto_increment,
	codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (categoria_id) 
        REFERENCES categorias(id)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).

INSERT INTO usuarios(documento, nombre, email, rol, activo) VALUES
('1077857944', 'Jesus Erney Lagos', 'jesuserneylagoscollazos@gmail.com', 'ADMIN', 1),
('1077956833', 'Tomas Sebastian Albert', 'tomassebastianalbert@gmail.com', 'CLIENTE', 1),
('1077549322', 'Samuel Carlos Alejandro Villa', 'samuelcarlosalejandrovilla@gmail.com', 'VENDEDOR', 0)

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).

INSERT INTO categorias(nombre, descripcion, activo) VALUES
('Hamburguesa', 'Rica hamburguesa con los mas calidosos ingredientes, hecha en casa!', 1),
('Pizza', 'Esta pizza es la mejor de todo el mundo, pruebala y compruebalo', 1),
('Salchipapa', 'Salchipapa hecha con salchicha y papa', 0)

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.

INSERT INTO productos(codigo_barras, nombre, precio, stock, categoria_id) VALUES
('7701234567891', 'Pan', 100.0, 3, 1),
('7763524347891', 'Pepinillo', 50.0, 10, 1),
('7701622344391', 'Piña', 200.0, 4, 2),
('7662343433433', 'Salchicha', 40.0, 15, 3)

-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.

UPDATE productos
SET precio = 200.0
WHERE codigo_barras = '7701234567891';


-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.

UPDATE usuarios
SET activo = FALSE
WHERE documento = '1077956833'

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.

DELETE FROM productos
WHERE id = 1

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:

ALTER TABLE usuarios 
ADD telefono VARCHAR(20) UNIQUE

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta:
  
  //
    Surge el error debido a una resticcion tipo RESTRICT que se realizo al hacer la relacion en la secuencia sql anteriormente,
    esta restriccion evita que se eliminen datos que ya tienen una relación.
    En un caso de eliminacion quedaria huerfanos y no tendrian una referencia valida, eso es lo que se evita.
  //

*/
