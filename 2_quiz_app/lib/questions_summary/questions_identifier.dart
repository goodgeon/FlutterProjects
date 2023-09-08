import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(
      {super.key, required this.questionIndex, required this.isCorrectAnswer});

  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCorrectAnswer
            ? const Color.fromARGB(255, 160, 206, 247)
            : const Color.fromARGB(255, 241, 129, 221),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        (questionIndex + 1).toString(),
      ),
    );
  }
}
