/**
 * ============================================================================
 * Proyecto: Portafolio Institucional de Aprendices ADSO 3293992 - SENA
 * Archivo: js/script.js
 * Descripción: Orquestación de carga asíncrona de datos, renderizado dinámico
 *              de tarjetas con TailwindCSS, y filtrado reactivo en tiempo real.
 * ============================================================================
 */

// Ruta relativa al archivo JSON para garantizar compatibilidad con GitHub Pages y servidores locales
const RUTA_APRENDICES_JSON = './data/aprendices.json';

// Referencias a los elementos clave del DOM
const contenedorGrilla = document.getElementById('portfolioGrid');
const inputBusqueda = document.getElementById('inputBusqueda');
const btnLimpiarBusqueda = document.getElementById('btnLimpiarBusqueda');
const contadorResultados = document.getElementById('contadorResultados');
const sinResultados = document.getElementById('sinResultados');
const btnResetFiltro = document.getElementById('btnResetFiltro');
const kpiTotal = document.getElementById('kpiTotal');

// Estado en memoria de los aprendices cargados
let todosLosAprendices = [];

/**
 * Inicializa la aplicación cargando los datos desde el archivo JSON.
 */
async function inicializarPortafolio() {
    try {
        const respuesta = await fetch(RUTA_APRENDICES_JSON);
        
        if (!respuesta.ok) {
            throw new Error(`Error HTTP al cargar datos: Código ${respuesta.status}`);
        }

        todosLosAprendices = await respuesta.json();

        // Actualizar el KPI total si existe en pantalla
        if (kpiTotal) {
            kpiTotal.textContent = todosLosAprendices.length;
        }

        // Renderizar inicialmente la lista completa
        renderizarTarjetas(todosLosAprendices);

        // Configurar los listeners de eventos para búsqueda interactiva
        configurarBuscador();

    } catch (error) {
        console.error('Error al inicializar el portafolio:', error);
        mostrarErrorCarga();
    }
}

/**
 * Renderiza la lista de aprendices en tarjetas estilizadas con TailwindCSS.
 * @param {Array<Object>} lista - Colección de aprendices a mostrar
 */
function renderizarTarjetas(lista) {
    if (!contenedorGrilla) return;

    // Vaciamos el contenedor antes de inyectar las tarjetas
    contenedorGrilla.innerHTML = '';

    // Manejo de estado vacío si la búsqueda no arroja resultados
    if (lista.length === 0) {
        if (sinResultados) sinResultados.classList.remove('hidden');
        if (contadorResultados) contadorResultados.textContent = '0 aprendices';
        return;
    }

    if (sinResultados) sinResultados.classList.add('hidden');
    if (contadorResultados) {
        contadorResultados.textContent = `${lista.length} ${lista.length === 1 ? 'aprendiz' : 'aprendices'}`;
    }

    // Creación dinámica de cada tarjeta
    lista.forEach(aprendiz => {
        const tarjeta = document.createElement('article');
        tarjeta.className = `
            bg-white rounded-2xl shadow-sm border border-slate-200/90 overflow-hidden 
            flex flex-col justify-between card-hover cursor-pointer group transition-all duration-300
        `;

        // Extraer la inicial del nombre para el avatar
        const inicial = (aprendiz.nombre && aprendiz.nombre.trim().length > 0) 
            ? aprendiz.nombre.trim().charAt(0).toUpperCase() 
            : 'A';

        // Estructura semántica con Tailwind CSS e identidad visual SENA
        tarjeta.innerHTML = `
            <div>
                <!-- Franja decorativa superior con degradado institucional -->
                <div class="h-16 bg-gradient-to-r from-sena-blue via-sena-blue-light to-sena-green relative">
                    <span class="absolute top-2 right-2 px-2 py-0.5 rounded-full text-[10px] font-bold bg-white/20 text-white backdrop-blur-xs border border-white/20">
                        #${String(aprendiz.id).padStart(2, '0')}
                    </span>
                </div>

                <div class="px-5 pb-4 text-center -mt-8">
                    <!-- Avatar con inicial del aprendiz -->
                    <div class="w-16 h-16 rounded-2xl bg-white p-1 mx-auto shadow-md mb-3 group-hover:scale-105 transition-transform duration-300">
                        <div class="w-full h-full rounded-xl bg-gradient-to-br from-sena-green to-sena-blue flex items-center justify-center text-white font-extrabold text-xl shadow-inner">
                            ${inicial}
                        </div>
                    </div>

                    <!-- Nombres y Apellidos -->
                    <h3 class="text-base font-bold text-sena-blue leading-snug group-hover:text-sena-green transition-colors">
                        ${aprendiz.nombre}
                    </h3>
                    <p class="text-xs font-semibold text-slate-500 mt-0.5">
                        ${aprendiz.apellido}
                    </p>

                    <!-- Rol y badge de estado formativo -->
                    <div class="mt-3 flex items-center justify-center gap-1.5 flex-wrap">
                        <span class="inline-flex items-center px-2 py-0.5 rounded-md text-[11px] font-medium bg-emerald-50 text-sena-green border border-emerald-200">
                            En Formación
                        </span>
                        <span class="inline-flex items-center px-2 py-0.5 rounded-md text-[11px] font-medium bg-slate-100 text-slate-600">
                            ADSO 3293992
                        </span>
                    </div>
                </div>
            </div>

            <!-- Botón de acción para ingresar al directorio personal -->
            <div class="p-4 pt-0 mt-auto border-t border-slate-100 bg-slate-50/50">
                <a href="./${aprendiz.carpeta}/index.html" 
                   class="w-full mt-3 inline-flex items-center justify-center gap-2 bg-sena-blue group-hover:bg-sena-green text-white text-xs font-semibold py-2.5 px-4 rounded-xl shadow-xs transition-all duration-200">
                    <span>Ver Portafolio y Evidencias</span>
                    <svg class="w-3.5 h-3.5 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path>
                    </svg>
                </a>
            </div>
        `;

        // Navegación intuitiva: hacer clic en cualquier parte de la tarjeta redirige al portafolio
        tarjeta.addEventListener('click', (evento) => {
            // Si no se hizo clic directo en la etiqueta <a>, redireccionamos igualmente
            if (!evento.target.closest('a')) {
                window.location.href = `./${aprendiz.carpeta}/index.html`;
            }
        });

        contenedorGrilla.appendChild(tarjeta);
    });
}

