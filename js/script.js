/**
 * ============================================================================
 * Proyecto: Portal Institucional de Aprendices ADSO 3293992 - SENA
 * Archivo: js/script.js
 * Descripción: Carga de datos, navegación por pestañas (Directorio, Guía Git,
 *              Plan de Sesiones), filtrado reactivo y renderizado institucional.
 * ============================================================================
 */

// Rutas relativas para compatibilidad universal con GitHub Pages y localhost
const RUTA_APRENDICES_JSON = './data/aprendices.json';
const RUTA_PLAN_JSON = './data/plan_sesiones.json';

// Referencias del DOM
const contenedorGrilla = document.getElementById('portfolioGrid');
const inputBusqueda = document.getElementById('inputBusqueda');
const btnLimpiarBusqueda = document.getElementById('btnLimpiarBusqueda');
const contadorResultados = document.getElementById('contadorResultados');
const sinResultados = document.getElementById('sinResultados');
const btnResetFiltro = document.getElementById('btnResetFiltro');
const kpiTotal = document.getElementById('kpiTotal');
const contenedorPlanSesiones = document.getElementById('contenedorPlanSesiones');

// Estado en memoria
let todosLosAprendices = [];
let todasLasSemanas = [];
let semanaFiltroActual = 0; // 0 = todas

/**
 * Inicializa la aplicación al cargar el DOM.
 */
async function inicializarPortal() {
    configurarNavegacionPorHash();
    await Promise.all([
        cargarAprendices(),
        cargarPlanSesiones()
    ]);
}

/**
 * Carga y renderiza el listado de aprendices.
 */
async function cargarAprendices() {
    try {
        const respuesta = await fetch(RUTA_APRENDICES_JSON);
        if (!respuesta.ok) throw new Error(`HTTP ${respuesta.status}`);

        todosLosAprendices = await respuesta.json();

        if (kpiTotal) {
            kpiTotal.textContent = todosLosAprendices.length;
        }

        renderizarTarjetas(todosLosAprendices);
        configurarBuscador();

    } catch (error) {
        console.error('Error al cargar aprendices:', error);
        mostrarErrorCarga();
    }
}

/**
 * Carga y renderiza el cronograma de 40 sesiones técnicas.
 */
async function cargarPlanSesiones() {
    try {
        const respuesta = await fetch(RUTA_PLAN_JSON);
        if (!respuesta.ok) throw new Error(`HTTP ${respuesta.status}`);

        todasLasSemanas = await respuesta.json();
        renderizarPlanSesiones(semanaFiltroActual);

    } catch (error) {
        console.error('Error al cargar plan de sesiones:', error);
        if (contenedorPlanSesiones) {
            contenedorPlanSesiones.innerHTML = `
                <div class="p-6 bg-white border border-red-200 rounded-xl text-center text-xs text-red-700">
                    No fue posible cargar el plan de sesiones desde <code>data/plan_sesiones.json</code>.
                </div>
            `;
        }
    }
}

/**
 * Renderiza las tarjetas de los aprendices con diseño sobrio institucional SENA.
 * @param {Array<Object>} lista - Aprendices a presentar
 */
function renderizarTarjetas(lista) {
    if (!contenedorGrilla) return;
    contenedorGrilla.innerHTML = '';

    if (lista.length === 0) {
        if (sinResultados) sinResultados.classList.remove('hidden');
        if (contadorResultados) contadorResultados.textContent = '0 aprendices';
        return;
    }

    if (sinResultados) sinResultados.classList.add('hidden');
    if (contadorResultados) {
        contadorResultados.textContent = `${lista.length} ${lista.length === 1 ? 'aprendiz' : 'aprendices'}`;
    }

    lista.forEach(aprendiz => {
        const tarjeta = document.createElement('article');
        tarjeta.className = `
            bg-white rounded-xl border border-slate-200 hover:border-emerald-500 
            p-5 flex flex-col justify-between transition-all duration-200 
            hover:shadow-sm cursor-pointer group
        `;

        const inicial = (aprendiz.nombre && aprendiz.nombre.trim().length > 0) 
            ? aprendiz.nombre.trim().charAt(0).toUpperCase() 
            : 'A';

        tarjeta.innerHTML = `
            <div>
                <!-- Encabezado sutil de tarjeta -->
                <div class="flex items-center justify-between text-[11px] pb-3 border-b border-slate-100">
                    <span class="font-mono text-slate-400 font-medium">#${String(aprendiz.id).padStart(2, '0')}</span>
                    <span class="inline-flex items-center px-2 py-0.5 rounded text-[10px] font-semibold bg-emerald-50 text-[#2e8500] border border-emerald-100">
                        En Formación
                    </span>
                </div>

                <!-- Cuerpo de tarjeta: Avatar centrado e información -->
                <div class="py-4 text-center">
                    <div class="w-14 h-14 rounded-full bg-emerald-50 border-2 border-emerald-100 text-[#2e8500] flex items-center justify-center font-bold text-lg mx-auto mb-3 group-hover:bg-emerald-100 transition-colors">
                        ${inicial}
                    </div>

                    <h3 class="text-sm font-bold text-slate-900 group-hover:text-[#2e8500] transition-colors leading-snug">
                        ${aprendiz.nombre}
                    </h3>
                    <p class="text-xs font-semibold text-slate-500 mt-0.5">
                        ${aprendiz.apellido}
                    </p>
                    <p class="text-[11px] text-slate-400 mt-2 font-medium">
                        Tecnólogo ADSO • Ficha 3293992
                    </p>
                </div>
            </div>

            <!-- Botón institucional de acción directa -->
            <div class="pt-3 border-t border-slate-100">
                <a href="./${aprendiz.carpeta}/index.html" 
                   class="w-full py-2 px-3 rounded-lg text-xs font-semibold text-white bg-[#39A900] hover:bg-[#2e8500] text-center inline-flex items-center justify-center gap-1.5 transition-colors shadow-2xs">
                    <span>Ver Portafolio Personal</span>
                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </a>
            </div>
        `;

        tarjeta.addEventListener('click', (evento) => {
            if (!evento.target.closest('a')) {
                window.location.href = `./${aprendiz.carpeta}/index.html`;
            }
        });

        contenedorGrilla.appendChild(tarjeta);
    });
}

