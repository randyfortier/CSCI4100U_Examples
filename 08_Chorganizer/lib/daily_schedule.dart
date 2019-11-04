import 'package:flutter/material.dart';

import 'model/chore_model.dart';
import 'model/chore.dart';

class DailySchedule extends StatefulWidget {
  DailySchedule({Key key}) : super(key: key);

  @override
  _DailyScheduleState createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  DateTime _date = DateTime.now();
  List<Chore> _chores;
  final _choreModel = ChoreModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Schedule'),
        // TODO: Menu
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    iconSize: 50.0,
                    onPressed: () {
                      setState(() {
                        _date = _date.subtract(Duration(days: 1));
                      });
                    },
                  ),
                  Text(
                    'DATE'
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    iconSize: 50.0,
                    onPressed: () {
                      setState(() {
                        _date = _date.add(Duration(days: 1));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}