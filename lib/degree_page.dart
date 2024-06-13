// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_final_fields, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DegreeScreen(),
    );
  }
}

class DegreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEDSTUDY APP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardOption(
              title: 'MBBS',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MBBSYearsScreen()),
                );
              },
            ),
            CardOption(
              title: 'NEET Aspirants',
              onTap: () {
                // Add your NEET Aspirants screen logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CardOption({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

class MBBSYearsScreen extends StatefulWidget {
  @override
  _MBBSYearsScreenState createState() => _MBBSYearsScreenState();
}

class _MBBSYearsScreenState extends State<MBBSYearsScreen> {
  String selectedYear = 'First Year';
  List<String> years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MBBS Years'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedYear,
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: years.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedYear == 'First Year') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstYearQuestionsScreen()),
                  );
                } else {
                  // Handle other year options if needed
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstYearQuestionsScreen extends StatefulWidget {
  @override
  _FirstYearQuestionsScreenState createState() =>
      _FirstYearQuestionsScreenState();
}

class _FirstYearQuestionsScreenState extends State<FirstYearQuestionsScreen> {
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int unattemptedQuestions = 0;

  void updateStatistics(int correct, int incorrect, int unattempted) {
    setState(() {
      correctAnswers = correct;
      incorrectAnswers = incorrect;
      unattemptedQuestions = unattempted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Year Questions'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _buildStatisticsDialog(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuestionCard(
                question: 'What is the capital of France?',
                options: ['Paris', 'London', 'Berlin', 'Rome'],
                correctOptionIndex: 0,
                onUpdateStatistics: updateStatistics,
              ),
              // Add more QuestionCard widgets for other questions
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsDialog() {
    var data = [
      PieChartStatistic('Correct', correctAnswers),
      PieChartStatistic('Incorrect', incorrectAnswers),
      PieChartStatistic('Unattempted', unattemptedQuestions),
    ];

    var series = [
      charts.Series<PieChartStatistic, String>(
        id: 'Statistics',
        domainFn: (PieChartStatistic stat, _) => stat.label,
        measureFn: (PieChartStatistic stat, _) => stat.value,
        data: data,
        labelAccessorFn: (PieChartStatistic stat, _) =>
            '${stat.label}: ${stat.value}',
      ),
    ];

    return AlertDialog(
      title: Text('Statistics'),
      content: SizedBox(
        height: 200,
        child: charts.PieChart(series),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class PieChartStatistic {
  final String label;
  final int value;

  PieChartStatistic(this.label, this.value);
}

class QuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final Function(int correct, int incorrect, int unattempted)
      onUpdateStatistics;

  QuestionCard({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.onUpdateStatistics,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int? selectedOption;
  bool showResult = false;

  void checkAnswer() {
    if (selectedOption == widget.correctOptionIndex) {
      widget.onUpdateStatistics(
          correctAnswers + 1, incorrectAnswers, unattemptedQuestions);
    } else if (selectedOption != null) {
      widget.onUpdateStatistics(
          correctAnswers, incorrectAnswers + 1, unattemptedQuestions);
    } else {
      widget.onUpdateStatistics(
          correctAnswers, incorrectAnswers, unattemptedQuestions + 1);
    }

    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                widget.options.length,
                (index) => RadioListTile<int>(
                  title: Text(widget.options[index]),
                  value: index,
                  groupValue: selectedOption,
                  onChanged: showResult
                      ? null
                      : (int? value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showResult
                  ? null
                  : () {
                      checkAnswer();
                    },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            if (showResult)
              Text(
                selectedOption == widget.correctOptionIndex
                    ? 'Your answer is correct!!'
                    : 'Your answer is wrong:(',
                style: TextStyle(
                  fontSize: 18,
                  color: selectedOption == widget.correctOptionIndex
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
