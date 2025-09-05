import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/item_usecases.dart';
import '../../domain/entities/item_entity.dart';
import '../bloc/item_bloc.dart';
import '../widgets/item_card.dart';
import '../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final ItemUsecases itemUsecases;

  const HomeScreen({
    super.key,
    required this.itemUsecases,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemBloc(
        itemUsecases: itemUsecases,
      )..add(LoadItemsEvent()),
      child: Scaffold(
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
            // Inicializar ItemBloc al comienzo del build para evitar warnings del linter
            final itemBloc = context.read<ItemBloc>();
            
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
                  return ItemCard(
                    item: item,
                    onTap: () async {
                      final refresh = await Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: item,
                      );
                      if (refresh == true) {
                        itemBloc.add(LoadItemsEvent());
                      }
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            // Inicializar ItemBloc para el FloatingActionButton
            final itemBloc = context.read<ItemBloc>();
            
            return FloatingActionButton(
              onPressed: () async {
                final newItem = await Navigator.pushNamed(
                  context,
                  AppRoutes.addItem,
                );
                if (newItem != null && newItem is Item) {
                  itemBloc.add(AddItemEvent(newItem));
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}