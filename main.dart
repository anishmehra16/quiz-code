import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:const Text('Quiz App'),
        ),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [ { 'question': 'What is Flutter?',
        'options': [  {'option': 'A mobile development framework', 'isCorrect': true}, 
               {'option': 'A frontend framework', 'isCorrect': false},     
              {'option': 'A backend framework', 'isCorrect': false}      ],
             'answerType': 'checkbox'
    },
    {
      'question': 'What programming language is used in Flutter?',
      'options': [ {'option': 'Java', 'isCorrect': false},
      {'option': 'Dart', 'isCorrect': true},
      {'option': 'Python', 'isCorrect': false}      ],
      'answerType': 'radio'
    },
       
    {
      'question': 'Which is an app?',
      'options': [ {'option': 'Java','image' : 'assets/imagesapple.jpeg', 'isCorrect': true},
      {'option': 'Java','image' : 'assets/images/banana.webp', 'isCorrect': false},
      {'option': 'Java','image':'assets/images/cherry.jpg', 'isCorrect': false}      ],
      'answerType': 'images'
    },
    
    
  ];

  List<List<bool?>> selectedAnswers = [    [false, false, false],
    [false, false, false],  [false, false, false],
  ];

  List<int> radioSelectedAnswers = [-1, -1,-1];
    List<int> radioSelectedAnswers2 = [-1, -1,-1];

  
  



  int currentQuestion = 0;

  void checkAnswer() {
    // Check the selected answers against the correct answers
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:const EdgeInsets.all(20.0),
          child: Text(
            questions[currentQuestion]['question'],
            style:const TextStyle(fontSize: 22.0),
          ),
        ),
        ...questions[currentQuestion]['options']
            .asMap()
            .entries
            .map((MapEntry map) {
          if (questions[currentQuestion]['answerType'] == 'checkbox') {
            return CheckboxListTile(
              title: Text(map.value['option']),
              value: selectedAnswers[currentQuestion][map.key],
              onChanged: (value) {
                setState(() {
                  selectedAnswers[currentQuestion][map.key] = value;
                });
              },
            );
          } else if (questions[currentQuestion]['answerType'] == 'radio'){
            return RadioListTile(
              title: Text(map.value['option']) ,
              value: map.key,
              groupValue: radioSelectedAnswers[currentQuestion],
              onChanged: (value) {
                setState(() {
                  radioSelectedAnswers[currentQuestion] = value;
                });
              },
            );
          } else{
          return RadioListTile(
              title: Row(children: [
                Image(image:AssetImage(map.value['images']),
                height: 90,
                width: 90, 
                fit: BoxFit.fill,),
                Text(map.value['option'])
              ],) ,
              value: map.key ,
              groupValue: radioSelectedAnswers2[currentQuestion],
              onChanged: (value) {
                setState(() {
                  radioSelectedAnswers2[currentQuestion] = value;
                });
              },
            );
          }}
        ).toList(),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            setState(() {
              checkAnswer();
              if (currentQuestion < questions.length - 1) {
                currentQuestion++;
              }
            });
          },
        )
      ],
    );
  }
}
