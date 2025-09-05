import '../entities/item_entity.dart';
import '../repositories/item_repository.dart';

/// Centraliza todas las operaciones de negocio relacionadas con [Item].
/// 
/// Encapsula toda la lógica de negocio relacionada con los elementos. Actúa como un punto
/// único de entrada para todas las operaciones que la capa de presentación
/// puede realizar sobre los elementos.
/// 
/// Beneficios:
/// - Centralización de lógica de negocio
/// - Fácil mantenimiento y testing
/// - Desacoplamiento entre presentación y datos
/// - Reutilización de código
/// 

class ItemUsecases {
  /// Repositorio utilizado para operaciones de persistencia
  final ItemRepository repository;

  ItemUsecases(this.repository);

  Future<List<Item>> getItems() async {
    return await repository.getItems();
  }
 
  Future<void> addItem(Item item) async {
    await repository.addItem(item);
  }

  Future<void> updateItem(Item item) async {
    await repository.updateItem(item);
  }

  Future<void> deleteItem(String id) async {
    await repository.deleteItem(id);
  }

  Future<Item?> getItemById(String id) async {
    return await repository.getItemById(id);
  }
}