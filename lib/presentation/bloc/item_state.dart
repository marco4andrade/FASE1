part of 'item_bloc.dart';

/// Clase base abstracta para todos los estados del [ItemBloc].
/// 
abstract class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial del [ItemBloc].
/// 
/// Representa el estado antes de que se ejecute cualquier operación.
class ItemInitial extends ItemState {}

/// Estado que indica que una operación está en progreso.
/// 
/// Utilizado para mostrar indicadores de carga en la UI.
class ItemLoading extends ItemState {}

/// Estado que contiene la lista de elementos cargados exitosamente.
/// 
class ItemLoaded extends ItemState {
  /// Lista de elementos cargados
  final List<Item> items;
  
  ItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

/// Estado que indica que ocurrió un error durante una operación.
/// 
class ItemError extends ItemState {
  /// Mensaje descriptivo del error
  final String message;
  
  ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado de confirmación que indica que se creó un elemento exitosamente.
class ItemCreated extends ItemState {}

/// Estado de confirmación que indica que se actualizó un elemento exitosamente.
class ItemUpdated extends ItemState {}

/// Estado de confirmación que indica que se eliminó un elemento exitosamente.
class ItemDeleted extends ItemState {}