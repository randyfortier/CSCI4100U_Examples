import 'package:flutter/material.dart';

import 'basic_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BasicLayout(title: 'Basic Layout'),
    );
  }
}