import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/item_usecases.dart';
import '../bloc/item_bloc.dart';
import 'form_screen.dart';
import 'details_screen.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  final GetItems getItems;
  final AddItem addItem;
  final UpdateItem updateItem;
  final DeleteItem deleteItem;

  const HomeScreen({
    super.key,
    required this.getItems,
    required this.addItem,
    required this.updateItem,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemBloc(
        getItems: getItems,
        addItem: addItem,
        updateItem: updateItem,
        deleteItem: deleteItem,
      )..add(LoadItemsEvent()),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Elementos')),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ItemCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elemento agregado')),
            );
          }
          if (state is ItemUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elemento actualizado')),
            );
          }
          if (state is ItemDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elemento eliminado')),
            );
          }
        },
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ItemLoaded) {
            if (state.items.isEmpty) {
              return const Center(child: Text('No hay elementos.'));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Card(
                  child: ListTile(
                    leading: item.imagePath != null
                        ? Image.file(
                            File(item.imagePath!),
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image, size: 40),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    onTap: () async {
                      final refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ItemBloc>(),
                            child: DetailsScreen(item: item),
                          ),
                        ),
                      );
                      if (refresh == true) {
                        context.read<ItemBloc>().add(LoadItemsEvent());
                      }
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormScreen(),
            ),
          );
          if (newItem != null) {
            context.read<ItemBloc>().add(AddItemEvent(newItem));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}