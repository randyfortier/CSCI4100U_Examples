// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:chorganizer/models/person.dart';

class AddPersonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chorganizer:  Add Person'),
      ),
      body: AddPerson(),
    );
  }
}

class AddPerson extends StatefulWidget {
  @override
  AddPersonState createState() {
    return AddPersonState();
  }
}

class AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();
  final _person = Person();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.assignment),
              title: Text('Person name:'),
              subtitle: TextFormField(
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _person.name = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save(); // load form values into _Person

                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Person '${_person.name}' Added")));

                    Navigator.pop(context, _person);
                  }
                },
                child: Text('Add Person'),
                color: Colors.deepPurple,
                textColor: Colors.white,
              ))
            ),
          ],
        ),
      ),
    ); 
  }
}
