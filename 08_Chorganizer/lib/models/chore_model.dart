// CSCI 4100U - 08 Complete App

import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:chorganizer/utils.dart';

import 'package:chorganizer/models/DBUtils.dart';
import 'package:chorganizer/models/chore.dart';

class ChoreModel {
  var database;

  Future<int> insertChore(Database db, Chore chore) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    return await db.insert('chores', chore.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateChore(Database db, Chore chore) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    await db.update('chores', chore.toMap(), where: "id = ?", whereArgs: [chore.id]);
  }

  Future<void> deleteChore(Database db, int id) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    await db.delete('chores', where: "id = ?", whereArgs: [id]);
  }

  Future<List<Chore>> getAllChores(Database db) async {
    if (db == null) {
      db = await DBUtils.init();
    }    
    final List<Map<String, dynamic>> maps = await db.query('chores');
    List<Chore> chores = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        chores.add(Chore.fromMap(maps[i]));
      }
    }
    return chores;
  }

  Future<List<Chore>> getChoresByDate(Database db, DateTime date) async {
    String weekday = getWeekdayNameByIndex(date.weekday);
    String strDate = toDateString(date.year, date.month, date.day);

    if (db == null) {
      db = await DBUtils.init();
    }    
    final List<Map<String, dynamic>> maps = await db.query(
      'chores',
      columns: ['id', 'name', 'assignedTo', 'icon', 'repeat', 'date', 'time', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'],
      where: "repeat = 'Daily' OR (repeat = 'None' AND date = ?) OR (repeat = 'Weekly' AND $weekday = 1)",
      whereArgs: [strDate],
      orderBy: 'time',
    );
    List<Chore> chores = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        chores.add(Chore.fromMap(maps[i]));
      }
    }
    return chores;
  }
}