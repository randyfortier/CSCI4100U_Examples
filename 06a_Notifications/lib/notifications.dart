import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final channelId = 'eventNotifications';
  final channelName = 'Event Notifications';
  final channelDescription = 'Channel for event notifications';

  var _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationDetails _platformChannelInfo;
  var notificationId = 100;

  void init() {
    // setup the notification plugin
    var initSettingsAndroid = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );
    var initSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) {
         return null;
      }
    );
    var initSettings = InitializationSettings(
      initSettingsAndroid, initSettingsIOS
    );

    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );

    // setup the notification channel
    var androidChannelInfo = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      importance: Importance.Default,
      priority: Priority.Default,
      ticker: 'ticker',
    );
    var iosChannelInfo = IOSNotificationDetails();

    var _platformChannelInfo = NotificationDetails(
      androidChannelInfo,
      iosChannelInfo,
    );
  }

  Future<void> onSelectNotification(var payload) {
    if (payload != null) {
      print('onSelectNotification()::payload=$payload');
      // TODO: Load the appropriate page to the correct data item
    }
  }

  Future<void> sendNotificationNow(String title, String body, String payload) async {
    _flutterLocalNotificationsPlugin.show(
      notificationId++,
      title,
      body,
      _platformChannelInfo,
      payload: payload,
    );
  }

  Future<void> sendNotificationLater(String title, String body, DateTime when, String payload) async {
    _flutterLocalNotificationsPlugin.schedule(
      notificationId++,
      title,
      body,
      when,
      _platformChannelInfo,
      payload: payload,
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}