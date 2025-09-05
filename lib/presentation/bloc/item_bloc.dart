import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/item_usecases.dart';
import 'package:equatable/equatable.dart';

part 'item_event.dart';
part 'item_state.dart';

/// BLoC responsable de la gestión de estado para operaciones con [Item].
/// 
/// Implementa el patrón BLoC para manejar todos
/// los eventos relacionados con elementos y generar los estados correspondientes.
/// Actúa como intermediario entre la UI y la lógica de negocio.
/// 
/// Eventos que maneja:
/// - [LoadItemsEvent]: Carga la lista de elementos
/// - [AddItemEvent]: Agrega un nuevo elemento
/// - [UpdateItemEvent]: Actualiza un elemento existente
/// - [DeleteItemEvent]: Elimina un elemento
/// 
/// Estados que emite:
/// - [ItemInitial]: Estado inicial
/// - [ItemLoading]: Indica operación en progreso
/// - [ItemLoaded]: Lista de elementos cargada exitosamente
/// - [ItemError]: Error en alguna operación
/// - [ItemCreated], [ItemUpdated], [ItemDeleted]: Confirmación de operaciones
/// 

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  /// Casos de uso para operaciones de negocio con elementos
  final ItemUsecases itemUsecases;

  ItemBloc({
    required this.itemUsecases,
  }) : super(ItemInitial()) {
    on<LoadItemsEvent>(_onLoadItemsEvent);
    on<AddItemEvent>(_onAddItemEvent);
    on<UpdateItemEvent>(_onUpdateItemEvent);
    on<DeleteItemEvent>(_onDeleteItemEvent);
  }

  Future<void> _onLoadItemsEvent(
    LoadItemsEvent event,
    Emitter<ItemState> emit,
  ) async {
    emit(ItemLoading());
    try {
      final items = await itemUsecases.getItems();
      emit(ItemLoaded(items));
    } catch (e) {
      emit(ItemError('Error cargando los elementos'));
    }
  }

  Future<void> _onAddItemEvent(
    AddItemEvent event,
    Emitter<ItemState> emit,
  ) async {
    try {
      await itemUsecases.addItem(event.item);
      emit(ItemCreated());
      add(LoadItemsEvent());
    } catch (e) {
      emit(ItemError('Error agregando el elemento'));
    }
  }

  Future<void> _onUpdateItemEvent(
    UpdateItemEvent event,
    Emitter<ItemState> emit,
  ) async {
    try {
      await itemUsecases.updateItem(event.item);
      emit(ItemUpdated());
      add(LoadItemsEvent());
    } catch (e) {
      emit(ItemError('Error actualizando el elemento'));
    }
  }

  Future<void> _onDeleteItemEvent(
    DeleteItemEvent event,
    Emitter<ItemState> emit,
  ) async {
    try {
      await itemUsecases.deleteItem(event.id);
      emit(ItemDeleted());
      add(LoadItemsEvent());
    } catch (e) {
      emit(ItemError('Error eliminando el elemento'));
    }
  }
}