/**
 * Renderiza el cronograma de sesiones filtrado por semana.
 * @param {number} semanaNum - 0 para todas, o 1..8
 */
function renderizarPlanSesiones(semanaNum) {
    if (!contenedorPlanSesiones) return;
    contenedorPlanSesiones.innerHTML = '';

    const semanasAMostrar = (semanaNum === 0) 
        ? todasLasSemanas 
        : todasLasSemanas.filter((_, idx) => idx + 1 === semanaNum);

    if (semanasAMostrar.length === 0) {
        contenedorPlanSesiones.innerHTML = `
            <div class="p-8 bg-white border border-slate-200 rounded-xl text-center text-xs text-slate-500">
                No hay sesiones para mostrar en esta semana.
            </div>
        `;
        return;
    }

    semanasAMostrar.forEach((semana, indexSemana) => {
        const tarjetaSemana = document.createElement('article');
        tarjetaSemana.className = 'bg-white rounded-xl border border-slate-200 p-5 sm:p-6 shadow-xs space-y-4';

        // Estilos para el badge según el eje temático
        const getBadgeEje = (eje) => {
            if (eje.includes('BD')) {
                return 'bg-blue-50 text-blue-700 border-blue-200';
            } else if (eje.includes('Backend')) {
                return 'bg-emerald-50 text-emerald-700 border-emerald-200';
            } else if (eje.includes('Frontend')) {
                return 'bg-indigo-50 text-indigo-700 border-indigo-200';
            } else {
                return 'bg-amber-50 text-amber-700 border-amber-200';
            }
        };

        const filasSesiones = semana.sesiones.map(sesion => `
            <div class="p-4 rounded-xl bg-slate-50/70 border border-slate-200/80 hover:bg-slate-50 transition-colors space-y-2">
                <div class="flex flex-wrap items-center justify-between gap-2">
                    <div class="flex items-center gap-2">
                        <span class="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-slate-200 text-slate-700">
                            Día ${String(sesion.dia).padStart(2, '0')} • Sesión ${String(sesion.sesion).padStart(2, '0')}
                        </span>
                        <span class="px-2 py-0.5 rounded text-[10px] font-semibold border ${getBadgeEje(sesion.eje)}">
                            ${sesion.eje}
                        </span>
                    </div>

                    <span class="text-[11px] font-mono text-slate-400 font-medium flex items-center gap-1">
                        <svg class="w-3 h-3 text-sena-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"></path>
                        </svg>
                        carpeta: <strong class="text-sena-dark">${sesion.carpeta_sugerida}/</strong>
                    </span>
                </div>

                <div>
                    <h4 class="text-xs sm:text-sm font-bold text-sena-dark">
                        ${sesion.titulo}
                    </h4>
                    ${sesion.detalles ? `
                        <p class="text-[11px] sm:text-xs text-slate-600 mt-1 leading-relaxed">
                            ${sesion.detalles}
                        </p>
                    ` : ''}
                </div>
            </div>
        `).join('');

        tarjetaSemana.innerHTML = `
            <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                <h3 class="text-sm sm:text-base font-extrabold text-sena-dark flex items-center gap-2">
                    <span class="w-2.5 h-2.5 rounded-full bg-sena-green"></span>
                    ${semana.titulo}
                </h3>
                <span class="text-[11px] text-sena-muted font-medium">5 Sesiones técnicas</span>
            </div>
            <div class="grid grid-cols-1 gap-3">
                ${filasSesiones}
            </div>
        `;

        contenedorPlanSesiones.appendChild(tarjetaSemana);
    });
}

/**
 * Filtra el cronograma por semana (0 a 8).
 * @param {number} numSemana 
 */
