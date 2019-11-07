import 'package:flutter/material.dart';

import 'chore_list.dart';

class Menu {
  static List<Widget> createMenu(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.event),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChoreList()
          ));
        },
      ),
      IconButton(
        icon: Icon(Icons.people),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChoreList() // TODO PeopleList()
          ));
        },
      ),
      PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: 'About',
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: null,
                ),
                Text('About'),
              ],
            ),
          ),
        ],
        onSelected: (choice) {
          if (choice == 'About') {
            print('About...');
          }
        },
      ),
    ];
  }
}