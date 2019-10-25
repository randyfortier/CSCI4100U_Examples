// CSCI 4100U - 07a Cloud Storage

import 'package:flutter/material.dart';

import 'product_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Cloud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(title: 'Firestore Cloud'),
    );
  }
}
