import 'package:flutter/material.dart';

import 'model/todo_model.dart';
import 'model/todo.dart';

class SQLitePage extends StatefulWidget {
  String title;

  SQLitePage({this.title, Key key}) : super(key: key);

  _SQLitePageState createState() => _SQLitePageState();
}

class _SQLitePageState extends State<SQLitePage> {
  var _todoItem;
  var _lastInsertedId = 0;
  final _model = TodoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (newValue) {
                _todoItem = newValue;
              },
            ),
            RaisedButton(
              child: Text('Insert'),
              color: Colors.blue,
              onPressed: _addTodo,
            ),
            RaisedButton(
              child: Text('Update'),
              color: Colors.blue,
              onPressed: _updateTodo,
            ),
            RaisedButton(
              child: Text('Delete'),
              color: Colors.blue,
              onPressed: _deleteTodo,
            ),
            RaisedButton(
              child: Text('List all Todos'),
              color: Colors.blue,
              onPressed: _listTodos,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addTodo() async {
    Todo newTodo = Todo(name: _todoItem);
    _lastInsertedId = await _model.insertTodo(newTodo);
  }

  Future<void> _updateTodo() async {
    Todo todoToUpdate = Todo(
      id: _lastInsertedId,
      name: _todoItem
    );
    _model.updateTodo(todoToUpdate);
  }

  Future<void> _deleteTodo() async {
    _model.deleteTodo(_lastInsertedId);
  }

  Future<void> _listTodos() async {
    List<Todo> todos = await _model.getAllTodos();
    print('To Dos:');
    for (Todo todo in todos) {
      print(todo);
    }
  }
}