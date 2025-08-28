part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;
  ItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

class ItemCreated extends ItemState {}

class ItemUpdated extends ItemState {}

class ItemDeleted extends ItemState {}