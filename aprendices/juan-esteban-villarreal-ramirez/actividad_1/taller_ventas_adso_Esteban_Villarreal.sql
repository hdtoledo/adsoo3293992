-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Juan esteban Villarreal Ramirez
-- Número de Ficha:     3293992
-- Fecha:               09 de Septiembre
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

create database taller_ventas_adso
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- [TODO 1.3]: Ponga en uso la base de datos creada.

use taller_ventas_adso;

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
	id_usuario int auto_increment primary key,
    documento varchar(20) not null,
    nombre varchar(100) not null,
    email varchar(120) not null unique,
    rol ENUM('ADMIN', 'VENDEDOR', 'CLIENTE') DEFAULT 'CLIENTE',
    activo boolean not null default true,
    creado timestamp default current_timestamp
)ENGINE=InnoDB;

-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.

create table categorias (
	id_categoria int auto_increment primary key,
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
	id_producto int auto_increment primary key,
    codigo_barras varchar(50) not null unique,
    nombre varchar(120) not null,
    precio decimal(10,2) not null,
    stock int not null default 0,
    id_categorias int not null,
		constraint fk_productos_categorias
        foreign key (id_categorias)
        references categorias(id_categoria)
        on update cascade
        on delete restrict
)ENGINE=InnoDB;

-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).

insert into usuarios (rol, documento, nombre, email, activo)
values ('ADMIN', 1036587412, 'Esteban Villarreal', 'esteban123@gmail.com', 1);

insert into usuarios (rol, documento, nombre, email, activo)
values ('VENDEDOR', 1078965412, 'Hector Toledo', 'hector123@gmail.com', 1);

insert into usuarios (rol, documento, nombre, email, activo)
values ('CLIENTE', 1086541235, 'Sara Guzman', 'sara123@gmail.com', 1)


-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).

INSERT INTO categorias (nombre, descripcion) 
VALUES ('Tecnología', 'Dispositivos electrónicos y periféricos');

INSERT INTO categorias (nombre, descripcion) 
VALUES ('frutas', 'Camida dulce y agridulce');

INSERT INTO categorias (nombre, descripcion) 
VALUES ('Dulces', 'Comida azucara, dulce y agridulce')

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.

INSERT INTO productos (codigo_barras, nombre, precio, stock, id_categorias) 
VALUES ('TECH-001', 'Luces RGB - 1 metro', 10000.00, 15, 1),
('TECH-002', 'Audifono', 75000.00, 25, 1),
('COMI-002', 'Mango 1LB', 5000.00, 25, 2),
('DUL-001', 'Quipitos', 1000.00, 50, 3);


-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.

UPDATE productos 
SET precio = '4000.00' 
WHERE codigo_barras = 'COMI-002';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.

UPDATE usuarios 
SET activo = FALSE 
WHERE documento = '1086541235';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.

delete from productos
where codigo_barras = 'DUL-001';

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
  Respuesta: Al intentar borrar una categoria especifica (id_categorias = 1) MYSQL no lo dejaria porque hay una llave foranea que está conectada a ella,
  lo que haria que la referencias que usan los datos sean afectadas, como existen datos en esa categoria MYSQL evita que sea borrada, ya que al borrarse la categoria los
  productos quedarian sin una conexion.
*/
