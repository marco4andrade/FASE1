# Flutter CRUD App – Clean Architecture

## Descripción

Esta aplicación responde a la FASE1 de la ruta de crecimiento de GROWTH HUB Flutter. Permite a los usuarios agregar, visualizar, editar y eliminar elementos, cada uno con un título, descripción e imagen. La app utiliza una estructura basada en Clean Architecture para mantener el código organizado, escalable y fácil de mantener. Los datos se almacenan localmente y las imágenes se guardan como rutas locales.

---

## Estructura de la aplicación

El proyecto está organizado en distintas capas, siguiendo los principios de Clean Architecture:

- **domain/**: Contiene las entidades principales y los casos de uso. Aquí se define la lógica de negocio, independiente de frameworks o detalles de implementación.
- **data/**: Incluye las implementaciones concretas de los repositorios y la fuente de datos local (por ejemplo, el acceso a la base de datos SQLite).
- **presentation/**: Maneja la interfaz de usuario, la gestión de estado (BLoC) y las pantallas principales.

Esta separación permite modificar cada capa de forma independiente y facilita la escalabilidad y las pruebas.

---

## Consideraciones importantes

- **Persistencia local**: La aplicación guarda los datos utilizando SQLite, lo que permite mantener la información incluso si la app se cierra.
- **Imágenes**: Las imágenes seleccionadas se almacenan como rutas locales. Si la imagen original se elimina de la galería del dispositivo, la app no podrá mostrarla.
- **Gestión de estado**: Se utiliza el patrón BLoC para separar la lógica de presentación de la lógica de negocio y datos.
- **Modularidad**: Cada pantalla y funcionalidad principal está separada, lo que permite reutilizar y modificar componentes fácilmente

---
