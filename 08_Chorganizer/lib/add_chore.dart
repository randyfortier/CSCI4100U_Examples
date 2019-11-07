import 'package:flutter/material.dart';

import 'utils/utils.dart' as util;
import 'model/chore.dart';
import 'model/person_model.dart';

class AddChoreScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chorganzr: Add Chore'),
      ),
      body: AddChore(),
    );
  }
}

class AddChore extends StatefulWidget {
  @override 
  AddChoreState createState() {
    return AddChoreState();
  }
}

class AddChoreState extends State<AddChore> {
  final _formKey = GlobalKey<FormState>();
  final _personModel = PersonModel();

  var _chore;
  List<String> _peopleNames = [];
  bool _showDayOfWeek = false;
  bool _showDate = true;

  initState() {
    super.initState();

    _loadPeopleNames();
  }

  void _loadPeopleNames() {
    _personModel.getAllPeopleNames().then((names) {
      setState(() {
        _peopleNames = names;
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    var now = DateTime.now();

    if (_chore == null) {
      _chore = Chore();
      _chore.date = util.toDateString(now.year, now.month, now.day);
      _chore.time = util.toTimeString(now.hour, now.minute);
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Chore name',
                  labelText: 'Name:',
                ),
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _chore.name = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Assigned to:'),
                  value: _chore.assignedTo,
                  items: _peopleNames.map<DropdownMenuItem>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _chore.assignedTo = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Repeat interval:'),
                  value: _chore.repeat,
                  items: ['None', 'Daily', 'Weekly'].map<DropdownMenuItem>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _updateRepeat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateRepeat(String value) {
    setState(() {
      _chore.repeat = value;

      if (value == 'Weekly') {
        _showDayOfWeek = true;
      } else {
        _showDayOfWeek = false;
      }

      if (value == null || value == 'None') {
        _showDate = true;
      } else {
        _showDate = false;
      }
    });
  }
}