// CSCI 4100U - 08 Complete App

import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:chorganizer/models/DBUtils.dart';
import 'package:chorganizer/models/person.dart';

class PersonModel {
  Future<void> insertPerson(Database db, Person person) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    await db.insert('people', person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updatePerson(Database db, Person person) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    await db.update('people', person.toMap(), where: "id = ?", whereArgs: [person.id]);
  }

  Future<void> deletePerson(Database db, int id) async {
    if (db == null) {
      db = await DBUtils.init();
    }
    await db.delete('people', where: "id = ?", whereArgs: [id]);
  }

  Future<List<Person>> getAllPeople(Database db) async {
    if (db == null) {
      db = await DBUtils.init();
    }    
    final List<Map<String, dynamic>> maps = await db.query('people');
    List<Person> people = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        people.add(Person.fromMap(maps[i]));
      }
    }
    return people;
  }

  Future<List<String>> getAllPeopleNames(Database db) async {
    if (db == null) {
      db = await DBUtils.init();
    }    
    final List<Map<String, dynamic>> maps = await db.query('people');
    List<String> peopleNames = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        peopleNames.add(Person.fromMap(maps[i]).name);
      }
    }
    return peopleNames;
  }
}