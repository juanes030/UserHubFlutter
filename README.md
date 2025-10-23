# 🚀 User Profile & Geolocation Manager

## 📖 Descripción del Proyecto

Este repositorio contiene el proyecto móvil desarrollado en **Flutter** como parte de una evaluación técnica. La aplicación está diseñada para la **gestión de perfiles de usuario**, enfocándose en la captura de información personal y la administración de **múltiples direcciones geográficas** por cada perfil.

El desarrollo prioriza una **arquitectura de código escalable** y la implementación de soluciones modernas para el manejo de estados.

---

## ✨ Características Principales

El proyecto cumple con los siguientes requerimientos funcionales:

* **Formulario de Usuario Completo:** Captura de Nombre, Apellido y Fecha de Nacimiento.
* **Gestión de Direcciones Múltiples:** Permite asociar una lista dinámica de direcciones a la cuenta del usuario.
* **Estructura Geográfica Jerárquica:** El flujo de adición de dirección incluye la selección obligatoria de **País**, **Departamento** y **Municipio**.
* **Flujo de 3+ Pantallas:** La interfaz está organizada en un flujo claro (Creación de Perfil, Adición de Dirección, Visualización de Datos).
* **Persistencia de Datos Global:** La información del usuario y sus direcciones es accesible y se puede "pintar" en cualquier momento de la aplicación, demostrando una gestión de estado centralizada y eficiente.

---

## 🛠 Stack Tecnológico y Arquitectura

Se han utilizado las siguientes herramientas y dependencias para asegurar la calidad y escalabilidad del código:

### Entorno
| Herramienta | Versión |
| :--- | :--- |
| **Flutter SDK** | 3.29.3 |
| **Dart SDK** | ^3.7.2 |

### Arquitectura y Gestión de Estado
* **Gestión de Estado:** Implementación con **`BLoC`** y **`flutter_bloc`** para una clara separación de la lógica de negocio y la interfaz de usuario.
* **Inyección de Dependencias:** Uso de **`get_it`** para desacoplar las clases y facilitar las pruebas unitarias.
* **Navegación:** **`go_router`** para una gestión de rutas declarativa y profunda.
* **Modelado de Datos:** **`equatable`** para un manejo eficiente de la comparación de objetos y la inmutabilidad en los bloques.

### Dependencias Adicionales
* `intl`: Localización y formateo de fechas.
* `flutter_localization`, `flutter_localizations`: Soporte para múltiples idiomas.
* `flutter_native_splash`, `flutter_launcher_icons`: Personalización de la experiencia de inicio (íconos y splash screen).

---

## 🚀 Instalación y Ejecución

Sigue estos pasos para poner en marcha el proyecto:

1.  **Clonar el Repositorio:**
    ```bash
    git clone https://github.com/juanes030/UserHubFlutter.git
    cd user_hub_flutter
    ```
2.  **Obtener Dependencias:**
    ```bash
    flutter pub get
    ```
3.  **Ejecutar la Aplicación:**
    ```bash
    flutter run
    ```
    *Asegúrate de tener un emulador o dispositivo conectado y configurado.*

---
