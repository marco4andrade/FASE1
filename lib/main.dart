import 'package:flutter/material.dart';
import 'data/repositories/item_repository_impl.dart';
import 'domain/usecases/item_usecases.dart';
import 'presentation/screens/home_screen.dart';

final itemRepository = ItemRepositoryImpl();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(
              getItems: GetItems(itemRepository),
              addItem: AddItem(itemRepository),
              updateItem: UpdateItem(itemRepository),
              deleteItem: DeleteItem(itemRepository),
            ),
      },
    );
  }
}