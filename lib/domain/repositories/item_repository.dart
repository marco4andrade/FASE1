import '../entities/item_entity.dart';

/// Contrato del repositorio para operaciones de persistencia de [Item].
/// 
/// Define las operaciones básicas CRUD (Create, Read, Update, Delete) 
/// 
/// Esta abstracción permite que la capa de dominio sea independiente de la
/// implementación específica del almacenamiento de datos (base de datos, API, memoria, etc.).
/// 
/// Todas las operaciones son asíncronas para permitir implementaciones que
/// requieran operaciones de I/O como llamadas a bases de datos o APIs remotas.
abstract class ItemRepository {

  Future<List<Item>> getItems();
  
  Future<void> addItem(Item item);
  
  Future<void> updateItem(Item item);
  
  Future<void> deleteItem(String id);
  
  Future<Item?> getItemById(String id);
}