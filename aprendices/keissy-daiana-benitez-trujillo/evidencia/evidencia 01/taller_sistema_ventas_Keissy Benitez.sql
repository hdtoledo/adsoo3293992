-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Keissy Diana Benitez Trujillo
-- Número de Ficha:     3293992
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
DROP DATABASE IF EXISTS taller_ventas_adso;

-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.
CREATE DATABASE taller_ventas_adso 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;

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
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    rol ENUM('ADMIN', 'VENDEDOR', 'CLIENTE') DEFAULT 'CLIENTE',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
create table categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    descripcion TEXT,
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
create table productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,

    CONSTRAINT fk_productos_categorias
    FOREIGN KEY (categoria_id) 
    REFERENCES categorias(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

    CONSTRAINT chk_precio_positivo CHECK (precio >= 0),
    CONSTRAINT chk_stock_positivo CHECK (stock >= 0)
) ENGINE=InnoDB;



-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
insert into usuarios (documento, nombres, email, rol,activo) values
('1012364384', 'Keissy Benitez', 'keissybenitez@gmail.com', 'ADMIN',1),
('1013245748', 'juan jimenez', 'juanjimenez@gmail.com', 'VENDEDOR',1),
('1012345748', 'Kennethe Benitez', 'kennethbenitez@gmail.com', 'CLIENTE',2);

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
insert into categorias (nombre, descripcion, activo) values
('Ferretería', 'Dos tornillos, un martillo ycinta metrica',1),
('Hogar', 'armario,un sofa cama y un comedor',2),
('Calzado', 'dos parede de tacones talla 5, un par de sapatos deportivos',1);

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
insert into productos (id, codigo_barras, nombre, precio, stock, categoria_id) values
(1, 'TECH-001', 'ferreteria-cinta metrica', 12500.00.00, 45, 1),
(2, 'TECH-002', 'hogar comedor', 75000.00, 35, 2),
(3, 'PAP-001', 'calzado- tacones', 24000.00, 50, 3),
(4, 'PAP-002', 'calzado- tenis deportivos', 195000.00, 45, 3);


-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
update productos
set precio = 15000.00 
where codigo_barras = 'TECH-001';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
update usuarios
set activo = FALSE
where documento = '1012345748';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
delete from productos
where codigo_barras = 'TECH-001';

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:Para agregar una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a la tabla 'usuarios', se puede utilizar la siguiente sentencia SQL:
ALTER TABLE usuarios ADD COLUMN telefono VARCHAR(20) UNIQUE;

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta: El error q arrija el motor (es error cade 1415)  es por que se esta intentando eliminar una categoria  que tiene productos vinculados o q se estan usando a ella, y debido a la restricción de clave foránea (FOREIGN KEY) establecida en la tabla 'productos'(ON DELETE RESTRICT), la base de datos no permite la eliminación de la categoría ya q ocacionaria q los datos queden huerganos . La regla de eliminación RESTRICT impide que se borre un registro si existen registros dependientes en otras tablas.
  
*/
