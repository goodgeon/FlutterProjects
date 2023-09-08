import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/questions_summary/questions_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.data});

  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionIdentifier(
                      questionIndex: data['question_index'] as int,
                      isCorrectAnswer:
                          data['user_answer'] == data['correct_answer']),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'] as String,
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(160, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['user_answer'] as String,
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(100, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['correct_answer'] as String,
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 160, 206, 247)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }


}