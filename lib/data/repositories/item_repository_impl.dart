import '../../domain/repositories/item_repository.dart';
import '../../domain/entities/item_entity.dart';
import 'package:uuid/uuid.dart';

/// Implementación en memoria del repositorio de elementos.
/// 
/// Esta implementación almacena los datos en una lista en memoria y proporciona
/// datos predefinidos para demostración.
/// 
/// Características:
/// - Almacenamiento temporal en memoria
/// - Datos predefinidos para demostración
/// - Implementación completa del contrato [ItemRepository]
/// - Simulación de operaciones asíncronas
/// 

class ItemRepositoryImpl implements ItemRepository {
  /// Lista interna que simula el almacenamiento de datos.
  /// 
  /// Contiene elementos predefinidos para demostración inicial.
  final List<Item> _items = [
    Item(
      id: const Uuid().v4(),
      title: 'Producto de Ejemplo 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus feugiat et sem vel egestas. Duis nisi enim, tincidunt non libero in, tincidunt volutpat purus. Morbi dapibus massa a ligula imperdiet rhoncus.',
      imagePath: 'assets/images/ejemplo1.jpg',
    ),
    Item(
      id: const Uuid().v4(),
      title: 'Producto de Ejemplo 2',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus feugiat et sem vel egestas. Duis nisi enim, tincidunt non libero in, tincidunt volutpat purus. Morbi dapibus massa a ligula imperdiet rhoncus.',
      imagePath: 'assets/images/ejemplo2.jpg',
    ),
    Item(
      id: const Uuid().v4(),
      title: 'Elemento de Demostración',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus feugiat et sem vel egestas. Duis nisi enim, tincidunt non libero in, tincidunt volutpat purus. Morbi dapibus massa a ligula imperdiet rhoncus.',
      imagePath: 'assets/images/ejemplo3.jpg',
    ),
  ];

  @override
  Future<List<Item>> getItems() async {
    return [..._items];
  }

  @override
  Future<void> addItem(Item item) async {
    _items.add(item);
  }

  @override
  Future<void> updateItem(Item item) async {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index] = item;
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    _items.removeWhere((item) => item.id == id);
  }

  @override
  Future<Item?> getItemById(String id) async {
    try {
      return _items.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}