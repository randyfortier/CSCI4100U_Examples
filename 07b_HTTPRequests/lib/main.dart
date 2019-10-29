import 'package:flutter/material.dart';

import 'todo_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Requests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(title: 'HTTP Requests'),
    );
  }
}
