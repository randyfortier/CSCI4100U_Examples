// CSCI 4100U - 08 Complete App

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'chorganizer.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE chores(id INTEGER PRIMARY KEY, name TEXT, assignedTo TEXT, icon TEXT, repeat TEXT, date TEXT NULL, time TEXT NULL, sunday INTEGER, monday INTEGER, tuesday INTEGER, wednesday INTEGER, thursday INTEGER, friday INTEGER, saturday INTEGER)");
        db.execute("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT)");
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

}