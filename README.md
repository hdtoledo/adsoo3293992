# Portafolio Institucional ADSO 3293992 - SENA

Aplicación web institucional desarrollada para centralizar y coordinar el trabajo formativo de los aprendices del programa **Análisis y Desarrollo de Software (ADSO) - Ficha 3293992** del Servicio Nacional de Aprendizaje (SENA), Regional Huila.

El portal integra tres componentes estratégicos:
1. **Directorio Oficial de Aprendices:** Directorio con las fichas personales de los 28 aprendices y acceso directo a sus portafolios de evidencias.
2. **Instructivo Oficial Git & Buenas Prácticas:** Protocolo de colaboración directa para desarrolladores (sin Pull Requests), comandos obligatorios y centro de solución de errores de Git.
3. **Plan de Sesiones Técnicas (40 Días / 8 Semanas):** Currículo intensivo Full Stack MERN con el detalle de las entregas requeridas día por día.

---

## 🚀 Tecnologías y Estándares

- **HTML5 Semántico:** Estructura institucional accesible y estandarizada.
- **Tailwind CSS:** Diseño sobrio ajustado a la paleta institucional oficial del SENA (Verde SENA `#39A900`, Azul `#00324D`).
- **JavaScript Moderno (ES6+):** Programación asíncrona (`async/await`), consumo reactivo de datos en formato JSON (`aprendices.json` y `plan_sesiones.json`), filtrado en vivo y navegación por pestañas (`#directorio`, `#instructivo`, `#plan`).
- **Arquitectura Segura y Compatible con GitHub Pages:**
  - Rutas relativas universales sin necesidad de procesos de compilación o servidor Node.js.
  - Protección de privacidad: sin exposición de documentos de identidad, números telefónicos ni correos personales.
  - Archivo `.gitignore` con exclusión de reportes internos y archivos de ofimática.

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
 ┣ 📂 assets/
 ┃ ┗ 🖼️ logo_green.png                      # Logotipo institucional oficial SENA
 ┣ 📂 data/
 ┃ ┣ 📜 aprendices.json                     # Listado oficial de 28 aprendices (sanitizado)
 ┃ ┗ 📜 plan_sesiones.json                  # Estructura curricular de 40 sesiones (8 semanas)
 ┣ 📂 js/
 ┃ ┗ 📜 script.js                           # Control de pestañas, buscador y renderizado
 ┣ 📜 index.html                            # Portal principal (Directorio, Guía Git y Plan)
 ┣ 📜 planSesiones.md                       # Documento fuente curricular de las sesiones
 ┣ 📜 .gitignore                            # Protección de archivos de entorno y datos sensibles
 ┗ 📜 README.md                             # Documentación oficial del repositorio
```

---

## 🛠️ Protocolo Git para Aprendices (Colaboración Directa)

Todos los aprendices cuentan con permisos de colaborador directo sobre el repositorio. Para garantizar una convivencia técnica armónica y sin conflictos de código, se debe seguir estrictamente este protocolo:

### Las 4 Reglas de Oro:
1. **Aislamiento Estricto:** Trabaja **únicamente** dentro de tu carpeta asignada `aprendices/tu-nombre-slug/`. Nunca edites ni borres archivos de otros compañeros ni archivos de la raíz.
2. **Sincronización Previa:** Ejecuta siempre `git pull origin master` antes de comenzar a trabajar en tu equipo local.
3. **Staging Selectivo:** Prepara solo tu carpeta con `git add aprendices/tu-nombre-slug/` para evitar subir archivos no deseados.
4. **Commits Profesionales:** Redacta mensajes descriptivos siguiendo el formato `git commit -m "feat(evidencia): sesion-XX - <tema>"`.

### Flujo de Trabajo para cada Evidencia:
```bash
# 1. Sincronizar cambios remotos
git pull origin master

# 2. (Desarrollar tu evidencia en tu carpeta aprendices/tu-slug/ y actualizar tu index.html)

# 3. Preparar tus archivos
git add aprendices/tu-nombre-slug/

# 4. Registrar el commit
git commit -m "feat(evidencia): sesion-01 modelo relacional y ddl"

# 5. Sincronizar y publicar en GitHub
git pull origin master
git push origin master
```

---

## 🆘 Solución a Errores Típicos de Git

- **Error `[rejected - non-fast-forward]`:** Ocurre si otro aprendiz subió un commit antes que tú.  
  *Solución:* Ejecuta `git pull origin master` y luego `git push origin master`.
- **Error `Your local changes would be overwritten by merge`:** Ocurre si haces pull teniendo cambios locales sin guardar.  
  *Solución:* Haz `git add aprendices/tu-slug/` y `git commit -m "..."` primero, y luego haz `git pull origin master`.
- **Error de Conflicto (`Merge conflict`):** Ocurre si dos personas tocaron el mismo archivo.  
  *Solución:* Abre el archivo en Visual Studio Code, presiona **Accept Both Changes** (o conserva lo correcto), guarda, ejecuta `git add .`, haz `git commit -m "fix: resolver conflicto"` y finalmente `git push origin master`.

---

## 🌐 Despliegue en GitHub Pages

1. En el repositorio de **GitHub**, ingresa a **Settings** > **Pages**.
2. En **Source**, selecciona `Deploy from a branch`.
3. Selecciona la rama `master` (o `main`) y la carpeta raíz `/ (root)`.
4. Guarda los cambios. El portal estará en línea en:
   ```text
   https://<usuario-o-organizacion>.github.io/<nombre-repo>/
   ```

---

## 🏛️ Institucional

**Servicio Nacional de Aprendizaje (SENA)**  
Regional Huila • Centro de Formación  
Programa: **Tecnólogo en Análisis y Desarrollo de Software (ADSO)**  
Ficha de Caracterización: **3293992**  
Año: **2026**
