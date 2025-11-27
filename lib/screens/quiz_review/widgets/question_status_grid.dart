import 'package:flutter/material.dart';

class QuestionStatusGrid extends StatelessWidget {
  final int totalQuestions;
  final Map<int, dynamic> answers;
  final Set<int> flaggedQuestions;
  final Function(int) onQuestionTap;

  const QuestionStatusGrid({
    super.key,
    required this.totalQuestions,
    required this.answers,
    required this.flaggedQuestions,
    required this.onQuestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: totalQuestions,
      itemBuilder: (context, index) {
        final isAnswered = answers.containsKey(index);
        final isFlagged = flaggedQuestions.contains(index);

        Color backgroundColor = Colors.white;
        Color borderColor = const Color(0xFFBFCFE7);
        Color textColor = const Color(0xFF3D3B40);
        IconData? statusIcon;

        if (isFlagged) {
          backgroundColor = const Color(0xFFFFF8E1); // Light Amber
          borderColor = Colors.amber;
          statusIcon = Icons.flag;
        } else if (isAnswered) {
          backgroundColor = const Color(0xFFE8F5E9); // Light Green
          borderColor = const Color(0xFF4CAF50);
          textColor = const Color(0xFF4CAF50);
          statusIcon = Icons.check;
        }

        return GestureDetector(
          onTap: () => onQuestionTap(index),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (statusIcon != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Icon(statusIcon, size: 12, color: borderColor),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
