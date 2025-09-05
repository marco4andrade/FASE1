import 'package:flutter/material.dart';
import 'dart:io';

/// Widget de tarjeta reutilizable para mostrar información de un elemento.
/// 
/// Muestra la información básica de un elemento en formato de tarjeta con:
/// - Imagen (si está disponible)
/// - Título del elemento
/// - Descripción truncada
/// - Interacción táctil
/// 
/// Características:
/// - Soporte para imágenes de assets y archivos locales
/// - Diseño responsive y moderno
/// - Manejo de errores en carga de imágenes
/// - Animaciones implícitas con Material Design
/// 

class ItemCard extends StatelessWidget {
  /// El elemento a mostrar en la tarjeta
  final dynamic item;

  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  Widget _buildImage(String imagePath, double width, double height) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, size: 40);
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, size: 40);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: item.imagePath != null
            ? _buildImage(item.imagePath!, 56, 56)
            : const Icon(Icons.image, size: 40),
        title: Text(item.title),
        subtitle: Text(item.description),
        onTap: onTap,
      ),
    );
  }
}
