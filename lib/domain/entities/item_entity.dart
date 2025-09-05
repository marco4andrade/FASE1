import 'package:equatable/equatable.dart';

/// Representa un elemento en el sistema con información básica y opcionalmente una imagen.
/// 
/// Esta es la entidad principal del dominio que define la estructura de datos
/// de un item que puede ser creado, modificado, visualizado y eliminado por los usuarios.
///

class Item extends Equatable {
  /// Identificador único del elemento
  final String id;
  
  /// Título del elemento
  final String title;
  
  /// Descripción detallada del elemento
  final String description;
  
  /// Ruta opcional a la imagen asociada al elemento.
  /// Puede ser una ruta de asset (assets/) o un archivo local.
  final String? imagePath;

  /// Crea una nueva instancia de [Item].
  /// 
  /// Todos los parámetros son requeridos excepto [imagePath] que es opcional.
  const Item({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
  });

  /// Crea una copia de este [Item] con los valores especificados sobrescritos.
  /// 
  /// Si no se proporcionan nuevos valores, se mantienen los valores originales.
  /// El [id] no puede ser modificado ya que es el identificador único.
  /// 

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