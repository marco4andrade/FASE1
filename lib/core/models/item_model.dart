class ItemModel {
  final String id;
  final String title;
  final String description;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
  });

  ItemModel copyWith({String? title, String? description}) {
    return ItemModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

}