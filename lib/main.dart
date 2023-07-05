import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Quiz App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ))),
          backgroundColor: Colors.lightGreen,
        ),
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Padding(padding: EdgeInsets.all(15.0),
            child: TestQuiz(
            ),
          ),
        ),
      )
    );
  }
}

class TestQuiz extends StatefulWidget {
  const TestQuiz({super.key});

  @override
  State<TestQuiz> createState() => _TestQuizState();
}

class _TestQuizState extends State<TestQuiz> {

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




