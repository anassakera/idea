import 'package:flutter/material.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'widgets/question_status_grid.dart';

class QuizReviewScreen extends StatelessWidget {
  final int totalQuestions;
  final Map<int, dynamic> answers;
  final Set<int> flaggedQuestions;

  const QuizReviewScreen({
    super.key,
    required this.totalQuestions,
    required this.answers,
    required this.flaggedQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final answeredCount = answers.length;
    final remainingCount = totalQuestions - answeredCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8EDFF),
      appBar: const CustomAppBar(title: "Review Answers"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Answered",
                    "$answeredCount",
                    const Color(0xFF4CAF50),
                    Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    "Remaining",
                    "$remainingCount",
                    const Color(0xFF3D3B40),
                    Icons.radio_button_unchecked,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    "Flagged",
                    "${flaggedQuestions.length}",
                    Colors.amber,
                    Icons.flag_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              "Question Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3B40),
              ),
            ),
            const SizedBox(height: 16),

            QuestionStatusGrid(
              totalQuestions: totalQuestions,
              answers: answers,
              flaggedQuestions: flaggedQuestions,
              onQuestionTap: (index) {
                // Navigate back to specific question
                Navigator.pop(context, index);
              },
            ),

            const SizedBox(height: 40),

            if (remainingCount > 0)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "You have $remainingCount unanswered questions. Are you sure you want to submit?",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Result Screen
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF525CEB),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            shadowColor: const Color(0xFF525CEB).withValues(alpha: 0.4),
          ),
          child: const Text(
            "Submit Quiz",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF3D3B40).withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
