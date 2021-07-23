import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[900],
            body: SafeArea(
              child: QuizPage(),
            )));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];
  Quizbrain quizbrain = Quizbrain();
  int questionNumber = 0;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (quizbrain.isFinished()) {
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You have Finished the quiz',
      ).show();
      quizbrain.reset();
      scorekeeper = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  '${quizbrain.getQuestion()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  quizbrain.nextQuestion();
                  scorekeeper.add(quizbrain.checkAnswer(true));
                });
              },
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.green),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                quizbrain.nextQuestion();
                setState(() {
                  scorekeeper.add(quizbrain.checkAnswer(false));
                });
              },
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
