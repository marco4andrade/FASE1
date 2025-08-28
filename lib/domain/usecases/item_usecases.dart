import '../entities/item.dart';
import '../repositories/item_repository.dart';

class GetItems {
  final ItemRepository repository;

  GetItems(this.repository);

  Future<List<Item>> call() async {
    return await repository.getItems();
  }
}

class AddItem {
  final ItemRepository repository;

  AddItem(this.repository);

  Future<void> call(Item item) async {
    await repository.addItem(item);
  }
}

class UpdateItem {
  final ItemRepository repository;

  UpdateItem(this.repository);

  Future<void> call(Item item) async {
    await repository.updateItem(item);
  }
}

class DeleteItem {
  final ItemRepository repository;

  DeleteItem(this.repository);

  Future<void> call(String id) async {
    await repository.deleteItem(id);
  }
}