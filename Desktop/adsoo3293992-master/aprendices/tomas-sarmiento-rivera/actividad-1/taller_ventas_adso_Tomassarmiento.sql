-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: _Tomas Sarmiento Rivera_______________________________________________________
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

-- [TODO 1.1]: Escriba la sentencia para eliminar la base de datos '
drop database taller_ventas_adso


-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.
create database if not exists taller_ventas_adso
character set utf8mb4
collate utf8mb4_unicode_ci;

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
create table usuarios (
id int auto_increment primary key,
documento varchar(20) not null unique,
nombre varchar(100) not null,
email varchar (100) not null unique,
rol enum('ADMIN' , 'VENDEDOR' , 'CLIENTE') default 'Cliente',
activo boolean null default true,
creado_en timestamp default current_timestamp)



-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
create table categorias (
id int auto_increment primary key,
nombre varchar (60) not null unique,
descripcion varchar (1000) null,
activo boolean default true
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
id int auto_increment primary key,
codigo_barras varchar (50) not null unique,
nombre varchar (120) not null,
precio decimal (10,2) not null,
stock int not null default 0,
categoria_id int not null,

constraint fk_categorias_productos
foreign key (categoria_id)
references categorias(id)
on update cascade
on delete restrict
);


-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
insert into usuarios (documento,nombre,email,rol) values ('123456', 'Tomass.r' , 'tomasssrr@gmai.com' , 'ADMIN');
insert into usuarios (documento,nombre,email,rol) values ('234567', 'Sarap.t' , 'saraaaa@gmai.com' , 'VENDEDOR');
insert into usuarios (documento,nombre,email,rol) values ('876543', 'Pepeq.j' , 'peeeepe@gmai.com' , 'CLIENTE');


-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
insert into categorias (nombre,descripcion) values ('celulares', 'util para el tranbajo' );
insert into categorias (nombre,descripcion) values ('computador', 'util para el comunicacion' );
insert into categorias (nombre,descripcion) values ('audifonos', 'disfrutar musica' );


-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.

insert into productos (codigo_barras,nombre,precio,stock,categoria_id) values ('121314', 'poco f7', '2000000', '15', '1');
insert into productos (codigo_barras,nombre,precio,stock,categoria_id) values ('674539', 's24', '4000000', '15', '1');
insert into productos (codigo_barras,nombre,precio,stock,categoria_id) values ('456895', 'legion 5', '8000000', '15', '2');
insert into productos (codigo_barras,nombre,precio,stock,categoria_id) values ('109864', 'airpod', '20000', '15', '3');

-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
update productos set precio = 1800000 where codigo_barras = '121314'

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
update usuarios set activo = false where documento = '234567';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.

delete from productos where codigo_barras = '674539'

-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí: ALERT TABLE usuario ADD COLUMN telefonos VARCHAR (20) UNIQUE

--

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta: porque la base de datos protege la integridad referencial, entonces no permite eliminar categorias porque existen productos que que dependen de ellas
  
*/
