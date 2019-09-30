import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets 2',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Widgets 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class NavPage {
  String title;
  IconData icon;

  NavPage({this.title, this.icon});
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _menuItems = [
    'Open',
    'Save',
    'Exit',
  ];

  List<NavPage> _pages = [
    NavPage(title: 'Add to Cart', icon: Icons.add_shopping_cart),
    NavPage(title: 'Saved Lists', icon: Icons.save),
    NavPage(title: 'Checkout', icon: Icons.card_membership),
  ];
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () { print('add to cart'); }
          ),
          IconButton(
            icon: Icon(Icons.remove_shopping_cart),
            onPressed: () { print('remove from cart'); }
          ),
          PopupMenuButton<String>(
            onSelected: (String item) {
              print('Selected $item');
            },
            itemBuilder: (BuildContext context) {
              return _menuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
