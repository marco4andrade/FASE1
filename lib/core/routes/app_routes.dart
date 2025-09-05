/// Centraliza todas las rutas de la aplicación.
/// 
/// Esta clase define todas las rutas disponibles como constantes nombradas,
/// proporcionando un punto único de configuración para la navegación de la app.
/// 
/// Beneficios:
/// - Centralización de rutas
/// - Evita errores de tipeo en nombres de rutas
/// - Facilita el mantenimiento y refactoring
/// - Autocompletado en el IDE
/// - Navegación type-safe
class AppRoutes {
  /// Constructor privado para prevenir instanciación
  AppRoutes._();
  
  /// Ruta de la pantalla principal
  static const String home = '/';
  
  /// Ruta de la pantalla de detalles
  static const String details = '/details';
  
  /// Ruta de la pantalla de formulario para agregar elemento
  static const String addItem = '/add-item';
  
  /// Ruta de la pantalla de formulario para editar elemento
  static const String editItem = '/edit-item';
  
  /// Ruta de la pantalla de imagen completa
  static const String fullScreenImage = '/full-screen-image';
  
  /// Lista de todas las rutas disponibles (útil para debugging o logging)
  static const List<String> allRoutes = [
    home,
    details,
    addItem,
    editItem,
    fullScreenImage,
  ];
  
  /// Verifica si una ruta es válida
  /// 
  /// [route] La ruta a verificar
  /// Retorna true si la ruta está definida en la aplicación
  static bool isValidRoute(String route) {
    return allRoutes.contains(route);
  }
}
