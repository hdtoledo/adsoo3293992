-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Miercoles 8 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Sebastian Calderon Santana
-- Número de Ficha:     3293992
-- Fecha:               9 de Septiembre
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
DROP DATABASE taller_ventas_adso;


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
create table usuario(
	id int auto_increment primary key,
    documento int(20) not null unique,
    nombres varchar(100) not null,
    email varchar(120) not null unique,
    rol enum('ADMIN', 'VENDEDOR', 'CLIENTE') default 'CLIENTE',
    activo boolean NOT NULL default TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);


-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
create table categorias(
	id int auto_increment primary key,
    nombre varchar(60) not null unique,
    descripcion varchar(255),
    activo boolean NOT NULL default TRUE
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
create table productos(
	id int auto_increment primary key,
    codigo_barras varchar(50) not null unique,
    nombre varchar(120) not null,
    precio decimal(10,2) not null unique,
    stock int not null default 0,
    
    categoria_id int not null,
    
    constraint fk_categoria_producto
		foreign key (categoria_id)
        references categorias(id)
        on update cascade
        on delete restrict
);


-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
insert into usuario (documento, nombres, email, rol) values (1077854199, 'yisus cadenas' 'yisus@gmail.com', 'CLIENTE');
insert into usuario (documento, nombres, email, rol) values (1077854196, 'tomas sarmiento', 'tomas@gmail.com', 'VENDEDOR');
insert into usuario (documento, nombres, email, rol) values (1077854189, 'guerrero sarmiento', 'guerrero@gmail.com', 'ADMIN');

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
insert into categorias (nombre, descripcion) values ('celulares', 'dispositivos moviles');
insert into categorias (nombre, descripcion) values ('audifonos', 'dispositivos de audio inalambricos');
insert into categorias (nombre, descripcion) values ('relojes inteligentes', 'relojes digital inteligentes');

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
insert into productos (codigo_barras, nombre, precio, stock, categoria_id) values ('6576hvghc7dsd78', 'Poco X7 Pro', '1400000', '14', '1' );
insert into productos (codigo_barras, nombre, precio, stock, categoria_id) values ('457sdvsf76sd7f8', 'soundcore p20i', '120000', '6', '2' );
insert into productos (codigo_barras, nombre, precio, stock, categoria_id) values ('S54G5SDFSA665D6', 'Google Pixel Watch 4', '3000000', '4', '3' );
insert into productos (codigo_barras, nombre, precio, stock, categoria_id) values ('fgd46gk565kme66', 'soundcore liberty 4 NC', '500000', '8', '2' );



-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
UPDATE productos SET precio = 3200000 WHERE codigo_barras = 'S54G5SDFSA665D6';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
UPDATE usuarios SET activo = false WHERE documento = '1077854199';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
DELETE FROM productos WHERE id = 2 ;


-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:
ALTER TABLE usuarios ADD "telefono" VARCHAR(20) UNIQUE
/*
  Respuesta:
    esta sentencia se utiliza para seleccionar (ALTER TABLE) la tabla (usuarios) se le agregar una columna (ADD telefono) y un varchar de 20 caracteres (VARCHAR) unico (UNIQUE)
  
*/

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta: el motor arroja un codigo de error 1451
    porque se le agrego una restriccion de borrar la tabla si tiene un producto vinculado
  no deja borrarlo ya que la categorias ya esta vinculado a unos productos 
*/
