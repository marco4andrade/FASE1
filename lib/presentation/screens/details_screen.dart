import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/item_usecases.dart';
import '../bloc/item_bloc.dart';
import '../../core/routes/app_routes.dart';
import 'dart:io';

class DetailsScreen extends StatelessWidget {
  final Item item;
  final ItemUsecases itemUsecases;

  const DetailsScreen({super.key, required this.item, required this.itemUsecases});

  Widget _buildImage(String imagePath, {double? width, double? height}) {
    
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, size: 100, color: Colors.grey);
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, size: 100, color: Colors.grey);
        },
      );
    }
  }

  void _openImage(BuildContext context) {
    if (item.imagePath == null) return;
    Navigator.pushNamed(
      context,
      AppRoutes.fullScreenImage,
      arguments: item.imagePath!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = item.imagePath != null;
    return BlocProvider(
      create: (_) => ItemBloc(itemUsecases: itemUsecases),
      child: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemUpdated) {
            Navigator.pop(context, true);
          }
          if (state is ItemDeleted) {
            Navigator.pop(context, true);
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: Text(item.title)),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage)
                    GestureDetector(
                      onTap: () => _openImage(context),
                      child: _buildImage(
                        item.imagePath!,
                        width: double.infinity,
                        height: 240,
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
                                  final updatedItem = await Navigator.pushNamed(
                                    context,
                                    AppRoutes.editItem,
                                    arguments: item,
                                  );
                                  if (updatedItem != null && updatedItem is Item) {
                                    context.read<ItemBloc>().add(UpdateItemEvent(updatedItem));
                                    // El BlocListener se encargará de volver a HomeScreen
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
                                            Navigator.pop(context); // Solo cerrar el diálogo
                                            // El BlocListener se encargará de volver a HomeScreen
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
          },
        ),
      ),
    );
  }
}