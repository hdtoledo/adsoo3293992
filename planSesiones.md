
##  Distribución Curricular Sesión por Sesión (40 Sesiones)

### Semana 1: Nivelación Intensiva de Fundamentos
- **Sesión 01 | Día 1 | BD:** Modelo Relacional y SQL DDL/DML. Entidades, PK/FK, `CREATE TABLE`, tipos de datos, restricciones (`NOT NULL`, `UNIQUE`), inserción y borrado condicional (`INSERT`, `UPDATE`, `DELETE WHERE`).
- **Sesión 02 | Día 2 | BD:** Consultas SQL y Cruce de Tablas. Filtros avanzados (`WHERE`, `LIKE`, `IN`), agregaciones (`COUNT`, `SUM`, `GROUP BY`) y diferencias operativas entre `INNER JOIN` y `LEFT JOIN`.
- **Sesión 03 | Día 3 | Backend I:** JavaScript Moderno (ES6+) y Asincronía. `const`/`let`, inmutabilidad, desestructuración, spread operator, métodos de arrays (`map`, `filter`, `find`, `reduce`), Event Loop y `async/await` con `try...catch`.
- **Sesión 04 | Día 4 | Backend II:** Protocolo HTTP y Servidor Base en Node.js/Express. Headers, verbos HTTP, status codes (2xx, 4xx, 5xx), inicialización con `type: module`, captura de `req.body`, `req.params`, `req.query` y middleware `express.json()`.
- **Sesión 05 | Día 5 | Frontend II:** Consumo con Fetch API y Manipulación del DOM. Métodos Fetch, headers `application/json`, parsing de respuestas, prevención de recarga (`e.preventDefault()`) y renderizado dinámico en cliente.

### Semana 2: Arquitectura Backend en Capas y React Base
- **Sesión 06 | Día 06 | BD:** Integridad Referencial y Reglas de Borrado. `ON DELETE CASCADE` vs `RESTRICT`, llaves compuestas y transacciones básicas (`COMMIT`, `ROLLBACK`).
- **Sesión 07 | Día 07 | Backend I:** Arquitectura en Capas en Express. Separación estricta de rutas (`routes/`) y controladores (`controllers/`).
- **Sesión 08 | Día 08 | Backend II:** Conexión de Node.js a BD Relacional. Pools de conexión (`mysql2` o `pg`), queries parametrizadas y variables de entorno con `dotenv` (`.env`).
- **Sesión 09 | Día 09 | Frontend I:** Introducción a Vite + React. Estructura de carpetas, sintaxis JSX, paso de `props` y composición de componentes reutilizables.
- **Sesión 10 | Día 10 | Frontend II:** Maquetación con Tailwind CSS Mobile-First. Flexbox, Grid, breakpoints responsivos (`sm:`, `md:`, `lg:`) y diseño adaptativo sin CSS tradicional.

### Semana 3: Persistencia SQL Completa y Estado en React
- **Sesión 11 | Día 11 | BD:** Normalización Práctica (1FN a 3FN). Identificación de anomalías, eliminación de redundancias y modelado para proyectos formativos.
- **Sesión 12 | Día 12 | Backend I:** CRUD en Express + SQL (Parte 1). Endpoints `POST` (crear registro) y `GET` (listar todos y filtrar por ID).
- **Sesión 13 | Día 13 | Backend II:** CRUD en Express + SQL (Parte 2). Endpoints `PUT` (actualización) y `DELETE` (borrado físico vs lógico con bandera `is_active`).
- **Sesión 14 | Día 14 | Frontend I:** Manejo de Estado con `useState`. Estado primitivo y complejo (arrays/objetos), eventos `onClick`/`onChange` y formularios controlados.
- **Sesión 15 | Día 15 | Frontend II:** Ciclo de Vida y `useEffect`. Sincronización, dependencias estrictas, prevención de loops infinitos y llamadas iniciales.

### Semana 4: Transición a MongoDB, NoSQL y Conexión Frontend-Backend
- **Sesión 16 | Día 16 | BD:** Paradigma NoSQL. Tablas vs Colecciones, Filas vs Documentos BSON. Configuración de clúster en MongoDB Atlas y MongoDB Compass.
- **Sesión 17 | Día 17 | Backend I:** Mongoose ODM. Cadena de conexión URI, esquemas (`Schema`), tipos de datos y validaciones requeridas de modelo.
- **Sesión 18 | Día 18 | Backend II:** CRUD REST con Mongoose. Métodos `.find()`, `.findById()`, `.create()`, `.findByIdAndUpdate()`, `.findByIdAndDelete()`.
- **Sesión 19 | Día 19 | Frontend I:** Consumo de la API Express desde React. Integración de llamadas asíncronas con `fetch`/`axios` dentro de `useEffect` y manejo de loading/error.
- **Sesión 20 | Día 20 | Frontend II:** Formularios de Mutación e Inmutabilidad. Envíos `POST` y `DELETE` desde la UI con actualización reactiva del estado visual.

