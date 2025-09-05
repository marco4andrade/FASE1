import 'package:flutter/material.dart';
import 'data/repositories/item_repository_impl.dart';
import 'domain/usecases/item_usecases.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';

/// Configurador de dependencias para la aplicación.
/// 
/// Esta clase centraliza la configuración e inyección de dependencias,
/// eliminando variables globales y proporcionando un punto único para
/// la gestión del ciclo de vida de las dependencias.
/// 
/// Beneficios:
/// - Elimina variables globales
/// - Facilita testing con mocks
/// - Centraliza la configuración de dependencias
/// - Mejora la mantenibilidad del código
class DependencyInjector {
  static DependencyInjector? _instance;
  
  /// Instancia única del configurador de dependencias
  static DependencyInjector get instance {
    _instance ??= DependencyInjector._();
    return _instance!;
  }
  
  /// Constructor privado para implementar patrón Singleton
  DependencyInjector._();
  
  /// Repositorio para operaciones de persistencia de elementos
  late final ItemRepositoryImpl _itemRepository;
  
  /// Casos de uso para operaciones de negocio con elementos
  late final ItemUsecases _itemUsecases;
  
  /// Inicializa todas las dependencias de la aplicación.
  /// 
  /// Debe ser llamado antes de usar cualquier dependencia.
  void initializeDependencies() {
    _itemRepository = ItemRepositoryImpl();
    _itemUsecases = ItemUsecases(_itemRepository);
  }
  
  /// Obtiene la instancia de los casos de uso de elementos
  ItemUsecases get itemUsecases => _itemUsecases;
  
  /// Obtiene la instancia del repositorio de elementos
  ItemRepositoryImpl get itemRepository => _itemRepository;
}

void main() {
  // Inicializar dependencias antes de ejecutar la aplicación
  DependencyInjector.instance.initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FASE 1 PRAGMA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(
        settings,
        DependencyInjector.instance.itemUsecases,
      ),
    );
  }
}