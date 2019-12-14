import 'package:flutter/material.dart';
import 'package:flutter_start/product_manager.dart';
import './products.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: ProductManager(),
      ),
      
      );
  }
}
