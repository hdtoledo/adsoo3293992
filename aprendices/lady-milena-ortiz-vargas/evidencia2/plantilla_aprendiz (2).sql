-- ==============================================================================
-- SENA | PROGRAMA ADSO - ANÁLISIS Y DESARROLLO DE SOFTWARE
-- SEMANA 1: NIVELACIÓN INTENSIVA DE FUNDAMENTOS
-- SESIÓN: Lunes 7 Sep | BD: Modelo Relacional y SQL DDL/DML desde Cero
-- TALLER PRÁCTICO EN CLASE (8:40 – 9:50 PM)
-- ==============================================================================
-- Nombre del Aprendiz: Lady Milena Ortiz Vargas
-- Número de Ficha:     3293992
-- Fecha:               9/09/2026
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
drop datase if exists taller_sistema_ventas_

-- [TODO 1.2]: Cree la base de datos 'taller_ventas_adso' con codificación UTF8MB4.
CREATE TABLE taller_ventas_adso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    rol ENUM('ADMIN', 'VENDEDOR', 'CLIENTE') DEFAULT 'CLIENTE',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- [TODO 1.3]: Ponga en uso la base de datos creada.


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
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- [TODO 2.2]: Crear la tabla 'categorias':
--   - id: Entero autoincremental, Llave primaria.
--   - nombre: Cadena hasta 60 caracteres, obligatorio y ÚNICO.
--   - descripcion: Texto o cadena descriptiva, opcional (puede ser NULL).
--   - activo: Booleano, por defecto TRUE.
TABLA: `categorias`
id: INT PK AUTO_INCREMENT
nombre: VARCHAR(60) NOT NULL UNIQUE
descripcion: VARCHAR(255) NULL
activo: BOOLEAN DEFAULT TRUE


-- [TODO 2.3]: Crear la tabla 'productos':
--   - id: Entero autoincremental, Llave primaria.
--   - codigo_barras: Cadena hasta 50 caracteres, obligatorio y ÚNICO.
--   - nombre: Cadena hasta 120 caracteres, obligatorio.
--   - precio: Decimal(10,2), obligatorio.
--   - stock: Entero, obligatorio, por defecto 0.
--   - categoria_id: Entero, obligatorio.
--   - RESTRICCIÓN FK: 'categoria_id' debe referenciar a 'id' de la tabla 'categorias'.
--                     Regla al eliminar: RESTRICT. Regla al actualizar: CASCADE.
TABLA: `productos`
id: INT PK AUTO_INCREMENT
codigo_barras: VARCHAR(50) NOT NULL UNIQUE
nombre: VARCHAR(120) NOT NULL
precio: DECIMAL(10, 2) NOT NULL
stock: INT DEFAULT 0
categoria_id: INT (FK)
creado_en: TIMESTAMP CURRENT_TIMESTAMP


-- ------------------------------------------------------------------------------
-- FASE 3: POBLAR LA BASE DE DATOS (DML)
-- ------------------------------------------------------------------------------

-- [TODO 3.1]: Inserte al menos 3 usuarios (1 ADMIN, 1 VENDEDOR, 1 CLIENTE).
INSERT INTO usuarios (nombre,telefono,correo, rol) VALUES
('juan`,`3112453242`,`juan@gmail.com`,`cliente')
INSERT INTO usuarios (nombre,telefono,correo, rol) VALUES
('maria`,`3112453242`,`maria@gmail.com`,`administrador')
INSERT INTO usuarios (nombre,telefono,correo, rol) VALUES
('sebas`,`3112453242`,`sebas@gmail.com`,`vendedor')
-- [TODO 3.2]: Inserte al menos 3 categorías (ej. Ferretería, Hogar, Calzado, etc.).
INSERT INTO categorias (nombre, descripcion) VALUES
('recipiente',`vidrio`)
INSERT INTO categorias (nombre, descripcion) VALUES
('electronica',`cables`)
INSERT INTO categorias (nombre, descripcion) VALUES
('tecnologia',`telefono`)

-- [TODO 3.3]: Inserte al menos 4 productos vinculados a categorías existentes.
INSERT INTO productos (codigo_barras, nombre, precio, stock, categoria_id) VALUES
('TECH-001', 'recipiente', 20000, 10, 2),
('TECH-002', 'electronica', 30000, 24, 3),
('TECH-003', 'tecnologia', 40000, 53, 4);
('TECH-004', 'papel', 20000, 10, 2)

-- ------------------------------------------------------------------------------
-- FASE 4: MANIPULACIÓN CON CLÁUSULA WHERE ESTRICTA (DML)
-- ------------------------------------------------------------------------------

-- [TODO 4.1]: Modifique el precio de un producto específico usando su código de barras en el WHERE.
UPDATE productos 
SET precio = 195000.00 
WHERE codigo_barras = 'TECH-001';

-- [TODO 4.2]: Cambie el estado de un usuario a inactivo (activo = FALSE) mediante su documento en el WHERE.
Update usuarios 
SET activo = FALSE
WHERE documento = ´1077553425´;

-- [TODO 4.3]: Elimine UN producto específico asegurando condición unívoca en el WHERE.
UPDATE productos 
SET precio = 195000.00 
WHERE codigo_barras = 'TECH-001';


-- ------------------------------------------------------------------------------
-- FASE 5: PREPARACIÓN PARA SUSTENTACIÓN (9:50 - 10:30 PM)
-- ------------------------------------------------------------------------------
-- PREGUNTA RETO 1:
-- ¿Cómo agrega con ALTER TABLE una columna 'telefono' de tipo VARCHAR(20) con restricción UNIQUE a usuarios?
-- Escriba la sentencia aquí:
  ALTER TABLE usuarios 
ADD COLUMN telefono VARCHAR(20) UNIQUE

-- PREGUNTA RETO 2:
-- Ejecute mentalmente o en consola: DELETE FROM categorias WHERE id = 1; (asumiendo que tiene productos vinculados).
-- ¿Qué error arroja el motor y por qué la base de datos se niega a borrarlo?
-- Escriba su respuesta técnica en este comentario:
/*DELETE FROM productos WHERE categoria_id=1; 
  Respuesta:
  
*/La base de datos no  permite borrar la categoria por la restricciones
