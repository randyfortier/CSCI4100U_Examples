// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:chorganizer/Notifications.dart';
import 'package:chorganizer/utils.dart';

import 'package:chorganizer/add_chore.dart';

import 'package:chorganizer/models/DBUtils.dart';
import 'package:chorganizer/models/chore.dart';
import 'package:chorganizer/models/chore_model.dart';

class ChoreList extends StatefulWidget {
  ChoreList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ChoreListState createState() => ChoreListState();
}

class ChoreListState extends State<ChoreList> {
  List<Chore> _chores;
  final _choreModel = ChoreModel();
  final _notifications = Notifications();
  BuildContext _context;

  @override
  initState() {
    super.initState();

    reload();
  }

  void reload() {
    _choreModel.getAllChores(null).then((chores) {
      setState(() {
        _chores = chores;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // prepare the notification utility class
    _notifications.init(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Chores'),
      ),
      body: Builder( // allows us to use the correct context for snackbars from the FAB
        builder: (context) {
          _context = context;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
              itemCount: _chores == null ? 0 : _chores.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_chores[index].id.toString()),
                  onDismissed: (direction) { 
                    var chore = _chores[index];

                    _deleteChore(index); 

                    Scaffold.of(_context).showSnackBar(
                      SnackBar(
                        content: Text("Chore '${chore.name}' deleted"),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            _undeleteChore(index, chore);
                          }
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(notNull(_chores[index].icon)),
                    title: Text(notNull(_chores[index].name)),
                    subtitle: Text(notNull(_chores[index].assignedTo)),
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
          _addChore().then((chore) {
            if (chore != null) { // not cancelled
              Scaffold
                  .of(_context)
                  .showSnackBar(SnackBar(content: Text("Chore '${chore.name}' added")));
            }
          });
        },
        tooltip: 'Add Chore',
        child: Icon(Icons.add),
      ), 
    );
  }

  void _undeleteChore(int index, Chore chore) {
    if (index <= _chores.length) {
      setState(() {
        _chores.insert(index, chore);
      });

      print('_chores.length: ${_chores.length}');

      _choreModel.insertChore(null, chore);
    }
  }

  void _deleteChore(int index) {
    if (index < _chores.length) {
      _notifications.cancelNotification(_chores[index].id);
    }

    if (index < _chores.length) {
      int id = _chores[index].id;

      setState(() {
        _chores.removeAt(index);
      });

      _choreModel.deleteChore(null, id);
    }
  }

  Future<Chore> _addChore() async {
    Chore chore = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddChoreScreen()),
    );

    if (chore != null) {
      // add the chore to the database
      DBUtils.init().then((db) {
        _choreModel.insertChore(db, chore).then((insertedId) {
          chore.id = insertedId;

          // schedule notifications
          if (chore.repeat == null || chore.repeat == 'None') {
            _setOneTimeNotification(chore);
          } else if (chore.repeat == 'Daily') {
            _setDailyNotification(chore);
          } else if (chore.repeat == 'Weekly') {
            if (chore.sunday != 0) {
              _setWeeklyNotification(chore, Day.Sunday);
            }
            if (chore.monday != 0) {
              _setWeeklyNotification(chore, Day.Monday);
            }
            if (chore.tuesday != 0) {
              _setWeeklyNotification(chore, Day.Tuesday);
            }
            if (chore.wednesday != 0) {
              _setWeeklyNotification(chore, Day.Wednesday);
            }
            if (chore.thursday != 0) {
              _setWeeklyNotification(chore, Day.Thursday);
            }
            if (chore.friday != 0) {
              _setWeeklyNotification(chore, Day.Friday);
            }
            if (chore.saturday != 0) {
              _setWeeklyNotification(chore, Day.Saturday);
            }
          }
          
          // force reload of the chores
          setState(() {
            // add the chore to the local list
            _chores.add(chore);
          });
        });
      });
    }
    return chore;
  }

  Future<int> _setOneTimeNotification(Chore chore) async {
    var date = stringToDate(chore.date);
    var time = stringToTime(chore.time);
    var sendDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return await _notifications.sendNotificationLater(
      chore.id,
      chore.name, 
      '${chore.name}: ${chore.assignedTo}',
      sendDate,
      chore.id.toString(),
    );
  }

  Future<int> _setDailyNotification(Chore chore) async {
    return await _notifications.scheduleDailyNotification(
      chore.id,
      chore.name, 
      '${chore.name}: ${chore.assignedTo}',
      stringToTime(chore.time),
      chore.id.toString(),
    );
  }

  Future<int> _setWeeklyNotification(Chore chore, Day dayOfWeek) async {
    return await _notifications.scheduleWeeklyNotification(
      chore.id,
      chore.name, 
      '${chore.name}: ${chore.assignedTo}',
      dayOfWeek,
      stringToTime(chore.time),
      chore.id.toString(),
    );
  }
}
