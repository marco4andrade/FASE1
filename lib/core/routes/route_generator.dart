import 'package:flutter/material.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/details_screen.dart';
import '../../presentation/screens/form_screen.dart';
import '../../presentation/widgets/full_screen_image.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/item_usecases.dart';
import 'app_routes.dart';

/// Generador centralizado de rutas para la aplicación.
/// 
/// Esta clase maneja la generación dinámica de rutas y la navegación
/// entre pantallas, proporcionando un control centralizado del flujo
/// de navegación de la aplicación.
/// 
/// Beneficios:
/// - Control centralizado de navegación
/// - Validación de rutas y parámetros
/// - Manejo de errores de navegación
/// - Fácil debugging y logging de navegación
/// - Inyección de dependencias controlada
class RouteGenerator {
  /// Genera las rutas de la aplicación de forma dinámica.
  /// 
  /// [settings] Configuración de la ruta incluyendo nombre y argumentos.
  /// [itemUsecases] Casos de uso para operaciones con elementos.
  /// 
  /// Retorna la ruta generada o una ruta de error si no se encuentra.
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    ItemUsecases itemUsecases,
  ) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(itemUsecases: itemUsecases),
          settings: settings,
        );
        
      case AppRoutes.details:
        if (settings.arguments is Item) {
          final item = settings.arguments as Item;
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(item: item, itemUsecases: itemUsecases),
            settings: settings,
          );
        }
        return _errorRoute(settings, 'Se requiere un argumento Item para la ruta de detalles');
        
      case AppRoutes.addItem:
        return MaterialPageRoute(
          builder: (_) => const FormScreen(),
          settings: settings,
        );
        
      case AppRoutes.editItem:
        if (settings.arguments is Item) {
          final item = settings.arguments as Item;
          return MaterialPageRoute(
            builder: (_) => FormScreen(item: item),
            settings: settings,
          );
        }
        return _errorRoute(settings, 'Se requiere un argumento Item para la ruta de edición');
        
      case AppRoutes.fullScreenImage:
        if (settings.arguments is String) {
          final imagePath = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => FullScreenImage(imagePath: imagePath),
            settings: settings,
          );
        }
        return _errorRoute(settings, 'Se requiere un argumento String para la ruta de imagen');
        
      default:
        return _errorRoute(settings, 'Ruta no encontrada: ${settings.name}');
    }
  }
  
  /// Genera una ruta de error cuando no se encuentra la ruta solicitada.
  /// 
  /// [settings] Configuración de la ruta que causó el error.
  /// [message] Mensaje descriptivo del error.
  /// 
  /// Retorna una ruta que muestra una pantalla de error.
  static Route<dynamic> _errorRoute(RouteSettings settings, String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error de Navegación',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.home,
                    (route) => false,
                  ),
                  child: const Text('Ir al Inicio'),
                ),
              ],
            ),
          ),
        ),
      ),
      settings: settings,
    );
  }
}
