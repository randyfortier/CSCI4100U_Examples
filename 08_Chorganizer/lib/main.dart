// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:chorganizer/daily_schedule.dart';

void main() => runApp(ChorganizerApp());

class ChorganizerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chorganizer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DailySchedule(),
      debugShowCheckedModeBanner: false,
    );
  }
}
