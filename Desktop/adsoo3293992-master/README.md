# 🏛️ Portal Institucional ADSO 3293992 - SENA

[![SENA](https://img.shields.io/badge/SENA-Regional%20Huila-39A900?style=for-the-badge)](https://www.sena.edu.co)
[![ADSO](https://img.shields.io/badge/Ficha-3293992-00324D?style=for-the-badge)](./index.html)
[![Modalidad](https://img.shields.io/badge/Modalidad-Presencial-39A900?style=for-the-badge)](#)
[![Vigencia](https://img.shields.io/badge/A%C3%B1o-2026-00324D?style=for-the-badge)](#)

Plataforma web institucional y repositorio centralizado desarrollado para el seguimiento formativo, control de evidencias y portafolios técnicos de los aprendices del programa **Tecnólogo en Análisis y Desarrollo de Software (ADSO) - Ficha 3293992** del Servicio Nacional de Aprendizaje (SENA).

---

## 📌 Tabla de Contenidos
1. [Componentes del Portal](#-componentes-del-portal)
2. [Estructura del Repositorio](#-estructura-del-proyecto)
3. [Protocolo Git para Aprendices (Colaboración Directa)](#-protocolo-git-para-aprendices-colaboración-directa)
4. [¿Cómo Registrar y Subir Evidencias Técnicas?](#-cómo-registrar-y-subir-evidencias-técnicas)
5. [Configuración de Llaves SSH (Equipos Compartidos en Salas SENA)](#-configuración-de-llaves-ssh-equipos-compartidos-en-salas-sena)
6. [Solución a Errores Típicos de Git](#-solución-a-errores-típicos-de-git-centro-de-diagnóstico)
7. [Resumen del Plan Curricular (40 Sesiones / 8 Semanas)](#-resumen-del-plan-curricular-40-sesiones--8-semanas)
8. [Tecnologías y Estándares](#-tecnologías-y-estándares)
9. [Despliegue en GitHub Pages](#-despliegue-en-github-pages)
10. [Ejecución en Entorno Local](#-ejecución-en-entorno-local)

---

## 🌐 Componentes del Portal

La aplicación web principal ([index.html](file:///c:/Users/hdtol/OnehDrive/Documents/2026/SENA/Formacion/ADSO%203293992/adso3293992/index.html)) cuenta con un sistema de navegación por 4 pestañas con soporte de anclas URL:

* **👥 Directorio de Aprendices (`#directorio`):** Visualización de las tarjetas institucionales de los 28 aprendices, buscador en tiempo real insensible a acentos/mayúsculas y enlace a cada portafolio individual.
* **🚀 Instructivo Git & Evidencias (`#instructivo`):** Manual paso a paso para el flujo de trabajo colaborativo profesional sin Pull Requests, reglas de convivencia y ciclo de entrega.
* **🔑 Configuración Llave SSH (`#ssh`):** Guía específica para salas de cómputo compartidas con estudiantes de diferentes jornadas, explicando cómo generar claves Ed25519 e impedir interferencias de credenciales.
* **📅 Plan de Sesiones (`#plan`):** Desglose modular de las 40 sesiones de clase organizadas por semanas con botones de filtrado interactivo (S1 a S8) y nomenclatura sugerida para las evidencias.

---

## 📂 Estructura del Proyecto

```text
📦 adso3293992
 ┣ 📂 aprendices/                            # Directorios personales individuales (28 aprendices)
 ┃ ┣ 📂 eliana-mildreth-varela-nupan/
 ┃ ┃ ┣ 📜 index.html                        # Portafolio y bitácora de commits del aprendiz
 ┃ ┃ ┗ 📂 sesion-01/                        # (Subcarpeta donde se guardan los archivos de la evidencia)
 ┃ ┣ 📂 erick-julian-cubillos-pena/
 ┃ ┃ ┗ 📜 index.html
 ┃ ┣ 📂 juan-esteban-villarreal-ramirez/
 ┃ ┃ ┗ 📜 index.html
 ┃ ┗ ... (28 aprendices en total)
 ┣ 📂 assets/
 ┃ ┗ 🖼️ logo_green.png                      # Logotipo institucional oficial SENA
 ┣ 📂 data/
 ┃ ┣ 📜 aprendices.json                     # Base de datos de 28 aprendices (sin datos sensibles)
 ┃ ┗ 📜 plan_sesiones.json                  # Datos estructurados del plan de 40 sesiones
 ┣ 📂 js/
 ┃ ┗ 📜 script.js                           # Control de navegación por pestañas, buscador y renderizado
 ┣ 📜 index.html                            # Portal principal institucional
 ┣ 📜 .gitignore                            # Protección de archivos de sistema, entorno y reportes
 ┗ 📜 README.md                             # Documentación técnica general
```

---

## 🛠️ Protocolo Git para Aprendices (Colaboración Directa)

Todos los aprendices cuentan con permisos de **colaborador con acceso de escritura** en este repositorio. Al no utilizar Pull Requests por el momento, es imperativo cumplir con el protocolo para no sobreescribir el trabajo de los compañeros:

### 🛡️ Las 4 Reglas de Oro:
1. **Aislamiento Estricto:** Tu entorno de trabajo es **exclusivamente** tu carpeta asignada:
   ```text
   aprendices/tu-nombre-slug/
   ```
   *Bajo ninguna circunstancia debes modificar, mover o eliminar archivos fuera de tu carpeta personal.*
2. **Sincronización Previa Obligatoria:** Siempre, antes de comenzar a codificar o antes de confirmar cambios, ejecuta:
   ```bash
   git pull origin master
   ```
3. **Staging Selectivo:** Nunca uses `git add .` indiscriminado desde la raíz. Prepara únicamente tu espacio de trabajo:
   ```bash
   git add aprendices/tu-nombre-slug/
   ```
4. **Commits Profesionales:** Redacta mensajes claros, atómicos y descriptivos siguiendo la convención:
   ```text
   feat(evidencia): sesion-01 modelo relacional y ddl
   ```

---

## 📝 ¿Cómo Registrar y Subir Evidencias Técnicas?

Sigue este ciclo de 5 pasos para cada evidencia del plan de formación:

```bash
# PASO 1: Descargar los últimos cambios del repositorio
git pull origin master

# PASO 2: Trabajar en tu carpeta
# - Crea la subcarpeta de la sesión: aprendices/tu-nombre-slug/sesion-01/
# - Guarda allí tus scripts, consultas o código fuente.
# - Abre tu archivo personal aprendices/tu-nombre-slug/index.html y añade la fila en la tabla.

# PASO 3: Preparar únicamente tus cambios
git add aprendices/tu-nombre-slug/

# PASO 4: Confirmar el commit con mensaje técnico
git commit -m "feat(evidencia): sesion-01 modelo relacional y sentencias ddl"

# PASO 5: Sincronizar y publicar en GitHub
git pull origin master
```

---

## 🔑 Configuración de Llaves SSH (Equipos Compartidos en Salas SENA)

En las salas de cómputo del SENA, los equipos son compartidos diariamente por aprendices de diferentes jornadas y programas. 

> [!IMPORTANT]
> **¿Por qué NO usar HTTPS en salas compartidas?**
> Al iniciar sesión con HTTPS, Windows guarda las credenciales en el *Administrador de Credenciales*, provocando que tus commits se registren con el nombre del usuario anterior o fallen por permisos.
> **La solución profesional es configurar una Llave SSH Ed25519 propia en tu cuenta de GitHub.**

### 1. Configura tu identidad Git local (Sin `--global`):
Abre la terminal en la raíz del proyecto y ejecuta:
```bash
git config user.name "TU NOMBRE COMPLETO"
git config user.email "tu-correo-registrado-en-github@misena.edu.co"
```
*(No uses `--global` para no alterar la configuración de los aprendices de otros turnos)*.

### 2. Genera tu llave SSH personal:
```bash
ssh-keygen -t ed25519 -C "tu-correo@correo.com"
```
- Presiona **Enter** para guardar en la ruta por defecto (`~/.ssh/id_ed25519`).
- Asigna una contraseña (*passphrase*) personal recomendada para proteger tu clave en el equipo compartido.

### 3. Copia tu llave pública:
```bash
# En PowerShell:
Get-Content ~/.ssh/id_ed25519.pub | Set-Clipboard

# En Git Bash:
clip < ~/.ssh/id_ed25519.pub
```

### 4. Regístrala en GitHub:
1. Entra a [github.com](https://github.com) > Clic en tu foto de perfil > **Settings**.
2. Selecciona **SSH and GPG keys** > Botón verde **New SSH key**.
3. **Title:** Escribe el nombre del equipo (ej: `PC-Sala-SENA-ADSO`).
4. **Key type:** `Authentication Key`.
5. **Key:** Pega el texto copiado y presiona **Add SSH key**.

### 5. Verifica la conexión segura:
```bash
ssh -T git@github.com
```
*(Si pregunta si deseas continuar conectándote, escribe `yes` y presiona Enter)*.  
Debe responder: `Hi <tu-usuario>! You've successfully authenticated...`

### 6. Asegura que el repositorio use la URL SSH oficial:
```bash
git remote set-url origin git@github.com:hdtoledo/adsoo3293992.git
```

---

## 🆘 Solución a Errores Típicos de Git (Centro de Diagnóstico)

### ⚠️ Caso 1: Push Rechazado (`[rejected - non-fast-forward]`)
* **Causa:** Otro aprendiz subió un commit a GitHub antes que tú y tu copia local no tiene esa actualización.
* **Solución:** Descarga la actualización e integra con tu commit local:
  ```bash
  git pull origin master
  git push origin master
  ```
  *Nota:* Como cada aprendiz trabaja en una carpeta aislada, Git unirá los cambios automáticamente sin conflictos.

---

### ⚠️ Caso 2: Error al hacer Pull por cambios locales pendientes (`overwritten by merge`)
* **Causa:** Intentaste hacer `git pull` teniendo archivos modificados sin guardar en un commit.
* **Solución:** Guarda primero tu trabajo en un commit local y luego sincroniza:
  ```bash
  git add aprendices/tu-nombre-slug/
  git commit -m "feat(evidencia): guardar avance local de sesion"
  git pull origin master
  git push origin master
  ```

---

### ⚠️ Caso 3: Conflicto de Fusión (`Merge conflict in ...`)
* **Causa:** Dos personas modificaron accidentalmente las mismas líneas de un archivo.
* **Solución:**
  1. Abre el archivo en conflicto en **Visual Studio Code**.
  2. Revisa las opciones visuales que aparecen sobre el bloque en conflicto y haz clic en **Accept Both Changes** (o conserva lo que corresponda).
  3. Guarda el archivo (`Ctrl + S`).
  4. Finaliza el merge en la terminal:
     ```bash
     git add .
     git commit -m "fix(merge): resolver conflicto de integracion"
     git push origin master
     ```

---

### ⚠️ Caso 4: Error de Autenticación (`fatal: Authentication failed`)
* **Causa:** GitHub no permite contraseñas de cuenta por consola; requiere un **Personal Access Token (PAT)** o el asistente web de Git Credential Manager.
* **Solución:**
  1. En GitHub ve a **Settings** > **Developer settings** > **Personal access tokens** > **Tokens (classic)**.
  2. Genera un nuevo token marcando la casilla de verificación `repo`.
  3. Copia el token y úsalo como contraseña cuando la terminal te lo solicite.

---

## 📅 Resumen del Plan Curricular (40 Sesiones / 8 Semanas)

| Semana | Eje Temático Principal | Tecnologías y Competencias Clave |
| :---: | :--- | :--- |
| **Semana 1** | **Nivelación de Fundamentos** | Modelado Relacional SQL, DDL/DML, JS Moderno (ES6+), Asincronía, Protocolo HTTP y Node/Express. |
| **Semana 2** | **Arquitectura en Capas y React Base** | Integridad referencial SQL, arquitectura Express (Routes/Controllers), conexión con `mysql2`/`pg`, Vite + React y Tailwind CSS. |
| **Semana 3** | **Persistencia SQL y Estado en React** | Normalización (1FN a 3FN), CRUD Express + SQL, formularios controlados, hooks `useState` y `useEffect`. |
| **Semana 4** | **Transición NoSQL y Conexión Full Stack** | MongoDB Atlas, Compass, esquemas con Mongoose ODM, endpoints REST y consumo asíncrono desde React con mutaciones reactivas. |
| **Semana 5** | **Relaciones NoSQL y Enrutamiento SPA** | Subdocumentos vs Referencias `.populate()`, validaciones intermedias, `react-router-dom`, `useParams` y navegación dinámica. |
| **Semana 6** | **Seguridad, Autenticación y Estado Global** | Cifrado con `bcryptjs`, firma y verificación de tokens JWT, `AuthContext` con Context API y rutas protegidas (`<ProtectedRoute />`). |
| **Semana 7** | **Sprint de Proyectos Formativos SENA** | Índices y seeds, lógica de negocio específica de cada proyecto, políticas CORS, dashboards en Tailwind e integración total. |
| **Semana 8** | **Despliegue a Producción y Sustentación** | Network Access en Atlas, despliegue de Backend en Railway, build de producción en Vite, despliegue en Vercel y examen de sustentación técnica en vivo. |

*Para ver el detalle completo día por día, consulta la pestaña **Plan de Sesiones** en el portal o el archivo [planSesiones.md](file:///c:/Users/hdtol/OnehDrive/Documents/2026/SENA/Formacion/ADSO%203293992/adso3293992/planSesiones.md).*

---

## 🚀 Tecnologías y Estándares

- **Frontend:** HTML5 Semántico, JavaScript ES6+ Vanilla, Tailwind CSS CDN (Paleta oficial SENA).
- **Backend formativo:** Node.js, Express.js, MongoDB (Mongoose), MySQL / PostgreSQL.
- **Client App formativa:** React + Vite, React Router, Context API, Tailwind CSS.
- **Herramientas de Colaboración:** Git, GitHub, GitHub Pages.

---

## 🌐 Despliegue en GitHub Pages

El proyecto cuenta con rutas relativas universales preparadas para desplegarse sin pasos de compilación:

1. Ingresa a tu repositorio en **GitHub**.
2. Ve a **Settings** > pestaña **Pages** (menú izquierdo).
3. En **Build and deployment** > **Source**, selecciona `Deploy from a branch`.
4. Elige la rama `master` y la carpeta `/ (root)`.
5. Haz clic en **Save**. Tu portal quedará publicado en:
   ```text
   https://<tu-usuario-o-organizacion>.github.io/<nombre-del-repo>/
   ```

---

## 💻 Ejecución en Entorno Local

Para explorar el portal en tu computadora:

1. Clona el repositorio:
   ```bash
   git clone https://github.com/<tu-usuario>/adso3293992.git
   cd adso3293992
   ```
2. Abre la carpeta en **Visual Studio Code**.
3. Haz clic derecho sobre `index.html` y selecciona **Open with Live Server** (o ejecuta `python -m http.server 8080`).
4. Navega en tu navegador a `http://127.0.0.1:5500/` (o puerto correspondiente).

---

## 🏛️ Créditos Institucionales

**Servicio Nacional de Aprendizaje (SENA)**  
Regional Huila • Centro de Formación  
Programa: **Tecnólogo en Análisis y Desarrollo de Software (ADSO)**  
Ficha de Caracterización: **3293992**  
Año de Formación: **2026**
