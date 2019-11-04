import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'dbutils.dart';
import 'chore.dart';
import 'package:chorganizer/utils/utils.dart' as utils;

class ChoreModel {
  Future<void> insertChore(Chore chore) async {
    var db = await DBUtils.init();
    db.insert(
      'chores', 
      chore.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );    
  }

  Future<void> updateChore(Chore chore) async {
    var db = await DBUtils.init();
    db.update(
      'chores', 
      chore.toMap(), 
      where: 'id = ?',
      whereArgs: [chore.id],
    );    
  }

  Future<void> deleteChore(int id) async {
    var db = await DBUtils.init();
    db.delete(
      'chores', 
      where: 'id = ?',
      whereArgs: [id],
    );    
  }

  Future<List<Chore>> getAllChores() async {
    var db = await DBUtils.init();
    final List<Map<String,dynamic>> maps = await db.query('chores');
    List<Chore> chores = [];
    for (int i = 0; i < maps.length; i++) {
      chores.add(Chore.fromMap(maps[i]));
    }
    return chores;
  }

  Future<List<Chore>> getChoresByDate(DateTime date) async {
    String weekday = utils.getWeekdayNameByIndex(date.weekday);
    String strDate = utils.toDateString(date.year, date.month, date.day);
    var db = await DBUtils.init();
    final List<Map<String,dynamic>> maps = await db.query(
      'chores',
      //columns:
      where: "repeat = 'Daily' OR (repeat = 'None' AND date = ?) OR " +
             "(repeat = 'Weekly' AND $weekday = 1)",
      whereArgs: [strDate],
      orderBy: 'time', 
    );
    List<Chore> chores = [];
    for (int i = 0; i < maps.length; i++) {
      chores.add(Chore.fromMap(maps[i]));
    }
    return chores;
  }

}