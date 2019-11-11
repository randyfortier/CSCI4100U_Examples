// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:transparent_image/transparent_image.dart';

import 'package:chorganizer/utils.dart';
import 'package:chorganizer/models/chore.dart';
import 'package:chorganizer/models/person_model.dart';

import 'package:chorganizer/select_icon.dart';

class AddChoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chorganizer:  Add Chore'),
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
  final _formKey = GlobalKey<FormState>(); // identified the form
  final _personModel = PersonModel();

  var _chore;
  var _iconImage = 'assets/icons8-info-100.png'; // default
  List<String> _peopleNames = [];
  bool _showDayOfWeek = false;
  bool _showDate = true;

  void initPeopleNames() {
    _personModel.getAllPeopleNames(null).then((peopleNames) {
      setState(() {
        _peopleNames = peopleNames;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    // load the people's names for assigning chores to
    initPeopleNames();

    // initialize some of the chore's values
    if (_chore == null) {
      _chore = Chore();
      _chore.icon = _iconImage;
      _chore.date = toDateString(now.year, now.month, now.day);
      _chore.time = toTimeString(now.hour, now.minute);
    }

    var today = now.subtract(Duration(hours: now.hour, minutes: now.minute, seconds: now.second));

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: const InputDecoration( // label
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
                onSaved: (value) => setState(() => _chore.name = value),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: DropdownButtonHideUnderline(
                // this is to make the dropdown take the full width
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    hint: Text('Assigned to:'),
                    value: _chore.assignedTo,
                    items: _peopleNames
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                    onChanged: (value) => setState(() { _chore.assignedTo = value; }),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Icon:'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  RaisedButton(
                    onPressed: () {
                      /*
                      var image = ImagePicker.pickImage(
                        source: ImageSource.gallery
                      );
                      image.then((filename) => _chore.icon = filename.toString());
                      */
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return IconSelector.getIconSelectorDialog(context);
                        }
                      ).then((selectedIcon) {
                        setState(() {
                          _iconImage = selectedIcon;
                          _chore.icon = selectedIcon;
                        });
                      });
                    },
                    child: Text('Select'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                  Expanded(child: Image.asset(_iconImage, height: 50)),
                ]
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: DropdownButtonHideUnderline(
                child:  ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    hint: Text('Repeat interval:'),
                    value: _chore.repeat,
                    items: ['None', 'Daily', 'Weekly']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                    onChanged: _updateRepeat,
                  ),
                ),
              ),
            ),
            !_showDate ? Container() : ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Date:'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  RaisedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: today,
                        lastDate: DateTime(2100),
                        initialDate: now,
                      ).then((value) {
                        setState(() {
                          _chore.date = toDateString(value.year, value.month, value.day);
                        });
                      });
                    },
                    child: Text('Select'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(_chore == null || _chore.date == null ? toDateString(now.year, now.month, now.day) : _chore.date),
                    ),
                  ),
                ]
              )
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Time:'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  RaisedButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                      ).then((value) {
                        setState(() {
                          _chore.time = toTimeString(value.hour, value.minute);
                        });
                      });
                    },
                    child: Text('Select'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(_chore.time),
                    ),
                  ),
                ]
              )
            ),
            !_showDayOfWeek ? Container() : ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Days of week:'),
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Sunday')),
                      Checkbox(
                        value: _chore.sunday == null || _chore.sunday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.sunday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Monday')),
                      Checkbox(
                        value: _chore.monday == null || _chore.monday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.monday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Tuesday')),
                      Checkbox(
                        value: _chore.tuesday == null || _chore.tuesday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.tuesday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Wednesday')),
                      Checkbox(
                        value: _chore.wednesday == null || _chore.wednesday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.wednesday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Thursday')),
                      Checkbox(
                        value: _chore.thursday == null || _chore.thursday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.thursday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Friday')),
                      Checkbox(
                        value: _chore.friday == null || _chore.friday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.friday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(child: Text('Saturday')),
                      Checkbox(
                        value: _chore.saturday == null || _chore.saturday == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            _chore.saturday = value == null || value == false ? 0 : 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save(); // load form values into _chore

                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Chore '${_chore.name}' Added")));

                    Navigator.pop(context, _chore);
                  }
                },
                child: Text('Add Chore'),
                color: Colors.deepPurple,
                textColor: Colors.white,
              ))
            ),
          ],
        ),
      ),
    ); 
  }

  void _updateRepeat(String value) {
    // update the repeat value
    setState(() { 
      _chore.repeat = value; 

      // for weekly repeats, show the day of week
      if (value == 'Weekly') {
        _showDayOfWeek = true;
      } else {
        _showDayOfWeek = false;
      }

      // for non-repeated events, show the date selector
      if (value == null || value == 'None') {
        _showDate = true;
      } else {
        _showDate = false;
      }
    });
  }
}
