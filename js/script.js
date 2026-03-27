/**
 * Documentación y Buenas Prácticas:
 * 1. Declarar variables en la parte superior.
 * 2. Usar async/await para funciones asíncronas como peticiones fetch.
 * 3. Manipular el DOM de manera eficiente.
 * 4. Nomenclatura en 'camelCase' y en español para mayor claridad del equipo.
 */

// URL del recurso que contiene los datos de los aprendices
const URL_DATOS = './data/aprendices.json'; 

// Referencia al contenedor principal de la grilla
const contenedorGrilla = document.getElementById('portfolioGrid');

/**
 * Función principal que orquesta la carga y renderizado.
 */
async function inicializarPortafolio() {
    try {
        // Obtenemos los datos de manera asíncrona
        const respuesta = await fetch(URL_DATOS);
        
        // Comprobamos que no haya errores HTTP (ej: 404 No encontrado)
        if (!respuesta.ok) {
            throw new Error(`Error en la petición: Estado ${respuesta.status}`);
        }

        // Parseamos la respuesta a JSON
        const aprendices = await respuesta.json();
        
        // Llamamos a la función encargada de plasmar los datos en el HTML
        renderizarTarjetas(aprendices);
    } catch (error) {
        // En caso de cualquier error, lo mostramos en la consola y avisamos en UI
        console.error('Ocurrió un error al intentar cargar los datos:', error);
        contenedorGrilla.innerHTML = `<p style="color: red; text-align: center; grid-column: 1 / -1;">No fue posible cargar el listado de aprendices.</p>`;
    }
}

/**
 * Recibe un array de objetos "aprendiz" y genera una tarjeta HTML por cada uno.
 * @param {Array} listaAprendices - Datos provenientes del JSON
 */
function renderizarTarjetas(listaAprendices) {
    // Vaciamos el contenedor previo a insertar datos (útil si hay recargas manuales)
    contenedorGrilla.innerHTML = '';

    listaAprendices.forEach(aprendiz => {
        // Creamos el elemento contenedor de la tarjeta usando un tag semántico <article>
        const tarjetaHtml = document.createElement('article');
        tarjetaHtml.classList.add('card');
        
        // Extraemos la inicial del nombre para generar un avatar vistoso
        const inicialUsuario = aprendiz.nombre.charAt(0).toUpperCase();

        // Inyectamos el contenido haciendo uso de Template Literals (ES6)
        tarjetaHtml.innerHTML = `
            <div class="card__avatar">${inicialUsuario}</div>
            <h2 class="card__name">${aprendiz.nombre} ${aprendiz.apellido}</h2>
            <p class="card__role">Desarrollador de Software</p>
        `;

        // Event listener para simular la redirección a la carpeta o portafolio del aprendiz
        tarjetaHtml.addEventListener('click', () => {
            abrirCarpetaDestino(aprendiz);
        });

        // Adjuntamos la tarjeta finalizada al grid
        contenedorGrilla.appendChild(tarjetaHtml);
    });
}

/**
 * Función que simula abrir la carpeta personal del aprendiz
 * @param {Object} aprendiz - Contiene la información (id, nombre, apellido)
 */
function abrirCarpetaDestino(aprendiz) {
    // Generaríamos una ruta basada en el nombre (ej. /juan_perez)
    const rutaSimulada = `${aprendiz.nombre.toLowerCase()}_${aprendiz.apellido.toLowerCase()}`;
    
    // Proporcionar feedback visual al usuario en esta versión de demostración
    alert(`Abriendo carpeta del aprendiz: ${aprendiz.nombre} ${aprendiz.apellido}\nRedirigiendo a: /portafolio/${rutaSimulada}`);
    console.log(`Evento Clic: El usuario intentó acceder a la carpeta de ID: ${aprendiz.id}`);
    
    // Aquí es donde iría la lógica real de cambio de ventana:
    // window.location.href = `/portafolio/${rutaSimulada}`;
}

// Escuchar el evento que indica que todo el HTML se cargó. 
// Esto evita tratar de modificar elementos del DOM que aún no existen.
document.addEventListener('DOMContentLoaded', inicializarPortafolio);
