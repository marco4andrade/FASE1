part of 'item_bloc.dart';

/// Clase base abstracta para todos los eventos del [ItemBloc].

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Evento para solicitar la carga de todos los elementos.
/// 
/// No requiere parámetros adicionales. Normalmente se dispara al inicializar
/// la pantalla principal o después de operaciones que modifican la lista.
class LoadItemsEvent extends ItemEvent {}

/// Evento para agregar un nuevo elemento al sistema.
/// 
class AddItemEvent extends ItemEvent {

  final Item item;
  
  AddItemEvent(this.item);
  
  @override
  List<Object?> get props => [item];
}

/// Evento para actualizar un elemento existente.
/// 
class UpdateItemEvent extends ItemEvent {
  /// El elemento con los datos actualizados
  final Item item;
  
  UpdateItemEvent(this.item);
  
  @override
  List<Object?> get props => [item];
}

/// Evento para eliminar un elemento del sistema.

class DeleteItemEvent extends ItemEvent {
  /// Identificador del elemento a eliminar
  final String id;
  DeleteItemEvent(this.id);
  @override
  List<Object?> get props => [id];
}