function filtrarSemana(numSemana) {
    semanaFiltroActual = numSemana;

    // Actualizar estilos de los botones de filtro
    for (let i = 0; i <= 8; i++) {
        const btn = document.getElementById(`filtroSemana-${i}`);
        if (btn) {
            if (i === numSemana) {
                btn.className = 'btn-filtro-semana px-2.5 py-1 rounded-md text-xs font-bold bg-sena-green text-white shadow-xs';
            } else {
                btn.className = 'btn-filtro-semana px-2.5 py-1 rounded-md text-xs font-semibold bg-slate-100 text-slate-600 hover:bg-slate-200';
            }
        }
    }

    renderizarPlanSesiones(numSemana);
}

/**
 * Control de cambio entre las 3 pestañas principales.
 * @param {'directorio' | 'instructivo' | 'plan'} pestana 
 */
function cambiarPestana(pestana) {
    const secDirectorio = document.getElementById('seccionDirectorio');
    const secInstructivo = document.getElementById('seccionInstructivo');
    const secPlan = document.getElementById('seccionPlan');

    const tabDirectorio = document.getElementById('tabBtnDirectorio');
    const tabInstructivo = document.getElementById('tabBtnInstructivo');
    const tabPlan = document.getElementById('tabBtnPlan');

    // Ocultar todas
    if (secDirectorio) secDirectorio.classList.add('hidden');
    if (secInstructivo) secInstructivo.classList.add('hidden');
    if (secPlan) secPlan.classList.add('hidden');

    // Reset estilos botones
    [tabDirectorio, tabInstructivo, tabPlan].forEach(btn => {
        if (btn) {
            btn.className = 'tab-btn-inactive pb-2.5 px-3 flex items-center gap-2 whitespace-nowrap transition-colors hover:text-sena-dark';
        }
    });

    // Activar seleccionada
    if (pestana === 'directorio') {
        if (secDirectorio) secDirectorio.classList.remove('hidden');
        if (tabDirectorio) tabDirectorio.className = 'tab-btn-active pb-2.5 px-3 flex items-center gap-2 whitespace-nowrap transition-colors';
        window.location.hash = 'directorio';
    } else if (pestana === 'instructivo') {
        if (secInstructivo) secInstructivo.classList.remove('hidden');
        if (tabInstructivo) tabInstructivo.className = 'tab-btn-active pb-2.5 px-3 flex items-center gap-2 whitespace-nowrap transition-colors';
        window.location.hash = 'instructivo';
    } else if (pestana === 'plan') {
        if (secPlan) secPlan.classList.remove('hidden');
        if (tabPlan) tabPlan.className = 'tab-btn-active pb-2.5 px-3 flex items-center gap-2 whitespace-nowrap transition-colors';
        window.location.hash = 'plan';
    }
}

/**
 * Detecta si el usuario cargó la página con un hash específico (#directorio, #instructivo, #plan).
 */
function configurarNavegacionPorHash() {
    const hash = window.location.hash.replace('#', '');
    if (hash === 'instructivo' || hash === 'plan' || hash === 'directorio') {
        cambiarPestana(hash);
    }
}

/**
 * Configuración del filtro de búsqueda reactiva en vivo para aprendices.
 */
function configurarBuscador() {
    if (!inputBusqueda) return;

    inputBusqueda.addEventListener('input', (e) => {
        const query = normalizarTexto(e.target.value);

        if (btnLimpiarBusqueda) {
            if (query.length > 0) {
                btnLimpiarBusqueda.classList.remove('hidden');
                btnLimpiarBusqueda.classList.add('flex');
            } else {
                btnLimpiarBusqueda.classList.add('hidden');
                btnLimpiarBusqueda.classList.remove('flex');
            }
        }

        const filtrados = todosLosAprendices.filter(aprendiz => {
            const nombreCompleto = normalizarTexto(`${aprendiz.nombre} ${aprendiz.apellido}`);
            return nombreCompleto.includes(query);
        });

        renderizarTarjetas(filtrados);
    });

    if (btnLimpiarBusqueda) {
        btnLimpiarBusqueda.addEventListener('click', () => {
            inputBusqueda.value = '';
            btnLimpiarBusqueda.classList.add('hidden');
            btnLimpiarBusqueda.classList.remove('flex');
            renderizarTarjetas(todosLosAprendices);
            inputBusqueda.focus();
        });
    }

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
 * Normaliza cadenas de texto para búsqueda flexible.
 */
function normalizarTexto(texto) {
    return (texto || '')
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .trim();
}

/**
 * Mensaje de error si falla la carga del JSON de aprendices.
 */
function mostrarErrorCarga() {
    if (!contenedorGrilla) return;
    contenedorGrilla.innerHTML = `
        <div class="col-span-full bg-white border border-red-200 rounded-xl p-8 text-center text-slate-700 my-4">
            <h3 class="text-sm font-bold text-red-700">No fue posible cargar el listado de aprendices</h3>
            <p class="text-xs text-slate-500 mt-1">
                Verifica la existencia del archivo <code>data/aprendices.json</code> y asegúrate de ejecutar el proyecto desde un servidor local o GitHub Pages.
            </p>
        </div>
    `;
}

// Iniciar al cargar el documento
document.addEventListener('DOMContentLoaded', inicializarPortal);
