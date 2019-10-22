import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'todo.dart';

class TodoModel {
  Future<int> insertTodo(Todo todo) async {
    final db = await DBUtils.init();
    return await db.insert(
      'todo_items',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await DBUtils.init();
    return await db.update(
      'todo_items',
      todo.toMap(), // data to replace with
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'todo_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('todo_items');
    List<Todo> todos = [];
    for (int i = 0; i < maps.length; i++) {
      todos.add(Todo.fromMap(maps[i]));
    }
    return todos;
  }

  Future<Todo> getTodoWithId(int id) async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query(
      'todo_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Todo.fromMap(maps[0]);
    } else {
      return null;
    }
  }
}