-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: _Johan Andres Collazos Cardona_______________________________________________________
-- Número de Ficha:     _3293992_______________________________________________________
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


-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.
CREATE DATABASE IF NOT EXISTS sistema_ventas_db_johan
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- [TODO 1.3]: Ponga en uso la base de datos creada.
USE sistema_ventas_db_johan;

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
create table usuarios (
id int auto_increment primary key,
documento varchar(20) not null unique,
nombres varchar(100) not null,
email varchar(120) not null unique,
rol enum('ADMIN', 'VENDEDOR', 'CLIENTE') default 'CLIENTE',
activo boolean not null default true,
creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
create table categorias (
	id int auto_increment primary key,
    nombre varchar(60) not null,
    descripcion text,
    activo boolean not null default true
)ENGINE=InnoDB;

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
id int auto_increment primary key,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (categoria_id) 
        REFERENCES categorias(id)
        ON UPDATE CASCADE      
        ON DELETE RESTRICT,   
        
    CONSTRAINT chk_precio_positivo CHECK (precio >= 0),
    CONSTRAINT chk_stock_positivo CHECK (stock >= 0)
) ENGINE=InnoDB;

-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
insert into usuarios (rol, documento, nombre, email, activo)
values ('ADMIN', 1076345255, 'Johan Collazos', 'johancc@gmail.com', 1);

insert into usuarios (rol, documento, nombre, email, activo)
values ('VENDEDOR', 1073652387, 'Manuel Segura', 'manuelsegura@gmail.com', 1);

insert into usuarios (rol, documento, nombre, email, activo)
values ('CLIENTE', 1053256723, 'Andres Camilo', 'andres12@gmail.com', 1)

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
INSERT INTO categorias (nombre, descripcion) VALUES
('comida', 'comidas raṕidas'),
('oficina', 'venta de objetos de oficina')
('tecnologia', 'equipos tecnologicos');

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
INSERT INTO productos (codigo_barras, nombre, precio, stock, categoria_id) 
VALUES ('COMI-001', 'perro caliente', 7000.00, 23, 1),
('TECH-001', 'bocina', 75000.00, 34, 5),
('OFIC-001', 'lapiceros', 2000.00, 16, 2),
('COMI-002', 'hamburguesa', 10000.00, 40, 1);

-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
UPDATE productos 
SET precio = '15000.00' 
WHERE codigo_barras = 'COMI-002';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
UPDATE usuarios
SET activo = false 
WHERE documento = '1076345255';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
delete from productos
where codigo_barras = 'COMI-001';

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:
alter table usuarios
add column telefono varchar(20) unique;

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta:Respuesta: Al intentar borrar una categoria especifica (categorias_id = 1) MYSQL no lo dejaria porque hay una llave foranea que está conectada a ella,
  lo que haria que la referencias que usan los datos sean afectadas, como existen datos en esa categoria MYSQL evita que sea borrada, ya que al borrarse la categoria los
  productos quedarian sin una conexion.
*/
