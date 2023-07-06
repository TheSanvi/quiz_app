import 'package:flutter/material.dart';
import 'dart:convert'as convert;
import 'package:http/http.dart' as http;


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
        backgroundColor: Colors.lightBlueAccent,
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
   TestQuiz({super.key});

  @override
  State<TestQuiz> createState() => _TestQuizState();
  String link = "/TheSanvi/6adfcac228399158ce3db1a1ee1a9e09/raw/05ee197ee3d29c72f5e1ad1927c2ed00202ff902/gistfile1.txt";
}
class _TestQuizState extends State<TestQuiz> {

  String currentquestiontext = "Press any button to start the quiz";
  int questionno = -1;
  int correctanswers = 0;
  bool isTestOver = false;
  List<Question> questions = QuestionArray.questions;
  Question? currentquestion;
  List<Widget> scores = [];

  void setQuestion(bool b) {

    if (isTestOver) return;

    if (questionno == -1) {
      questionno++;
      currentquestion = questions[questionno];
      currentquestiontext = currentquestion!.question;
      return;
    }

    if (questionno >= questions.length - 1) {
      addResult(b);
      currentquestiontext = "Questions Over. Correct answers = $correctanswers";
      isTestOver = true;
      return;
    }

    addResult(b);
    questionno++;
    if (questionno <= questions.length - 1) {
      currentquestion = questions[questionno];
      currentquestiontext = currentquestion!.question;
    }
  }

  void addResult(bool b) {
    bool iscorrect = b == currentquestion!.correctAnswer;
    if (iscorrect) {
      correctanswers++;
      scores.add(const Icon(Icons.check, color: Colors.green));
    } else {
      scores.add(const Icon(Icons.close, color: Colors.red));
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                currentquestiontext,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  print("Submitted True");
                  setState(() {
                    // addResult(true);
                    setQuestion(true);
                  });
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                print("Submitted False");
                setState(() {
                  // addResult(false);
                  setQuestion(false);
                });
              },
            ),
          ),
        ),
        Row(
          children: scores,
        ),
      ],
    );
  }
}

class QuestionArray {
  static List<Question> questions = [
    Question(question:"Flutter is an open-source UI toolkit.",correctAnswer :true),
    Question(question:"Flutter is developed by Microsoft.",correctAnswer :false),
    Question(question:"There are 4 types of widget in flutter.",correctAnswer :false),
    Question(question:"Dart Programming is used to build flutter application.",correctAnswer :true),


  ];
}
class Question {
  final String question;
  final bool correctAnswer;

  Question({required this.question, required this.correctAnswer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'] as String,
        correctAnswer:
        ((json['correctanswer'].toString() == "true") ? true : false));
  }

  @override
  String toString() {
    return "Question=" +
        question +
        ", Correct Answer=" +
        correctAnswer.toString();
  }
}

class QuestionsArray {
  final List<dynamic> lstQuestions;

  QuestionsArray({required this.lstQuestions});

  factory QuestionsArray.fromJson(Map<String, dynamic> json) {
    return QuestionsArray(lstQuestions: json['questions'] as List<dynamic>);
  }
}

class Downloader {
  Future getDownloadedData(String link) async {
    final url = Uri.https(
        "gist.githubusercontent.com",
        link,
        {});

    try {
      final response = await http.get(url);
      //print(response);
      //print(response.statusCode);
      final jsonResponse = convert.jsonDecode(response.body);
      //print(jsonResponse);
      return jsonResponse;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class Utilities {
  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}





