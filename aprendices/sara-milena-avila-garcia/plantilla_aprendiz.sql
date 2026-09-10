-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Sara Milena Avila Garcia__________________________________
-- Número de Ficha: 3293992  _____________________________________________________
-- Fecha:              9 de Septiembre
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
create database IF NOT EXISTS taller_ventas_adso
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

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
    activo BOOLEAN NOT NULL DEFAULT TRUE (1),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(60) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NULL,
    activo BOOLEAN, DEFAULT TRUE
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
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    
     CONSTRAINT fk_productos_categorias
        FOREIGN KEY (categoria_id) 
        REFERENCES categorias(id)
        ON UPDATE CASCADE      
        ON DELETE RESTRICT
CONSTRAINT chk_precio_positivo CHECK (precio >= 0),
    CONSTRAINT chk_stock_positivo CHECK (stock >= 0)
) ENGINE=InnoDB;


-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
INSERT INTO usuarios (documento, nombres, email, rol,) VALUES
('1077851234', 'sara', 'sara@gmail.com', 'ADMIN', ),
('1077851235', 'valeria', 'valeria@gmail.com', 'VENDEDOR'),
('1077851236', 'ana', 'ana@gmail.com', 'CLIENTE');

-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
INSERT INTO categorias (nombres, descripcion) VALUES
('Tecnología', 'Dispositivos electrónicos y periféricos'),
('Papelería', 'Útiles de oficina y cuadernos')
('peluche', 'suave y lindo para un ragalo');

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
INSERT INTO productos (codigo_barras, nombre, precio, stock, categoria_id) VALUES
('TECH-001', 'Teclado Mecánico RGB', 185000.00, 15, 1),
('TECH-002', 'Teclado Mecánico', 185000.00, 15, 1),
('TECH-003', 'Mouse Ergonómico', 75000.00, 25, 1),
('PAP-001', 'Resma de Papel Carta', 24000.00, 50, 2);


-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
update productos
set precio = 200000.00
where codigo_barras = 'TECH-001';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
update usuarios
set activo = FALSE
where documento = '1077851234';

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
delete from productos
where codigo_barras = 'TECH-002';


-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:


-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*
  Respuesta:
  
*/
