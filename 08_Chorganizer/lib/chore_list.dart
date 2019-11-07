import 'package:flutter/material.dart';

import 'utils/utils.dart';

import 'model/dbutils.dart';
import 'model/chore.dart';
import 'model/chore_model.dart';

class ChoreList extends StatefulWidget {
  final String title;

  ChoreList({Key key, this.title}) : super(key: key);

  @override 
  ChoreListState createState() => ChoreListState();
}

class ChoreListState extends State<ChoreList> {
  List<Chore> _chores;
  ChoreModel _choreModel;
  BuildContext _context;

  @override 
  initState() {
    super.initState();

    _reload();
  }

  void _reload() {
    _choreModel = ChoreModel();
    _choreModel.getAllChores().then((chores) {
      setState(() {
        _chores = chores;
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chores'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _context = context;
          return Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ListView.builder(
              itemCount: _chores != null ? _chores.length : 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_chores[index].id.toString()),
                  child: ListTile(
                    title: Text(_chores[index].name),
                    subtitle: Text(_chores[index].assignedTo),
                    dense: false,
                  ),
                  onDismissed: (direction) {
                    Chore chore = _chores[index];

                    _deleteChore(index);

                    Scaffold.of(_context).showSnackBar(SnackBar(
                      content: Text("Chore '${chore.name}' deleted."),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          _undeleteChore(index, chore);
                        },
                      ),
                    ));
                  },
                );
              }
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add chore
          _addChore().then((chore) {
              Scaffold.of(_context).showSnackBar(SnackBar(
                content: Text("Chore '${chore.name}' added."),
              ));
          });
        }
      ),
    );
  }

  Future<Chore> _addChore() async {
    
  }

  void _deleteChore(int index) {
    if (index < _chores.length) {
      int id = _chores[index].id;

      // delete from local list
      setState(() {
        _chores.removeAt(index);
      });

      // delete from the DB
      _choreModel.deleteChore(id);
    }
  }

  void _undeleteChore(int index, Chore chore) {
    if (index <= _chores.length) {
      // add back to local list
      setState(() {
        _chores.insert(index, chore);
      });

      // add back to DB
      _choreModel.insertChore(chore);
    }
  }
}