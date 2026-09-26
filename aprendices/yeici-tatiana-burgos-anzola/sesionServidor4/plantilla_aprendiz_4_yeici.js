/**
 * =============================================================================
 * SENA - CENTRO AGROEMPRESARIAL Y DESARROLLO PECUARIO DEL HUILA (GARZÓN)
 * PROGRAMA: ANÁLISIS Y DESARROLLO DE SOFTWARE (ADSO)
 * FORMACIÓN: NIVELACIÓN TÉCNICA FULL STACK MERN + SQL
 * SESIÓN 04 | DÍA 4: PROTOCOLO HTTP Y SERVIDOR BASE EN EXPRESS
 * =============================================================================
 * ARCHIVO: plantilla_servidor.js
 * INSTRUCTOR: Ing. Hector David Toledo Garcia
 * INSTRUCCIONES:
 * 1. Asegúrate de instalar dependencias primero con: npm install
 * 2. Inicia tu servidor en la terminal con: npm start (o node plantilla_servidor.js)
 * 3. Resuelve cada uno de los 6 Retos Progresivos completando los bloques // TODO:.
 * 4. Prueba cada endpoint creando y configurando manualmente tus peticiones en BRUNO
 *    (método, URL, query params, headers y body JSON) siguiendo la guía de clase.
 * 5. También puedes ejecutar la suite de pruebas automatizada con: npm run test:api
 * =============================================================================
 */

import express from 'express';

// =============================================================================
// RETO 1: INICIALIZACIÓN DE EXPRESS, PUERTO Y MIDDLEWARE JSON
// =============================================================================
/**
 * OBJETIVO:
 * 1. Crea la instancia de la aplicación Express (`const app = express()`).
 * 2. Define el puerto usando variables de entorno o el puerto 3000 por defecto.
 * 3. Habilita el middleware `express.json()` para que Express pueda entender
 *    cuerpos de peticiones (payloads) en formato JSON.
 */

// TODO 1: Inicializa express aquí
const app = express();
const PORT = process.env.PORT || 3000;

// TODO 1.2: Habilita el middleware express.json()
app.use(express.json());


// -----------------------------------------------------------------------------
// BASE DE DATOS EN MEMORIA (DATASET: Papeleria)
// -----------------------------------------------------------------------------
let productos = [
  { id: 1, sku: "PAP:001", nombre: "Cuaderno 100 hojas", categoria: "PAPELERIA", stock: 8, precio: 150000 },
  { id: 2, sku: "PAP:001", nombre: "Marcador permanente 10 colores", categoria: "LAPICEROS", stock: 3, precio: 1000 },
  { id: 3, sku: "PAP:001", nombre: "CARTUCHERA", categoria: "ACCESORIOS", stock: 0, precio: 20000 },
  { id: 4, sku: "PAP:001", nombre: "Papel bond 80g 500 hojas", categoria: "PAPELERIA", stock: 5, precio: 300000 },
  { id: 5, sku: "PAP:001", nombre: "Temperas de colores primarios", categoria: "LAPICEROS", stock: 12, precio: 12000 }
];


// =============================================================================
// RETO 2: ENDPOINT HEALTH-CHECK (GET /api/status)
// =============================================================================
/**
 * OBJETIVO:
 * Todo backend profesional debe proveer un endpoint de diagnóstico para verificar
 * que el servidor está encendido y operativo.
 * 
 * Verbo: GET
 * Ruta: /api/status
 * Respuesta esperada (Status 200 OK):
 * {
 *   ok: true,
 *   mensaje: "Servidor Express ADSO en funcionamiento",
 *   entorno: "desarrollo",
 *   timestamp: "<fecha ISO actual>",
 *   uptimeSegundos: Math.floor(process.uptime())
 * }
 */

// TODO 2: Implementa aquí el endpoint GET /api/status
 
app.get("/api/status", (req, res) => {
    res.status(200).json( {
    ok: true,
    mensaje: "Servidor Express ADSO en funcionamiento",
    entorno: "desarrollo",
    timestamp: "<fecha ISO actual>",
    uptimeSegundos: Math.floor(process.uptime())
    })
  });


// =============================================================================
// RETO 3: LISTAR PRODUCTOS CON FILTROS DINÁMICOS (GET /api/productos?query)
// =============================================================================
/**
 * OBJETIVO:
 * Retornar el catálogo de productos con capacidad de filtrado mediante req.query.
 * 
 * Verbo: GET
 * Ruta: /api/productos
 * Parámetros Query soportados:
 * - categoria: Filtrar productos cuya categoría coincida (case-insensitive).
 * - q: Buscar productos cuyo nombre contenga el texto buscado.
 * 
 * Respuesta esperada (Status 200 OK):
 * {
 *   ok: true,
 *   total: <número de productos encontrados>,
 *   filtrosAplicados: { categoria, q },
 *   datos: <array con los productos filtrados>
 * }
 */

