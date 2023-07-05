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
  const TestQuiz({super.key});

  @override
  State<TestQuiz> createState() => _TestQuizState();
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
    Question("1. Flutter is an open-source UI toolkit.",true),
    Question("2. Flutter is developed by Microsoft.",false),
    Question("3. There are 4 types of widget in flutter.",false),
    Question("4. Dart Programming is used to build flutter application.",true),
    Question("5. Access to a cloud database through Flutter is available through MY SQL service.",false),
    Question("6. Stateless widget type allows you to modify its appearance dynamically according to user input.",false),
    Question("7. A sequence of asynchronous Flutter events is known as Stream.",false),
    Question("8. Flutter supports desktop application development.",true),
    Question("9. Stack widget we use for repeating content in Flutter.",false),
    Question("10. Flutter teams are inherently more difficult to manage because the framework is so new. ",false),

  ];
}

class Question {
  String question = "";
  bool correctAnswer = false;

  Question(this.question, this.correctAnswer);
}





