-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: _______Yilver Arlex Jovel Angarita____________________
-- Número de Ficha:     ___________________3293992_____________________________
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

create database if not exists taller_ventas_adso


-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.

	character set utf8mb4
	collate utf8mb4_unicode_ci

-- [TODO 1.3]: Ponga en uso la base de datos creada.

use taller_ventas_adso

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

CREATE table usuarios(
	id_usuario int primary key auto_increment,
	documento varchar(20) not null UNIQUE,
	nombre varchar(100) not null,
	email varchar(100) not null UNIQUE,
	rol enum("ADMIN", "VENDEDOR", "CLIENTE") default "CLIENTE",
	activo boolean not null default true,
	creado_en timestamp default current_timestamp
)



-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.

create table categorias(
	id_categoria int primary key auto_increment,
	nombre varchar(60) not null UNIQUE,
	descripcion varchar(200),
	activo boolean default true
)


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
	id_producto int PRIMARY key auto_increment,
	codigo_barras varchar(50) not null UNIQUE,
  nombre varchar(120) not null
	precio decimal(10, 2) not null,
	stock int not null default 0,
	id_categoria int not null,
	
	constraint fk_producto_categoria
		foreign key (id_categoria) references categorias(id_categoria) on update cascade on delete restrict
)



-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).

insert into usuarios(documento, nombre, email, rol) VALUES (10778673, "Pepito", "pepito@gmail.com", "ADMIN");

insert into usuarios(documento, nombre, email, rol) VALUES (1077238673, "Jose", "jose@gmail.com", "VENDEDOR"), (17798993, "Ricardo", "ricarodo@gmail.com", "Vendedor");

insert into usuarios(documento, nombre, email, rol) VALUES (19223, "jefer", "cliente@gmail.com", "CLIENTE");

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).

insert into categorias (nombre, descripcion, activo) VALUES ("Deporte", "Ropa deportiva", true), ("Tecnologia", "Laptops tope de gama", true), ("Papeleria", "Los mejor para estudiar", false)


-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.

insert INTO  productos(codigo_barras, precio, stock, id_categoria, nombre) values("13f23rg", 2000, 2, 2, "Lenovo id33"), ("13f22323233rg", 1000, 2, 1, "SIft"), ("323233fds32", 500, 90, 1, "Altavoz alta calidad")

-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.

update productos set precio = 1000 where codigo_barras = 323233fds32


-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.

update usuarios set activo = false WHERE documento  = 17798993

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.

delete from productos where id_categoria = 1

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:

alter table usuarios
add column telefono varchar(20) UNIQUE

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta:
  no dejara eliminarlo porque se le puso esa barrera con el constrinc poniendole el on delete restrict haciendo que si una talba que estee vinculao este existiendo todavia no se pueda borrar
*/
