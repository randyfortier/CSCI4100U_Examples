// CSCI 4100U - 06a Notifications

import 'package:flutter/material.dart';

import 'notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Notifications'),
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
  var _notifications = Notifications();

  @override
  Widget build(BuildContext context) {
    _notifications.init();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timer_3),
            onPressed: _notificationLater,
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _notificationNow,
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _showPendingNotifications,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }

  void _notificationNow() {
    _notifications.sendNotificationNow('title', 'body', 'payload');
  }

  Future<void> _notificationLater() async {
    var when = DateTime.now().add(Duration(seconds: 3));
    await _notifications.sendNotificationLater('title', 'body', when, 'payload');
  }

  Future<void> _showPendingNotifications() async {
    var pendingNotificationRequests = await _notifications.getPendingNotificationRequests();
    print('Pending requests:');
    for (var pendingRequest in pendingNotificationRequests) {
      print('${pendingRequest.id}:${pendingRequest.title}/${pendingRequest.body}');
    }
  }
}
