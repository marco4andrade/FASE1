import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item.dart';
import '../bloc/item_bloc.dart';
import 'form_screen.dart';
import 'dart:io';

class DetailsScreen extends StatelessWidget {
  final Item item;

  const DetailsScreen({super.key, required this.item});

  void _openImage(BuildContext context) {
    if (item.imagePath == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenImage(imagePath: item.imagePath!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = item.imagePath != null;
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            GestureDetector(
              onTap: () => _openImage(context),
              child: Image.file(
                File(item.imagePath!),
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            )
          else
            const SizedBox(
              width: double.infinity,
              height: 240,
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                        onPressed: () async {
                          final updatedItem = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormScreen(item: item),
                            ),
                          );
                          if (updatedItem != null) {
                            context.read<ItemBloc>().add(UpdateItemEvent(updatedItem));
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('Eliminar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Eliminar'),
                              content: const Text('¿Seguro que quieres eliminar este elemento?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    context.read<ItemBloc>().add(DeleteItemEvent(item.id));
                                    Navigator.pop(context); // Cierra diálogo
                                    Navigator.pop(context, true); // Vuelve y refresca
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullScreenImage extends StatelessWidget {
  final String imagePath;
  const _FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imagePath,
            child: Image.file(
              File(imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}