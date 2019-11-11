// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:chorganizer/add_person.dart';

import 'package:chorganizer/models/DBUtils.dart';
import 'package:chorganizer/models/person.dart';
import 'package:chorganizer/models/person_model.dart';

class PeopleList extends StatefulWidget {
  PeopleList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  PeopleListState createState() => PeopleListState();
}

class PeopleListState extends State<PeopleList> {
  List<Person> _people;
  PersonModel _personModel = PersonModel();
  BuildContext _context;

  @override
  initState() {
    super.initState();

    reload(true);
  }

  void reload(bool updateState) {
    _personModel.getAllPeople(null).then((people) {
      if (updateState) {
        setState(() {
          _people = people;
        });
      } else {
        _people = people;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    reload(false);

    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: Builder( // allows us to use the correct context for snackbars
        builder: (context) {
          _context = context;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
              itemCount: _people == null ? 0 : _people.length,
              itemBuilder: (context, index) {
                var person = _people[index];
                return Dismissible(
                  key: Key(person.id.toString()),
                  onDismissed: (direction) {
                    // delete the local data
                    setState(() {
                      _people.removeAt(index);
                    });

                    var name = person.name;

                    // delete the person from the database
                    _removePerson(person);

                    Scaffold
                        .of(_context)
                        .showSnackBar(SnackBar(content: Text("Person '$name' deleted")));
                  },
                  child: ListTile(
                    title: Text(_people[index].name),
                    dense: false,
                  ),
                );
              },
            ),
          );
        },
      ),      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPerson().then((person) {
            if (person != null) { // not cancelled
              Scaffold
                  .of(_context)
                  .showSnackBar(SnackBar(content: Text("Person '${person.name}' added")));
            }
          });
        },
        tooltip: 'Add Person',
        child: Icon(Icons.add),
      ),       
    );
  }

  Future<Person> _addPerson() async {
    Person person = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPersonScreen()),
    );

    if (person != null && person.name != null && person.name.length > 0) {
      // rebuild the widget with the new data
      setState(() {
        _people.add(person);
      });

      // add that person to the database
      DBUtils.init().then((db) {
        _personModel.insertPerson(db, person);
      });
    }

    return person;
  }

  void _removePerson(Person person) {
    _personModel.deletePerson(null, person.id);
  }
}
