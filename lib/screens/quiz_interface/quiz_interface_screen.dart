import 'package:flutter/material.dart';
import 'package:idea/screens/quiz_preview/model/quiz_preview_model.dart';
import 'package:provider/provider.dart';
import 'provider/quiz_interface_provider.dart';
import 'package:idea/routes/app_routes.dart';
import 'widgets/answer_option_card.dart';
import 'widgets/quiz_progress_bar.dart';

class QuizInterfaceScreen extends StatelessWidget {
  final QuizPreviewModel quiz;

  const QuizInterfaceScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizInterfaceProvider()..initQuiz(quiz),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8EDFF),
        body: SafeArea(
          child: Consumer<QuizInterfaceProvider>(
            builder: (context, provider, child) {
              final question =
                  provider.quiz.questions[provider.currentQuestionIndex];
              final isLastQuestion =
                  provider.currentQuestionIndex ==
                  provider.quiz.questions.length - 1;

              return Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF3D3B40),
                              ),
                              onPressed: () {
                                // Show confirmation dialog
                                Navigator.pop(context);
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8EDFF),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF525CEB,
                                  ).withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    size: 18,
                                    color: Color(0xFF525CEB),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    provider.timerString,
                                    style: const TextStyle(
                                      color: Color(0xFF525CEB),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${provider.currentQuestionIndex + 1}/${provider.quiz.questions.length}",
                              style: const TextStyle(
                                color: Color(0xFF3D3B40),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        QuizProgressBar(
                          totalQuestions: provider.quiz.questions.length,
                          currentQuestionIndex: provider.currentQuestionIndex,
                          answers: provider.answers,
                          flaggedQuestions: provider.flaggedQuestions,
                        ),
                      ],
                    ),
                  ),

                  // Question Body
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question ${question.number}",
                            style: const TextStyle(
                              color: Color(0xFF525CEB),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            question.text,
                            style: const TextStyle(
                              color: Color(0xFF3D3B40),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Answers
                          if (question.type == "Multiple Choice") ...[
                            _buildOption(provider, "A", "8"),
                            _buildOption(provider, "B", "12"),
                            _buildOption(provider, "C", "7"),
                            _buildOption(provider, "D", "15"),
                          ] else ...[
                            Row(
                              children: [
                                Expanded(
                                  child: _buildOption(provider, "True", "True"),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildOption(
                                    provider,
                                    "False",
                                    "False",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Bottom Navigation
                  Container(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: provider.currentQuestionIndex > 0
                              ? provider.previousQuestion
                              : null,
                          icon: const Icon(Icons.arrow_back_ios_new),
                          color: const Color(0xFF3D3B40),
                        ),
                        IconButton(
                          onPressed: provider.toggleFlag,
                          icon: Icon(
                            provider.flaggedQuestions.contains(
                                  provider.currentQuestionIndex,
                                )
                                ? Icons.flag
                                : Icons.flag_outlined,
                          ),
                          color:
                              provider.flaggedQuestions.contains(
                                provider.currentQuestionIndex,
                              )
                              ? Colors.amber
                              : const Color(0xFFBFCFE7),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (isLastQuestion) {
                              // Navigate to Review Screen
                              Navigator.pushNamed(
                                context,
                                AppRoutes.quizReview,
                              );
                            } else {
                              provider.nextQuestion();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF525CEB),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            isLastQuestion ? "Review" : "Next",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    QuizInterfaceProvider provider,
    String label,
    String text,
  ) {
    final isSelected = provider.answers[provider.currentQuestionIndex] == text;
    return AnswerOptionCard(
      label: label,
      optionText: text,
      isSelected: isSelected,
      onTap: () => provider.selectAnswer(text),
    );
  }
}
