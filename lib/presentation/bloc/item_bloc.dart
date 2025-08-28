import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item.dart';
import '../../domain/usecases/item_usecases.dart';
import 'package:equatable/equatable.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItems getItems;
  final AddItem addItem;
  final UpdateItem updateItem;
  final DeleteItem deleteItem;

  ItemBloc({
    required this.getItems,
    required this.addItem,
    required this.updateItem,
    required this.deleteItem,
  }) : super(ItemInitial()) {
    on<LoadItemsEvent>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await getItems();
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError('Error cargando los elementos'));
      }
    });

    on<AddItemEvent>((event, emit) async {
      try {
        await addItem(event.item);
        emit(ItemCreated());
        add(LoadItemsEvent());
      } catch (e) {
        emit(ItemError('Error agregando el elemento'));
      }
    });

    on<UpdateItemEvent>((event, emit) async {
      try {
        await updateItem(event.item);
        emit(ItemUpdated());
        add(LoadItemsEvent());
      } catch (e) {
        emit(ItemError('Error actualizando el elemento'));
      }
    });

    on<DeleteItemEvent>((event, emit) async {
      try {
        await deleteItem(event.id);
        emit(ItemDeleted());
        add(LoadItemsEvent());
      } catch (e) {
        emit(ItemError('Error eliminando el elemento'));
      }
    });
  }
}