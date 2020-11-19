import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final data = [
  {
    'questionText': 'Cual es tu color favorito?',
    'answers': [
      {'text': 'Negro', 'score': 10},
      {'text': 'Rojo', 'score': 5},
      {'text': 'Verde', 'score': 3},
      {'text': 'Blanco', 'score': 1},
    ],
  },
  {
    'questionText': 'Cual es tu animal favorito?',
    'answers': [
      {'text': 'Conejo', 'score': 3},
      {'text': 'Serpiente', 'score': 11},
      {'text': 'Elefante', 'score': 5},
      {'text': 'Leon', 'score': 9},
    ],
  },
  {
    'questionText': 'Quien es tu profesor favorito?',
    'answers': [
      {'text': 'Juan', 'score': 1},
      {'text': 'Alex', 'score': 1},
      {'text': 'Eric', 'score': 1},
      {'text': 'Adam', 'score': 1},
    ],
  },
];

enum Point { innocent, nice, strange, bad }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex;
  int _score;
  String _state;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _score = 0;
    _state = 'Eres increiblemente inocente!';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Question App'),
        ),
        body: _currentIndex < data.length ? _buildQuestion() : _buildMessage(),
      ),
    );
  }

  Container _buildMessage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _state,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20, width: double.infinity),
          RaisedButton(
            color: Colors.purple,
            onPressed: _reset,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Volver a la encuesta',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    final item = data[_currentIndex];

    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item['questionText'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10, width: double.infinity),
          for (var answer in item['answers'])
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: RaisedButton(
                onPressed: () => _selectedAnswer(answer['score']),
                color: Colors.purple,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    answer['text'],
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  _selectedAnswer(int answerScore) {
    setState(() {
      _score += answerScore;
      if (_score <= 8) _state = 'Eres increiblemente inocente!';
      if (_score > 8 && _score <= 12) _state = 'Eres bastante agradable!';
      if (_score > 12 && _score <= 16) _state = 'Eres un poco estraño';
      if (_score > 16) _state = 'Eres bastante malo!';

      _currentIndex++;
    });
  }

  _reset() {
    setState(() {
      _score = 0;
      _state = 'Eres increiblemente inocente!';
      _currentIndex = 0;
    });
  }
}
