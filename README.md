# Portafolio ADSO 3293992

Este proyecto es una aplicación web interactiva desarrollada para presentar de manera profesional y dinámica a los aprendices del programa **Análisis y Desarrollo de Software (ADSO) - Ficha 3293992** del SENA. 

El objetivo principal es contar con una galería (portafolio) centralizada donde se pueda observar el talento humano y proporcionar un punto de acceso a la información y proyectos individuales de cada aprendiz.

## 🚀 Tecnologías y Herramientas

El desarrollo se fundamenta en las principales tecnologías del lado del cliente (Frontend), empleando un enfoque puro ("Vanilla") sin dependencias ni frameworks adicionales, y respetando los estándares modernos de desarrollo web:

- **HTML5:** Estructuración semántica e inclusiva del contenido (`<header>`, `<main>`, `<article>`).
- **CSS3:** Diseño con temática oscura moderna (Dark Modern) haciendo uso de variables CSS (Custom Properties), Flexbox, CSS Grid y transiciones nativas orientadas a potenciar la experiencia de usuario (UI/UX).
- **JavaScript (ES6+):** Lógica funcional y asíncrona (`async/await`) encargada de consumir e interpretar los datos para la manipulación dinámica del DOM (Document Object Model).
- **JSON:** Almacenamiento ligero y estandarizado de la lista de usuarios, usado para simular el consumo de una API RESTful.

## 📂 Estructura del Proyecto

La arquitectura del proyecto persigue una separación de capas y modularidad (buenas prácticas):

```text
📦 adso3293992
 ┣ 📂 css
 ┃ ┗ 📜 style.css           # Reglas visuales, paleta de colores y diseño responsivo
 ┣ 📂 data
 ┃ ┗ 📜 aprendices.json     # Listado oficial e individualizado de los aprendices
 ┣ 📂 js
 ┃ ┗ 📜 script.js           # Lógica interactiva, consumo de APIs (fetch) y eventos DOM
 ┣ 📜 index.html            # Interfaz de usuario y punto de acceso principal
 ┗ 📜 README.md             # Documentación del proyecto (este archivo)
```

## ⚙️ Instalación y Uso (Despliegue Local)

A causa de que el código hace uso del API `fetch()` de JavaScript para obtener el listado en `aprendices.json` de manera asíncrona, es **obligatorio** servir los archivos en un **servidor HTTP local**. Esto evita el bloqueo provocado por las estrictas políticas de seguridad CORS del navegador cuando se intentan cargar archivos mediante el protocolo local `file://`.

### Pasos recomendados en Visual Studio Code:

1. Descargar o alojar la carpeta raíz (`adso3293992/`) en **Visual Studio Code**.
2. Dirigirse al apartado de extensiones e instalar **Live Server** (por Ritwick Dey).
3. Abrir el archivo `index.html`.
4. Hacer clic derecho sobre el entorno de código HTML y seleccionar **"Open with Live Server"**.
5. ¡Listo! Una pestaña asíncrona se abrirá en tu navegador predeterminado simulando la conexión web real `http://127.0.0.1:5500/`.

## 📌 Características o "Features"

* **Generación Dinámica:** Construcción automatizada de "Tarjetas de Presentación" interpretadas al vuelo desde el archivo local JSON.
* **Componentes Auto-generados:** Construcción de Avatares circulares calculando a partir de la primera letra del nombre.
* **Responsive Design:** Retícula programada en Grid que se autoajusta a cualquier resolución o dispositivo.
* **Simulación de Interacción:** Escucha activa de eventos de ratón (`Click`) en cada tarjeta listos para redireccionamiento de usuarios.

## 🧑‍💻 Acerca de este Proyecto
Desarrollado para el Programa de Formación **ADSO** del SENA - Ficha 3293992 (Año 2026).

---
*Documentación construida siguiendo los estándares de la industria del software.*
