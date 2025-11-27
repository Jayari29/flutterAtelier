import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_init.dart';
import 'providers/cart_provider.dart';
import 'pages/product_list_page.dart';

Future<void> main() async {
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Atelier 6 - E-Commerce',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        home: const ProductListPage(),
      ),
    );
  }
}
