// CSCI 4100U - 06a Notifications

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final channelId = 'testNotifications';
  final channelName = 'Test Notifications';
  final channelDescription = 'Test Notification Channel';

  var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  NotificationDetails _platformChannelInfo;
  var notificationId = 100;

  void init() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) { return null; }
    );
    var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, 
      initializationSettingsIOS
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification
    );

    // setup a channel for notifications
    var androidPlatformChannelInfo = AndroidNotificationDetails(
      channelId, 
      channelName, 
      channelDescription,
      importance: Importance.Max, 
      priority: Priority.High, 
      ticker: 'ticker');

    var iOSPlatformChannelInfo = IOSNotificationDetails();
    _platformChannelInfo = NotificationDetails(
      androidPlatformChannelInfo, 
      iOSPlatformChannelInfo
    );

  }

  Future onSelectNotification(var payload) async {
    if (payload != null) {
      print('notificationSelected: payload=$payload.');
    }
    // ... redirect to some part of the app, using payload to view correct data item ...
  }

  Future<void> sendNotificationNow(String title, String body, String payload) async {
    _flutterLocalNotificationsPlugin.show(
      notificationId++, 
      title, 
      body, 
      _platformChannelInfo,
      payload: payload
    );
  }

  Future<void> sendNotificationLater(String title, String body, DateTime when, String payload) async {
    _flutterLocalNotificationsPlugin.schedule(
      notificationId++, 
      title,
      body,
      when,
      _platformChannelInfo,
      payload: payload
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotificationRequests() async {
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}