import 'package:flutter/material.dart';

import 'layout_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Widgets 1'),
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
  @override
  Widget build(BuildContext context) {
    const List<LayoutExample> options = const <LayoutExample>[
      const LayoutExample(
        title: 'Column',
        icon: Icons.view_column,
        builder: buildColumnWidget,
      ),
      const LayoutExample(
        title: 'Row',
        icon: Icons.reorder,
        builder: buildRowWidget,
      ),
      const LayoutExample(
        title: 'Stack',
        icon: Icons.filter_none,
        builder: buildStackWidget,
      ),
      const LayoutExample(
        title: 'ListView',
        icon: Icons.view_list,
        builder: buildListView,
      ),
      const LayoutExample(
        title: 'GridView',
        icon: Icons.grid_on,
        builder: buildGridView,
      ),
    ];
    return DefaultTabController(
      length: options.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: buildTabBar(options),
        ),
        body: buildTabBarView(options),
      ),
    );
  }
}
