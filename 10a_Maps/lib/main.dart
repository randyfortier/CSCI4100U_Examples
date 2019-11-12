// CSCI 4100U - 10a Maps

import 'package:flutter/material.dart';

import 'package:maps_example/map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapsPage(title: 'Maps Example'),
    );
  }
}

class MapsPage extends StatefulWidget {
  MapsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Map(),
    );
  }
}
