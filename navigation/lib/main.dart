import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class CustomDialog extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.lightBlue,
      child: buildGridView(),
    );
  }
}

Widget buildGridView() {
  return GridView.count(
    primary: false,
    padding: const EdgeInsets.all(20.0),
    mainAxisSpacing: 2.0,
    crossAxisSpacing: 2.0,
    crossAxisCount: 3,
    children: buildGridViewItems(27),
  );
}

List<Widget> buildGridViewItems(int count) {
  List<Widget> itemList = [];

  for (int i = 0; i < count; i++) {
    Color colour = Colors.blue[100 + i * 100];
    if ((i >= 9) && (i < 18)) {
      colour = Colors.red[100 + (i-9) * 100];
    } else if (i >= 18) {
      colour = Colors.green[100 + (i-18) * 100];
    }

    itemList.add(Container(
      height: 50,
      color: colour,
      child: Text('Entry ${i+1}'),
    ));
  }

  return itemList;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _simpleDialog(context);
        },
        tooltip: 'Show Dialog',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _customDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog();
      },
    );
  }

  void _aboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Navigation Demo',
      applicationVersion: 'Version 0.0.1',
      children: [
        Text('Navigation Demo'),
        Text('Copyright 2019 - Randy Fortier'),
      ],
    );
  }

  Future<void> _simpleDialog(BuildContext context) async {
    var veganRequired = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Vegan meal?'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            SimpleDialogOption(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
    print('Vegan required: $veganRequired');
  }
}
