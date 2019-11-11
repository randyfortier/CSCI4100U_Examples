// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:chorganizer/utils.dart';

import 'package:chorganizer/menu.dart';

import 'package:chorganizer/models/chore.dart';
import 'package:chorganizer/models/chore_model.dart';

class DailySchedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyScheduleState();
  }
}

class _DailyScheduleState extends State<DailySchedule> {
  final _choreModel = ChoreModel();
  List<Chore> _chores;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _reload();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Schedule'),
        actions: Menu.createMenu(context),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    iconSize: 50.0,
                    onPressed: () {
                      setState(() {
                        _date = _date.subtract(Duration(days: 1));
                      });
                      _reload();
                    },
                  ),
                  Expanded(child: Text(
                    toDateString(_date.year, _date.month, _date.day), 
                    textScaleFactor: 2.0,
                    textAlign: TextAlign.center,
                  )),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    iconSize: 50.0,
                    onPressed: () {
                      setState(() {
                        _date = _date.add(Duration(days: 1));
                      });
                      _reload();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _chores == null ? 0 : _chores.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.all(16.0), child: Image.asset(notNull(_chores[index].icon), scale: 2.0,)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: getWidgets(_chores[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getWidgets(Chore chore) {
    List<Widget> results = [];

    if (chore.name != null) {
      results.add(Align(alignment: Alignment.centerLeft, child: Text(chore.name, textAlign: TextAlign.left, textScaleFactor: 2.0,)));
    }
    if (chore.assignedTo != null) {
      results.add(Align(alignment: Alignment.centerLeft, child: Text(chore.assignedTo, textAlign: TextAlign.left, textScaleFactor: 1.5,)));
    }
    if (chore.repeat != null) {
      String repeatMessage = chore.repeat;
      if (chore.repeat == 'Daily' || chore.repeat == 'Weekly') {
        if (chore.time != null) {
          repeatMessage += ' @ ' + chore.time;
        }        
        results.add(Align(alignment: Alignment.centerLeft, child: Text(repeatMessage, textAlign: TextAlign.left,)));
        if (chore.repeat == 'Weekly') {
          String weeklyMessage = chore.getWeekdaySummary();
          results.add(Align(alignment: Alignment.centerLeft, child: Text(weeklyMessage, textAlign: TextAlign.left,)));
        }
      } else {
        results.add(Align(alignment: Alignment.centerLeft, child: Text('Not repeated', textAlign: TextAlign.left,)));
        String dateTimeMessage = '';
        if (chore.date != null) {
          dateTimeMessage = chore.date;
        }
        if (chore.time != null) {
          dateTimeMessage += ' @ ' + chore.time;
        }
        results.add(Align(alignment: Alignment.centerLeft, child: Text(dateTimeMessage, textAlign: TextAlign.left,)));
      }
    }
    return results;
  }

  void _reload() {
    // get the correct day's chores
    _choreModel.getChoresByDate(null, _date).then((chores) {
      setState(() {
        _chores = chores;
      });
    });
  }
}