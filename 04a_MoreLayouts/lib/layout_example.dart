import 'package:flutter/material.dart';

class LayoutExample {
  final String title;
  final IconData icon;
  final Function builder;

  const LayoutExample({this.title, this.icon, this.builder});
}

Widget buildTabBar(List<LayoutExample> options) {
  return TabBar(
    isScrollable: true,
    tabs: options.map<Widget>((LayoutExample option) {
      return Tab(
        text: option.title,
        icon: Icon(option.icon),
      );
    }).toList(),
  );
}

Widget buildTabBarView(List<LayoutExample> options) {
  return TabBarView(
    children: options.map<Widget>((LayoutExample option) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          child: option.builder(),
        ),
      );
    }).toList(),
  );  
}

Widget buildStackWidget() {
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

Widget buildColumnWidget() {
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

Widget buildRowWidget() {
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

Widget buildListView() {
  return ListView.separated(
    padding: const EdgeInsets.all(8.0),
    itemCount: 9,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.blue[100 + 100 * index],
        child: Text('Entry ${index + 1}'),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    }
  );
}