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
        child: Column(
          children: <Widget>[
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    print('Ok Pressed');
                  }
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    print('Cancel Pressed');
                  }
                ),
              ],
            ),
            Text(_pages[_pageIndex].title),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.blue[100 + (index * 100)],
                child: Center(
                  child: FlatButton(
                    child: Text('Item #${index + 1}'),
                    onPressed: () {
                      print('Item #${index + 1} pressed');
                    }
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _pages.map((NavPage page) {
          return BottomNavigationBarItem(
            icon: Icon(page.icon),
            title: Text(page.title),
          );
        }).toList(),
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB pressed');
        },
        tooltip: 'Do the thing!',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
