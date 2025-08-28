import '../../domain/repositories/item_repository.dart';
import '../../domain/entities/item.dart';

class ItemRepositoryImpl implements ItemRepository {
  final List<Item> _items = [];

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