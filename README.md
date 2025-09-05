# Flutter CRUD App – Clean Architecture

[![GitHub Repository](https://img.shields.io/badge/GitHub-FASE1-blue?logo=github)](https://github.com/marco4andrade/FASE1)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.8.1+-blue?logo=flutter)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.8.1+-blue?logo=dart)](https://dart.dev/)

## 📋 Descripción

Esta aplicación Flutter responde a la **FASE1** de la ruta de crecimiento de **GROWTH HUB Flutter**. Es una aplicación CRUD completa que permite a los usuarios **agregar, visualizar, editar y eliminar elementos**, cada uno con un título, descripción e imagen. 

La aplicación está construida siguiendo los principios de **Clean Architecture** con el patrón **BLoC** para la gestión de estado, garantizando un código organizado, escalable y fácil de mantener.

## 🔗 Enlaces

- **Repositorio GitHub**: [https://github.com/marco4andrade/FASE1](https://github.com/marco4andrade/FASE1)
- **Branch principal**: `main`

## 🛠️ Requisitos Técnicos

### Versiones Requeridas
- **Flutter SDK**: `^3.8.1` o superior
- **Dart SDK**: `^3.8.1` o superior
- **Android SDK**: API 21+ (Android 5.0)
- **iOS**: 12.0+

### Dependencias Principales
```yaml
dependencies:
  flutter_bloc: ^8.1.3      # Gestión de estado
  equatable: ^2.0.5         # Comparación de objetos
  uuid: ^4.0.0              # Generación de IDs únicos
  image_picker: ^1.0.7      # Selección de imágenes
  sqflite: ^2.3.2           # Base de datos SQLite
  path_provider: ^2.1.2     # Acceso a directorios del sistema
```

## 🏗️ Arquitectura del Proyecto

El proyecto está organizado siguiendo **Clean Architecture** en distintas capas:

```
lib/
├── core/                    # Funcionalidades compartidas
│   ├── routes/             # Sistema de navegación centralizado
│   └── utils/              # Utilidades generales
├── domain/                 # Lógica de negocio
│   ├── entities/           # Entidades del dominio
│   ├── repositories/       # Interfaces de repositorios
│   └── usecases/          # Casos de uso centralizados
├── data/                   # Capa de datos
│   └── repositories/       # Implementaciones de repositorios
├── presentation/           # Capa de presentación
│   ├── bloc/              # Gestión de estado con BLoC
│   ├── screens/           # Pantallas de la aplicación
│   └── widgets/           # Widgets reutilizables
└── main.dart              # Punto de entrada de la aplicación
```

### Características de la Arquitectura
- **Separación de responsabilidades**: Cada capa tiene su propósito específico
- **Independencia de frameworks**: La lógica de negocio no depende de Flutter
- **Testabilidad**: Estructura que facilita las pruebas unitarias
- **Escalabilidad**: Fácil añadir nuevas funcionalidades
- **Mantenibilidad**: Código limpio y bien organizado

## 🚀 Instalación y Configuración

### 1. Clonar el Repositorio
```bash
git clone https://github.com/marco4andrade/FASE1.git
cd FASE1
```

### 2. Verificar Versión de Flutter
```bash
flutter --version
# Debe mostrar Flutter 3.8.1 o superior
```

### 3. Instalar Dependencias
```bash
flutter pub get
```

### 4. Verificar Configuración
```bash
flutter doctor
# Asegúrate de que no haya errores críticos
```

### 5. Ejecutar la Aplicación
```bash
# Para desarrollo (debug)
flutter run

# Para Android
flutter run -d android

# Para iOS
flutter run -d ios

# Para Web
flutter run -d chrome
```

## 📱 Funcionalidades

- ✅ **Crear elementos**: Agregar nuevos items con título, descripción e imagen
- ✅ **Visualizar lista**: Ver todos los elementos en una lista organizada
- ✅ **Editar elementos**: Modificar cualquier campo de un item existente
- ✅ **Eliminar elementos**: Borrar items individuales o todos a la vez
- ✅ **Seleccionar imágenes**: Desde galería o cámara del dispositivo
- ✅ **Persistencia local**: Datos guardados en SQLite
- ✅ **Navegación centralizada**: Sistema de rutas nombradas
- ✅ **Gestión de estado**: Patrón BLoC implementado

## 🔧 Comandos Útiles

### Análisis de Código
```bash
# Verificar problemas de código
flutter analyze

# Formatear código
dart format .

# Verificar dependencias desactualizadas
flutter pub outdated
```

### Build y Release
```bash
# Build para Android (APK)
flutter build apk --release

# Build para Android (App Bundle)
flutter build appbundle --release

# Build para iOS
flutter build ios --release

# Build para Web
flutter build web --release
```

## 📝 Consideraciones Importantes

### Almacenamiento de Datos
- **Base de datos**: SQLite local para persistencia de datos
- **Imágenes**: Almacenadas como rutas locales en el dispositivo
- **Backup**: Los datos solo existen localmente (sin sincronización en la nube)

### Gestión de Imágenes
- Las imágenes se seleccionan desde galería o cámara
- Se almacenan como rutas de archivos locales
- Si la imagen original se elimina del dispositivo, no se podrá mostrar
- Formatos soportados: JPG, PNG

### Navegación
- Sistema de rutas nombradas centralizado en `AppRoutes`
- Manejo de errores de navegación con pantalla de error personalizada
- Navegación type-safe con validación de argumentos


## 📄 Licencia

Este proyecto es parte del programa GROWTH HUB Flutter - FASE1.

## 👨‍💻 Desarrollador

- **GitHub**: [marco4andrade](https://github.com/marco4andrade)
- **Proyecto**: FASE1 - Flutter Clean Architecture CRUD

---

**Versión del proyecto**: 1.0.0+1  
**Última actualización**: Septiembre 2025
