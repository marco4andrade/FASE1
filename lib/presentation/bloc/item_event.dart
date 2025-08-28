part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemEvent {}

class AddItemEvent extends ItemEvent {
  final Item item;
  AddItemEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class UpdateItemEvent extends ItemEvent {
  final Item item;
  UpdateItemEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class DeleteItemEvent extends ItemEvent {
  final String id;
  DeleteItemEvent(this.id);
  @override
  List<Object?> get props => [id];
}