// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:chorganizer/chore_list.dart';
import 'package:chorganizer/person_list.dart';

class Menu {
  static List<Widget> createMenu(BuildContext context) {
    return <Widget> [
      IconButton(
        icon: Icon(Icons.event),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChoreList()),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.people),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PeopleList()),
          );
        },
      ),
      // overflow menu
      PopupMenuButton<String>(
        onSelected: (choice) {
          if (choice == 'About') {
            showAboutDialog(
              context: context, 
              applicationName: 'Chorganizer', 
              applicationVersion: 'v0.9', 
              applicationIcon: Image.asset('assets/app_icon.png', width: 80), 
              applicationLegalese: 'License: Apache 2.0', 
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: Image.asset('assets/tree-10-64.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text('Yggdrasil Software Inc.'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text('Icons by Icons8 (icons8.com)', textScaleFactor: 0.7,),
                    ),
                  ],
                ),
              ],
            );  
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: 'About',
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  
                  onPressed: () {
                  },
                ),
                Text('About'),
              ]
            ),
          ),
        ],
      ),
    ];
  }
}
