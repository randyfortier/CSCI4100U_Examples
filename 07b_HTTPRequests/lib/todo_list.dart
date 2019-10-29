import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/todo.dart';

class TodoList extends StatefulWidget {
  final String title;

  TodoList({Key key, this.title}) : super(key: key);

  @override 
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> _todos;

  @override 
  void initState() {
    super.initState();

    _loadTodos();
  }

  Future<void> _loadTodos() async {
    var response = await http.get('http://jsonplaceholder.typicode.com/todos');

    if (response.statusCode == 200) {
      setState(() {
        _todos = [];

        List data = jsonDecode(response.body);
        for (var item in data) {
          _todos.add(Todo.fromMap(item));
        }
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete the 'to do'
              List<Todo> newTodos = [];
              for (var todo in _todos) {
                if (!todo.completed) {
                  newTodos.add(todo);
                } else {
                  http.delete('http://jsonplaceholder.typicode.com/todos/${todo.id}');
                }
              }
              setState(() {
                _todos = newTodos;
              });
            }
          ),
        ],
      ),
      body: _createTodoList(),
    );
  }

  Widget _createTodoList() {
    return ListView.builder(
      itemCount: _todos != null ? _todos.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_todos[index].title),
          subtitle: Text('${_todos[index].userId}'),
          leading: Checkbox(
            value: _todos[index].completed,
            onChanged: (bool newValue) {
              setState(() {
                _todos[index].completed = newValue;
              });
            }
          ),
        );
      }
    );
  }
}