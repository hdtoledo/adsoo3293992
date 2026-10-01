-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: ________jose Alejandro Rodriguez________________________________________________
-- Número de Ficha:     _________________3293992_______________________________________
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
    create database if not exists taller_ventas_adso
    character set utf8mb4
    collate utf8mb4_unicode_ci;

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
create table usuario (
id int auto_increment primary key,
document varchar(20) not null unique,
nombre varchar(100) not null,
email varchar(120) not null unique,
rol enum('ADMIN', 'VENDEDOR', 'CLIENTE') default 'CLIENTE',
activo boolean not null default true,
creado_em timestamp default current_timestamp
)




-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
create table categorias (
id int auto_increment primary key,
nombre varchar(60) not null unique,
descripcion varchar(200) null,
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
create table productos (
id int auto_increment primary key,
codigo_barras varchar(50) not null unique,
nombre varchar(120) not null,
precio decimal(10,2) not null,
stock int not null default 0,
categoria_id int not null,
categoria_en timestamp default current_timestamp,

constraint fk_productos_categorias
foreign key (categori_id)
references categoria (id)

on update cascade
on delete restrict,

constraint chk_precio_positivo check (precio >=0),
constraint chk_stock_positivo check (stock >=0)
)



-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
insert into usuario (document, nombre, email, rol, activo)
values("1548321970","Camila", "camila020@gmail.com","ADMIN", TRUE),
("1125795430","sara", "sara25@gmail.com","vendedor", TRUE),
("1265486413","danna", "danna15@gmail.com","cliente", TRUE)

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
insert into categorias (descripcion, nombre)
values("ropa a la mejor calidad","nike"),
("pizza lo mejor de lo mejor","comida"),
("lleve su mueble 2*1","comercio")

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
insert into productos  (codigo_barras, nombre, precio, stock, categoria_id)
values("asdg5yh56y", "espaguetis", 10.2, 21, 2),
("2345kng", "camisa", 20.0, 12, 1),
("21341234", "basecama", 40, 3, 3),
("235235235", "blusa", 10.0,  21 , 1)


-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
use taller_ventas_adso;
update productos set precio = 43 where codigo_barras = "21341234"; select * from productos

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
use taller_ventas_adso;
update usuario set activo = false where document = "1265486413";
select * from usuario

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
use taller_ventas_adso;
delete from productos where codigo_barras = "asdg5yh56y"


-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:
alter table usuario
add column telefono varchar(20) unique

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta:
  la base de datos no se elimina porque porque el constraint pone una barrera que no se puede eliminar porque sigue binculado otras tablas gracias a su on delete restring que esta balidando con el contraint
*/
