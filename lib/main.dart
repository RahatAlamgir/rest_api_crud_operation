import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/pages/products_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api CRUD Operation',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 3, 79, 117)),
      ),
      home: ProductsPage(),
    );
  }
}
