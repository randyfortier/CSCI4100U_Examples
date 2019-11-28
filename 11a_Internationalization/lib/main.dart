import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i18n',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'i18n'),
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'en',
          path: 'assets/i18n',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _username;
  String _password;
  bool _validLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Text('EN'),
            onPressed: () {
              Locale newLocale = Locale('en');
              setState(() {
                FlutterI18n.refresh(context, newLocale);
              });
            },
          ),
          FlatButton(
            child: Text('PT'),
            onPressed: () {
              Locale newLocale = Locale('pt');
              setState(() {
                FlutterI18n.refresh(context, newLocale);
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              _validLogin ? FlutterI18n.translate(
                context, 
                'login.loginsuccess',
                {'username': _username},
              ) : FlutterI18n.translate(
                context, 
                'login.loginincorrect',
              )
            ),
          ),
          ListTile(
            leading: Text(FlutterI18n.translate(context, 'login.username')),
            title: TextField(
              controller: TextEditingController(text: _username),
              onChanged: (value) { _username = value; }
            ),
          ),
          ListTile(
            leading: Text(FlutterI18n.translate(context, 'login.password')),
            title: TextField(
              controller: TextEditingController(text: _password),
              onChanged: (value) { _password = value; }
            ),
          ),
          ListTile(
            title: FlatButton(
              child: Text(FlutterI18n.translate(context, 'login.login')),
              onPressed: () {
                if (_username == 'admin' && _password == '12345') {
                  setState(() {
                    _validLogin = true;
                  });
                } else {
                  setState(() {
                    _validLogin = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