/**
 * Configura la búsqueda reactiva en tiempo real por nombre y apellido.
 */
function configurarBuscador() {
    if (!inputBusqueda) return;

    inputBusqueda.addEventListener('input', (e) => {
        const query = normalizarTexto(e.target.value);

        // Mostrar u ocultar botón de limpiar
        if (btnLimpiarBusqueda) {
            if (query.length > 0) {
                btnLimpiarBusqueda.classList.remove('hidden');
                btnLimpiarBusqueda.classList.add('flex');
            } else {
                btnLimpiarBusqueda.classList.add('hidden');
                btnLimpiarBusqueda.classList.remove('flex');
            }
        }

        // Filtrar sobre el arreglo en memoria
        const filtrados = todosLosAprendices.filter(aprendiz => {
            const nombreCompleto = normalizarTexto(`${aprendiz.nombre} ${aprendiz.apellido}`);
            return nombreCompleto.includes(query);
        });

        renderizarTarjetas(filtrados);
    });

    // Acción del botón limpiar búsqueda
    if (btnLimpiarBusqueda) {
        btnLimpiarBusqueda.addEventListener('click', () => {
            inputBusqueda.value = '';
            btnLimpiarBusqueda.classList.add('hidden');
            btnLimpiarBusqueda.classList.remove('flex');
            renderizarTarjetas(todosLosAprendices);
            inputBusqueda.focus();
        });
    }

    // Acción del botón para restablecer filtro cuando no hay resultados
    if (btnResetFiltro) {
        btnResetFiltro.addEventListener('click', () => {
            if (inputBusqueda) inputBusqueda.value = '';
            if (btnLimpiarBusqueda) {
                btnLimpiarBusqueda.classList.add('hidden');
                btnLimpiarBusqueda.classList.remove('flex');
            }
            renderizarTarjetas(todosLosAprendices);
        });
    }
}

/**
 * Normaliza cadenas de texto eliminando tildes y caracteres diacríticos para búsqueda flexible.
 * @param {string} texto 
 * @returns {string} Texto normalizado en minúsculas y sin acentos
 */
function normalizarTexto(texto) {
    return (texto || '')
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .trim();
}

/**
 * Despliega un mensaje amigable en la interfaz en caso de fallo de red o lectura de datos.
 */
function mostrarErrorCarga() {
    if (!contenedorGrilla) return;
    contenedorGrilla.innerHTML = `
        <div class="col-span-full bg-red-50 border border-red-200 rounded-2xl p-8 text-center text-red-800 my-8">
            <svg class="w-12 h-12 text-red-500 mx-auto mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
            </svg>
            <h3 class="text-base font-bold">No fue posible cargar el listado de aprendices</h3>
            <p class="text-xs text-red-600 mt-1 max-w-md mx-auto">
                Verifica que el archivo de datos exista en <code>data/aprendices.json</code> y que la aplicación se ejecute a través de un servidor HTTP (ej: Live Server o GitHub Pages).
            </p>
        </div>
    `;
}

// Iniciar la carga al completar el parseo del DOM
document.addEventListener('DOMContentLoaded', inicializarPortafolio);