// TODO 3: Implementa aquí el endpoint GET /api/productos

app.get('/api/productos', (req, res) => {
  const { categoria, q } = req.query;
  let resultado = productos;

  if (categoria) {
    resultado = productos.filter(p => 
      p.categoria.toUpperCase() === categoria.toUpperCase()
    );
  }

  if (q) {
    resultado = resultado.filter(producto =>
      producto.nombre.toUpperCase().includes(q.toUpperCase())
    );
  }
  res.status(200).json({
    ok: true,
    total: resultado.length,
    filtrosAplicados: { categoria, q },
    datos: resultado
  });
});



// =============================================================================
// RETO 4: CONSULTAR UN PRODUCTO POR ID (GET /api/productos/:id)
// =============================================================================
/**
 * OBJETIVO:
 * Buscar y retornar un único producto a partir del parámetro de ruta req.params.id.
 * 
 * Verbo: GET
 * Ruta: /api/productos/:id
 * 
 * Reglas de negocio:
 * 1. Convertir req.params.id a número (`Number(req.params.id)`).
 * 2. Buscar en el array `productos` con `.find()`.
 * 3. Si NO existe:
 *    Retornar Status 404 (Not Found) con JSON:
 *    { ok: false, error: "Producto con ID no encontrado" }
 * 4. Si existe:
 *    Retornar Status 200 (OK) con JSON:
 *    { ok: true, datos: productoEncontrado }
 */

// TODO 4: Implementa aquí el endpoint GET /api/productos/:id


app.get('/api/productos/:id',  (req, res) => {
  const id = Number(req.params.id);
  const productoEncontrado = productos.find(producto => producto.id === id);

  if (!productoEncontrado) {
    return res.status(404).json({
      ok: false,
      error: "Producto con ID no encontrado"
    })
  }

  res.status(200).json({
    ok: true,
    datos: productoEncontrado
  });
});


// =============================================================================
// RETO 5: CREAR UN NUEVO PRODUCTO CON VALIDACIÓN (POST /api/productos)
// =============================================================================
/**
 * OBJETIVO:
 * Recibir un nuevo producto en req.body y agregarlo al array en memoria.
 * 
 * Verbo: POST
 * Ruta: /api/productos
 * 
 * Reglas de validación defensiva:
 * 1. Desestructurar de req.body: { sku, nombre, categoria, stock, precio }.
 * 2. Validar que ninguno de los campos venga vacío o indefinido.
 *    Si falta alguno, responder con Status 400 (Bad Request):
 *    { ok: false, error: "Todos los campos (sku, nombre, categoria, stock, precio) son obligatorios" }
 * 3. Validar que el SKU no esté duplicado en el catálogo.
 *    Si ya existe, responder con Status 409 (Conflict):
 *    { ok: false, error: `Ya existe un producto registrado con el SKU '${sku}'` }
 * 4. Si pasa las validaciones:
 *    - Generar nuevo ID único autoincremental (`Date.now()` o `productos.length + 1`).
 *    - Crear el objeto nuevo con los datos parseados numéricamente (`Number(stock)`, `Number(precio)`).
 *    - Agregarlo al array inmutablemente o con push.
 *    - Responder con Status 201 (Created):
 *      { ok: true, mensaje: "Producto registrado exitosamente", datos: nuevoProducto }
 */

// TODO 5: Implementa aquí el endpoint POST /api/productos

app.post('/api/productos', (req, res) => {
  const { sku, nombre, categoria, stock, precio } = req.body;

  // validación de campos obligatorios
  if (!sku || !nombre || !categoria || stock === undefined || precio === undefined) {
    return res.status(400).json({ ok: false, error: "Todos los campos son obligatorios"});
  }

  if (productos.some(producto => producto.sku === sku)) {
    return res.status(409).json ({ ok: false, error: `Ya existe un producto registrado con el SKU '${sku}'`})
  }

  //crear la simulacion de un producto nuevo
  const nuevoProducto = {
    id: productos.length ? Math.max (...productos.map(p => p.id)) + 1 : 1,
    nombre: nombre.trim(),
    precio: Number(precio),
    categoria: (categoria || "GENERAL").toUpperCase(),
    stock: Number(stock) || 0
  }
  
  //Empujamos el nuevo producto al array
  productos.push(nuevoProducto);
//si es correcto, respondemos con el status 201 y el producto creado
  res.status(201).json({
     ok: true,
     mensaje: "Producto registrado exitosamente",
     datos: nuevoProducto});
});


