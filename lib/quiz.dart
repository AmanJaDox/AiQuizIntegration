import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import 'package:http/http.dart' as http;

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> data;
  final Function answerQuestion;

  const Quiz(
      {required this.data, required this.answerQuestion, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _indexQuestion = 0;
  double _totalScore = 0.00;

  Future<void> _answerQuestion(double score) async {
    _totalScore += score;

    // Send user input to AI and receive response
    final response = await LlamaChannel.evaluateAnswer(_selectedAnswer);

    // Update UI with AI-generated question and answers
    setState(() {
      _data = response.data;
      _indexQuestion += 1;
    });
  }

  void _restart() {
    setState(() {
      _indexQuestion = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: SizedBox(
            width: 360,
            child: Question(
              _data[_indexQuestion]['questionText'] as String,
            ),
          ),
        ),
        ...(data[_indexQuestion]['answers'] as List<Map<String, Object>>)
            .map((answer) {
              return Answer(
                  () => _answerQuestion(answer['score']),
                  answer['text'] as String);
            })
            .toList(),
      ],
    );
  }
}



