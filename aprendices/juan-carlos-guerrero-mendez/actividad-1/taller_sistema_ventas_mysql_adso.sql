DROP TABLE productos;

CREATE DATABASE IF NOT EXISTS taller_ventas_adso
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE taller_ventas_adso;

create table usuario(
	id int auto_increment primary key,
    documento int(20) not null unique,
    nombres varchar(100) not null,
    email varchar(120) not null unique,
    rol enum('ADMIN', 'VENDEDOR', 'CLIENTE') default 'CLIENTE',
    activo boolean NOT NULL default TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);
create table categorias(
	id int auto_increment primary key,
    nombre varchar(60) not null unique,
    descripcion varchar(255),
    activo boolean NOT NULL default TRUE
);
create table productos(
	id int auto_increment primary key,
    codigo_barras varchar(50) not null unique,
    nombre varchar(120) not null,
    precio decimal(10,2) not null unique,
    stock int not null default 0,
    
    categorias_id int not null,
    
    constraint fk_categorias_producto
		foreign key (categorias_id)
        references categorias(id)
        on update cascade
        on delete restrict
);

select * from usuario;
select * from categorias;
select * from productos;

insert into usuario (documento, nombres, email, rol) values (1235498728, 'Juan', 'juangabriel@gmail.com', 'ADMIN');
insert into usuario (documento, nombres, email, rol) values (1235498925, 'Pedro', 'PEDROSANCHEZ@gmail.com', 'VENDEDOR');
insert into usuario (documento, nombres, email, rol) values (1233498738, 'Bendito', 'GUERRILATC@gmail.com', 'cliente');

insert into categorias (nombre, descripcion) values ('Ferreteria', 'venta de herramientas');
insert into categorias (nombre, descripcion) values ('Calzado', 'venta de zapatos');
insert into categorias (nombre, descripcion) values ('Juegos', '');

insert into productos (codigo_barras, nombre, precio, stock, categorias_id) values ('6576hvghc7dsd78', 'Zapatos CR7', '7000', '777', 2 );
insert into productos (codigo_barras, nombre, precio, stock, categorias_id) values ('457sdvsf76sd7f8', 'clavos invisibles', '670', '607', 1 );
insert into productos (codigo_barras, nombre, precio, stock, categorias_id) values ('S54G5SDFSA665D6', 'GTA 6 DEMO', '1000', '180', 3 );
insert into productos (codigo_barras, nombre, precio, stock, categorias_id) values ('fgd46gk565kme66', 'Minecraft', '1605.56', '351', 3 );

UPDATE productos SET precio = 667.00 WHERE codigo_barras = 'S54G5SDFSA665D6';
UPDATE usuario SET activo = false WHERE documento = '1235498925';
DELETE FROM productos WHERE id = 2 ;

ALTER TABLE usuario ADD COLUMN telefonos VARCHAR(20) UNIQUE;

DELETE FROM categorias WHERE id = 1;





