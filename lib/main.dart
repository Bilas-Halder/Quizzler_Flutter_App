import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int quesNum = 0;
  int rightAns = 0;
  List<Widget> scoreKeeper = [];
  List<String> questions = [
    'Flutter is easy to learn for android development.',
    'Flutter is supported by Facebook.',
    'Flutter don\'t support ios development.',
    'For app development with Flutter we use Dart programming language.',
    'Flutter is supported by Google.',
    'Flutter is a library of Dart programming language.',
    'Flutter is a Framework for cross platform mobile development.'
  ];
  List<bool> ans = [true, false, false, true, true, false, true];

  dynamic showAlert() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('All Right!'),
        content:  Text(
        '''You have completed all the quiz.
Your score is :- ${rightAns*10} / ${ans.length*10}.

Do you want to start again?''',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                quesNum = 0;
                scoreKeeper.clear();
                rightAns=0;
              });
              Navigator.pop(context, 'Start Again');
            },
            child: const Text('Start Again'),
          ),
        ],
      ),
    );
  }

  dynamic showTrueFalse(bool answer) {
    setState(() {
      if (answer == true) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
        rightAns += 1;
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quesNum += 1;
    });
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
                questions[quesNum],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.red,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (ans[quesNum] == true) {
                  showTrueFalse(true);
                } else {
                  showTrueFalse(false);
                }
                if (quesNum == 7) {
                  quesNum = 0;
                  showAlert();
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.green,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (ans[quesNum] == false) {
                  showTrueFalse(true);
                } else {
                  showTrueFalse(false);
                }
                if (quesNum == 7) {
                  quesNum = 0;
                  showAlert();
                }
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}