### Semana 5: Relaciones NoSQL, Validaciones y Enrutamiento SPA
- **Sesión 21 | Día 21 | BD:** Relaciones en MongoDB. Documentos embebidos (subdocumentos) vs referencias con `ObjectId`.
- **Sesión 22 | Día 22 | Backend I:** Consultas con Referencias en Mongoose. Uso de `.populate()`, selección de campos y paginación con `.skip()` y `.limit()`.
- **Sesión 23 | Día 23 | Backend II:** Middlewares de Validación y Control de Errores. Sanitización de datos, validación antes del controlador y respuestas uniformes de error en JSON.
- **Sesión 24 | Día 24 | Frontend I:** Enrutamiento SPA con `react-router-dom`. `BrowserRouter`, `Routes`, `Route`, `Link` y barras de navegación con estado activo.
- **Sesión 25 | Día 25 | Frontend II:** Parámetros Dinámicos y Navegación Programática. `useParams` y `useNavigate` para pantallas de detalle y edición (`/recurso/:id`).

### Semana 6: Autenticación, Seguridad y Estado Global
- **Sesión 26 | Día 26 | BD:** Modelado Seguro de Usuarios. Esquema con roles (`admin`/`user`), estados, timestamps y campos de control.
- **Sesión 27 | Día 27 | Backend I:** Hashing de Contraseñas con `bcryptjs`. Salt rounds, registro seguro y verificación de contraseñas en login.
- **Sesión 28 | Día 28 | Backend II:** Autenticación Stateless con JWT (`jsonwebtoken`). Firma de tokens, expiración y middleware de protección `verifyToken`.
- **Sesión 29 | Día 29 | Frontend I:** Estado Global con React Context API. Implementación de `AuthContext` para almacenar credenciales, token y estado de sesión con `localStorage`.
- **Sesión 30 | Día 30 | Frontend II:** Rutas Protegidas en React. Componente `<ProtectedRoute />` para redireccionar accesos no autorizados al login.

### Semana 7: Sprint de Proyectos Formativos SENA
- **Sesión 31 | Día 31 | BD:** Optimización de Esquemas de Proyecto. Creación de índices, revisión de integridad y carga de datos iniciales (*seeds*).
- **Sesión 32 | Día 32 | Backend I:** Lógica de Negocio Específica. Filtros avanzados, cálculos y endpoints propios del proyecto de cada equipo.
- **Sesión 33 | Día 33 | Backend II:** Cierre y Pruebas del Backend. Control de CORS para cliente local y exportación de colección de pruebas.
- **Sesión 34 | Día 34 | Frontend I:** Maquetación del Dashboard de Proyecto con Tailwind CSS. Vistas administrativas responsivas y tablas de gestión de datos.
- **Sesión 35 | Día 35 | Frontend II:** Integración Total Frontend-Backend. Conexión de flujos completos (Auth + CRUD) con retroalimentación visual (loaders y toasts).

### Semana 8: Despliegue en la Nube y Sustentación Final
- **Sesión 36 | Día 36 | DevOps/BD:** Base de Datos en Producción. Configuración de Network Access en MongoDB Atlas, whitelist de IPs y credenciales definitivas.
- **Sesión 37 | Día 37 | DevOps/Back:** Despliegue del Backend en Railway. Variables de entorno en producción (`PORT`, `MONGO_URI`, `JWT_SECRET`), script `npm start` y verificación HTTPS.
- **Sesión 38 | Día 38 | DevOps/Front:** Build de Producción en Vite. Optimización con `npm run build`, depuración de dependencias y configuración de `vercel.json` para rutas SPA.
- **Sesión 39 | Día 39 | DevOps/Full:** Despliegue del Frontend en Vercel. Vinculación con GitHub, inyección de `VITE_API_URL` y prueba end-to-end entre Vercel y Railway.
- **Sesión 40 | Día 40 | Cierre:** Jornada de Sustentación Técnica Individual SENA. Demostración en vivo en producción y examen de modificación de código en caliente sin IA.
