import 'package:flutter/material.dart';

class QuizProgressBar extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestionIndex;
  final Map<int, dynamic> answers;
  final Set<int> flaggedQuestions;

  const QuizProgressBar({
    super.key,
    required this.totalQuestions,
    required this.currentQuestionIndex,
    required this.answers,
    required this.flaggedQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6,
      child: Row(
        children: List.generate(totalQuestions, (index) {
          Color color = const Color(0xFFE0E0E0);
          if (index == currentQuestionIndex) {
            color = const Color(0xFF525CEB); // Current
          } else if (flaggedQuestions.contains(index)) {
            color = Colors.amber; // Flagged
          } else if (answers.containsKey(index)) {
            color = const Color(0xFF4CAF50); // Answered
          }

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}
