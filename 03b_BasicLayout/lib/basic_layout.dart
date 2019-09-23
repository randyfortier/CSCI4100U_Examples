import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

class BasicLayout extends StatefulWidget {
  BasicLayout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BasicLayoutState createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _buildStackWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStackWidget() {
    return Stack(
      alignment: const Alignment(1.0, -0.5),
      children: <Widget>[
        CircleAvatar(
          radius: 100.0,
          backgroundColor: Colors.blue,
          child: Text('RF', textScaleFactor: 4.0),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text(
              'CSCI 4100U', 
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlutterLogo(
          size: 40.0,
          colors: Colors.red,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.green,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.blue,
        ),
        FlutterLogo(
          size: 40.0,
          colors: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildRowWidget() {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80.0,
            color: Colors.red,
          ),
          Container(
            width: 80.0,
            color: Colors.green,
          ),
          Container(
            width: 80.0,
            color: Colors.blue,
          ),
          Container(
            width: 80.0,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
