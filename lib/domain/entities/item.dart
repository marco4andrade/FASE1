import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imagePath;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
  });

  Item copyWith({
    String? title,
    String? description,
    String? imagePath,
  }) {
    return Item(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [id, title, description, imagePath];
}