# Portafolio Institucional ADSO 3293992 - SENA

Aplicación web interactiva desarrollada para centralizar y presentar de forma profesional el talento de los aprendices del programa **Análisis y Desarrollo de Software (ADSO) - Ficha 3293992** del Servicio Nacional de Aprendizaje (SENA).

La plataforma permite explorar el directorio de aprendices, filtrar en tiempo real y acceder al espacio personal de cada uno de ellos, donde se registran de forma continua sus **commits y evidencias de aprendizaje**.

---

## 🚀 Tecnologías y Estándares

- **HTML5 Semántico:** Estructuración limpia, accesible y estándar (`<header>`, `<main>`, `<section>`, `<article>`, `<footer>`).
- **Tailwind CSS:** Framework de utilidades CSS integrado con paleta y estilo visual institucional del SENA (Verde SENA `#39A900`, Azul Oscuro `#00324D`).
- **JavaScript Moderno (ES6+):** Programación asíncrona (`async/await`), consumo reactivo de API/JSON local mediante `fetch()`, y filtrado en tiempo real sin dependencias.
- **Arquitectura Segura y Despliegue en GitHub Pages:**
  - Estructura 100% compatible con **GitHub Pages** mediante rutas relativas universales.
  - Protección de privacidad: sin exposición de documentos de identidad, números telefónicos ni correos personales en repositorios públicos.
  - Reglas `.gitignore` para omitir reportes internos y archivos de ofimática.

---

## 📂 Estructura del Proyecto

```text
📦 adso3293992
 ┣ 📂 aprendices/                            # Directorios personales de los 28 aprendices
 ┃ ┣ 📂 erick-julian-cubillos-pena/
 ┃ ┃ ┗ 📜 index.html                        # Portafolio individual y bitácora de evidencias
 ┃ ┣ 📂 juan-esteban-villarreal-ramirez/
 ┃ ┃ ┗ 📜 index.html
 ┃ ┗ ... (28 aprendices en total)
 ┣ 📂 data/
 ┃ ┗ 📜 aprendices.json                     # Listado estructurado (28 aprendices oficiales)
 ┣ 📂 ejerciciosjs/
 ┃ ┗ 📜 004-DOM-Carro.pdf                   # Material y ejercicios técnicos de apoyo
 ┣ 📂 js/
 ┃ ┗ 📜 script.js                           # Lógica del buscador, renderizado y eventos
 ┣ 📜 index.html                            # Página principal institucional (Directorio)
 ┣ 📜 .gitignore                            # Protección de archivos del sistema y datos sensibles
 ┗ 📜 README.md                             # Documentación oficial del proyecto
```

---

## 📋 Guía para el Aprendiz: ¿Cómo registrar tus Commits y Evidencias?

Cada aprendiz cuenta con su propio archivo `index.html` ubicado dentro de `aprendices/<tu-nombre-slug>/index.html`.

Para registrar una nueva actividad o entrega:

1. Abre tu archivo `aprendices/<tu-nombre-slug>/index.html` en tu editor de código (ej. Visual Studio Code).
2. Ubica la sección `<tbody>` dentro de la tabla **Bitácora de Commits y Evidencias de Aprendizaje**.
3. Duplica una de las filas `<tr>` y completa los datos:
   - **#**: Número consecutivo de la evidencia.
   - **Fecha**: Fecha de desarrollo o entrega (formato `AAAA-MM-DD`).
   - **Commit Git**: El hash corto o etiqueta del commit en Git (ej. `feat-login`, `a1b2c3d`).
   - **Fase / Guía**: Fase del proyecto formativo (Inducción, Análisis, Diseño, Desarrollo, etc.).
   - **Evidencia / Actividad**: Título y descripción breve del entregable.
   - **Estado**: Badge con estado (`Aprobado`, `Entregado`, `En Revisión`).
   - **Acción / Enlace**: Enlace a la carpeta o archivo de tu evidencia en tu proyecto.
4. Guarda los cambios, realiza el commit en Git y sube tu avance al repositorio:
   ```bash
   git add .
   git commit -m "docs(evidencia): registro de evidencia 004 DOM Carro"
   git push origin master
   ```

---

## 🌐 Despliegue en GitHub Pages

Este proyecto está diseñado para funcionar de manera inmediata en **GitHub Pages** sin compilación:

1. Ve a tu repositorio en **GitHub**.
2. Dirígete a **Settings** > **Pages** (en el menú lateral izquierdo).
3. En **Build and deployment** > **Source**, selecciona `Deploy from a branch`.
4. Elige la rama `master` (o `main`) y la carpeta `/ (root)`.
5. Haz clic en **Save**. En un par de minutos, tu portafolio estará disponible públicamente en:
   ```text
   https://<tu-usuario>.github.io/<nombre-del-repositorio>/
   ```

---

## 💻 Ejecución en Entorno Local

Para probar la plataforma en tu equipo:

1. Abre la carpeta del proyecto en **Visual Studio Code**.
2. Con la extensión **Live Server** instalada, haz clic derecho sobre [index.html](file:///c:/Users/hdtol/OnehDrive/Documents/2026/SENA/Formacion/ADSO%203293992/adso3293992/index.html) y selecciona **Open with Live Server**.
3. La aplicación se abrirá en `http://127.0.0.1:5500/` cargando dinámicamente los datos vía `fetch()`.

---

## 🏛️ Institucional

**Servicio Nacional de Aprendizaje (SENA)**  
Regional Huila • Centro de Formación  
Programa: **Análisis y Desarrollo de Software (ADSO)**  
Ficha de Caracterización: **3293992**  
Año: **2026**
