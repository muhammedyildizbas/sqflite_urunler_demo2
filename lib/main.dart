

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_urunler_demo2/screens/product_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
  
}

