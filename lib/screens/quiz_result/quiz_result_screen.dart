import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'widgets/score_circle_painter.dart';
import 'widgets/result_stat_card.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;
  final String timeTaken;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
    required this.timeTaken,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final percentage = widget.score / 100.0;
    _scoreAnimation = Tween<double>(
      begin: 0.0,
      end: percentage,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = widget.score >= 70;
    final primaryColor = isSuccess
        ? const Color(0xFF4CAF50)
        : const Color(0xFF525CEB);

    return Scaffold(
      backgroundColor: const Color(0xFFF8EDFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header Message
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      isSuccess ? "Congratulations! 🎉" : "Good Effort! 💪",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D3B40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isSuccess
                          ? "You did an amazing job!"
                          : "Keep practicing to improve.",
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF3D3B40).withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Score Circle
              AnimatedBuilder(
                animation: _scoreAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ScoreCirclePainter(
                      percentage: _scoreAnimation.value,
                      color: primaryColor,
                      backgroundColor: const Color(
                        0xFFBFCFE7,
                      ).withValues(alpha: 0.3),
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${(widget.score).toInt()}%",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${widget.correctAnswers}/${widget.totalQuestions}",
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color(
                                  0xFF3D3B40,
                                ).withValues(alpha: 0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Stats Grid
              FadeTransition(
                opacity: _fadeAnimation,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    ResultStatCard(
                      label: "Correct",
                      value: "${widget.correctAnswers}",
                      icon: Icons.check_circle_outline,
                      color: const Color(0xFF4CAF50),
                    ),
                    ResultStatCard(
                      label: "Wrong",
                      value: "${widget.wrongAnswers}",
                      icon: Icons.cancel_outlined,
                      color: Colors.redAccent,
                    ),
                    ResultStatCard(
                      label: "Skipped",
                      value: "${widget.skippedAnswers}",
                      icon: Icons.remove_circle_outline,
                      color: Colors.orange,
                    ),
                    ResultStatCard(
                      label: "Time",
                      value: widget.timeTaken,
                      icon: Icons.timer_outlined,
                      color: const Color(0xFF525CEB),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              // Action Buttons
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Retake quiz - go back to preview
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.quizPreview,
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("Retake Quiz"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF525CEB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to error review
                              Navigator.pushNamed(
                                context,
                                AppRoutes.errorReview,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Color(0xFF525CEB)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Review Answers",
                              style: TextStyle(color: Color(0xFF525CEB)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.dashboard,
                                (route) => false,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: const Color(
                                  0xFF3D3B40,
                                ).withValues(alpha: 0.2),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Home",
                              style: TextStyle(color: Color(0xFF3D3B40)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
