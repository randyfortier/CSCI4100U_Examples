import 'package:flutter/material.dart';

import 'sqlite_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SQLitePage(title: 'SQLite'),
    );
  }
}