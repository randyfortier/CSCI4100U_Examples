import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';

import 'grade.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrequencyChart(
        title: 'Charts',
        grades: [
          Grade(sid: 100000000, grade: 'A'),
          Grade(sid: 100000000, grade: 'C'),
          Grade(sid: 100000000, grade: 'B'),
          Grade(sid: 100000000, grade: 'C'),
          Grade(sid: 100000000, grade: 'F'),
          Grade(sid: 100000000, grade: 'C'),
          Grade(sid: 100000000, grade: 'D'),
          Grade(sid: 100000000, grade: 'B'),
          Grade(sid: 100000000, grade: 'D'),
          Grade(sid: 100000000, grade: 'C'),
        ],
      ),
    );
  }
}

class FrequencyChart extends StatefulWidget {
  FrequencyChart({Key key, this.title, this.grades}) : super(key: key);

  final String title;
  final List<Grade> grades;

  @override
  _FrequencyChartState createState() => _FrequencyChartState();
}

class _FrequencyChartState extends State<FrequencyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          height: 500.0,
          child: charts.BarChart(
            [
              charts.Series<GradeFrequency, String>(
                id: 'Grade Frequency',
                colorFn: (a,b) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (GradeFrequency freq, unused) => freq.grade,
                measureFn: (GradeFrequency freq, unused) => freq.frequency,
                data: _calculateGradeFrequencies(),
              ),
            ],
            animate: true,
            vertical: false,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'FAB',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<GradeFrequency> _calculateGradeFrequencies() {
    var frequencies = {
      'A': 0,
      'B': 0,
      'C': 0,
      'D': 0,
      'F': 0,
    };

    for (Grade grade in widget.grades) {
      frequencies[grade.grade]++;
    }

    var grades = ['A', 'B', 'C', 'D', 'F'];

    return grades.map((grade) => GradeFrequency(
      grade: grade,
      frequency: frequencies[grade]
    )).toList();
  }
}
