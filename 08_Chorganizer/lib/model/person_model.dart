import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'dbutils.dart';
import 'person.dart';

class PersonModel {
  Future<void> insertPerson(Person person) async {
    var db = await DBUtils.init();
    db.insert(
      'people', 
      person.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );    
  }

  Future<void> updatePerson(Person person) async {
    var db = await DBUtils.init();
    db.update(
      'people', 
      person.toMap(), 
      where: 'id = ?',
      whereArgs: [person.id],
    );    
  }

  Future<void> deletePerson(int id) async {
    var db = await DBUtils.init();
    db.delete(
      'people', 
      where: 'id = ?',
      whereArgs: [id],
    );    
  }

  Future<List<Person>> getAllPeople() async {
    var db = await DBUtils.init();
    final List<Map<String,dynamic>> maps = await db.query('people');
    List<Person> people = [];
    for (int i = 0; i < maps.length; i++) {
      people.add(Person.fromMap(maps[i]));
    }
    return people;
  }

  Future<List<String>> getAllPeopleNames() async {
    var db = await DBUtils.init();
    final List<Map<String,dynamic>> maps = await db.query('people');
    List<String> people = [];
    for (int i = 0; i < maps.length; i++) {
      people.add(maps[i]['name']);
    }
    return people;
  }
}