import 'package:flutter/material.dart';
import 'package:quiz_app/questions_summary/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  Color getIndexColor(Map<String, Object> data) {
    return data['user_answer'] == data['correct_answer']
        ? const Color.fromARGB(255, 160, 206, 247)
        : const Color.fromARGB(255, 241, 129, 221);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: summaryData.map(
            (data) {
              return SummaryItem(data: data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
