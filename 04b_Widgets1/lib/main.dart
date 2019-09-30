import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widgets 1'),
        ),
        body: RegistrationForm(),
      )
    );
  }
}

class RegistrationForm extends StatefulWidget {
  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _country;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'someone@email.com',
              labelText: 'E-Mail',
            ),
            onSaved: (String value) {
              print('Saving E-Mail $value');
              _email = value;
            },
            validator: (String value) {
              print('Validating E-Mail $value');
              if (value.length == 0) {
                return 'Invalid E-Mail address';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            onSaved: (String value) {
              print('Saving $value');
              _password = value;
            },
            validator: (String value) {
              print('Validating $value');
              if (value.length == 0) {
                return 'Invalid password';
              } else {
                return null;
              }
            },
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Country',
            ),
            value: _country,
            items: <String>['Canada', 'USA']
              .map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            onChanged: (String newValue) {
              setState(() {
                _country = newValue;
              });
              print('Setting value to $_country');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text('Sign-up'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Registering...'),
                  ));
                  _formKey.currentState.save();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
