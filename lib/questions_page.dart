// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionListScreen(),
    );
  }
}

class QuestionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3rd Year Questions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionCard(questionNumber: 'Question 1'),
            QuestionCard(questionNumber: 'Question 2'),
            QuestionCard(questionNumber: 'Question 3'),
            QuestionCard(questionNumber: 'Question 4'),
            QuestionCard(questionNumber: 'Question 5'),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String questionNumber;

  QuestionCard({required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        title: Text(questionNumber),
        onTap: () {
          // You can add navigation to question detail screen here if needed
        },
      ),
    );
  }
}