// =============================================================================
// RETO 6 [NIVEL PRO]: ACTUALIZACIÓN PARCIAL Y MIDDLEWARE 404 GLOBAL
// =============================================================================
/**
 * OBJETIVO:
 * 6.1 Actualizar el stock de un producto con PATCH:
 *     Ruta: PATCH /api/productos/:id/stock
 *     Body esperado: { nuevoStock: 15 }
 *     - Si el producto no existe -> 404 Not Found.
 *     - Si nuevoStock < 0 o no es número -> 400 Bad Request.
 *     - Si es válido -> Actualizar `producto.stock = nuevoStock` y retornar 200 OK.
 * 
 * 6.2 Middleware Catch-All para Rutas Inexistentes (404 Global):
 *     Si el cliente hace una petición a una ruta que no existe (ej. /api/usuarios):
 *     app.use((req, res) => {
 *       res.status(404).json({
 *         ok: false,
 *         error: `La ruta '${req.originalUrl}' con método '${req.method}' no existe en este servidor.`
 *       });
 *     });
 */

// TODO 6.1: Implementa aquí el endpoint PATCH /api/productos/:id/stock

app.patch('/api/productos/:id/stock', (req, res) => {
  const id = Number(req.params.id);
  const { nuevoStock } = req.body;

  //validar Producto existente
  const producto = productos.find(p => p.id === id);

  if (!producto) {
    return res.status(404).json({ ok: false, error: "Producto con ID no encontrado" });
  }

  //Validar nuevoStock
  if (typeof nuevoStock !== 'number' || nuevoStock < 0) {
    return res.status(400).json({ ok: false, error: "nuevoStock debe ser >= 0" });
  } 

  const anterior = producto.stock;
  producto.stock = nuevoStock; // Mutación controlada

  res.status(200).json({
    ok: true,
    mensaje: "Stock actualizado correctamente",
    stockAnterior: anterior,
    stockActual: producto.stock
  
  });
});


// =============================================================================
// RETO BONUS [PREPARACIÓN LIVE MOD]: ELIMINAR PRODUCTO POR ID (DELETE)
// =============================================================================
/**
 * OBJETIVO (Pregunta típica en Sustentación en Caliente):
 * Implementar el borrado de un producto a partir de su ID.
 * 
 * Verbo: DELETE
 * Ruta: /api/productos/:id
 * 
 * Reglas:
 * 1. Extraer y convertir el id a número (`Number(req.params.id)`).
 * 2. Buscar si el producto existe en el array.
 *    Si NO existe -> Retornar Status 404 (Not Found):
 *    { ok: false, error: "Producto no encontrado para eliminar" }
 * 3. Si existe:
 *    - Eliminarlo del array `productos` (usando `.filter()` o `.splice()`).
 *    - Retornar Status 200 (OK) con JSON:
 *      { ok: true, mensaje: "Producto eliminado exitosamente", idEliminado: id }
 *    - (Opcional estándar REST: Retornar Status 204 No Content sin cuerpo).
 */

// TODO BONUS: Implementa aquí el endpoint DELETE /api/productos/:id
// app.delete('/api/productos/:id', (req, res) => { ... });
app.delete('/api/productos/:id', (req, res) => {
  const id = Number(req.params.id);
  const productoIndex = productos.findIndex(p => p.id === id);

  // 1. Si no existe, responder 404
  if (productoIndex === -1) {
    return res.status(404).json({
      ok: false,
      error: "Producto no encontrado para eliminar"
    });
  }
  // 2. Eliminar elemento del array
  const [eliminado] = productos.splice(productoIndex, 1);

  // 3. Responder 200 OK con el registro eliminado
  res.status(200).json({
    ok: true,
    mensaje: "Producto eliminado exitosamente",
    idEliminado: id
  });
});

// =============================================================================
// TODO 6.2: Middleware 404 Global (DEBE IR AL FINAL DE TODAS LAS RUTAS)
// =============================================================================

app.use((req, res) => {
  res.status(404).json({
    ok: false,
    error: `La ruta '${req.originalUrl}' con método '${req.method}' no existe en este servidor.`
  });
});

// =============================================================================
// INICIAR LA ESCUCHA DEL SERVIDOR
// =============================================================================
app.listen(PORT, () => {
  console.log("=================================================================");
  console.log(`🚀 SERVIDOR EXPRESS INICIADO EN: http://localhost:${PORT}`);
  console.log(`📡 Health Check: http://localhost:${PORT}/api/status`);
  console.log(`📦 Productos:    http://localhost:${PORT}/api/productos`);
  console.log("💡 Abre Bruno y carga la colección en: recursos/bruno-collection/");
  console.log("=================================================================");
});
