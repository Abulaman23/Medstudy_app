// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PieChartPage(),
    );
  }
}

class PieChartPage extends StatelessWidget {
  final int correctAnswers = 20; // Replace with actual values
  final int incorrectAnswers = 5; // Replace with actual values
  final int unattemptedQuestions = 10; // Replace with actual values

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: correctAnswers.toDouble(),
                title: 'Correct',
                color: Colors.green,
              ),
              PieChartSectionData(
                value: incorrectAnswers.toDouble(),
                title: 'Incorrect',
                color: Colors.red,
              ),
              PieChartSectionData(
                value: unattemptedQuestions.toDouble(),
                title: 'Unattempted',
                color: Colors.grey,
              ),
            ],
            sectionsSpace: 0, // Adjust the spacing between sections
            centerSpaceRadius: 40,
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}
