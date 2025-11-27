import 'package:flutter/material.dart';
import 'package:idea/screens/error_review/model/review_model.dart';

class QuestionReviewCard extends StatefulWidget {
  final ReviewModel review;
  final VoidCallback onTap;
  final VoidCallback onFlag;

  const QuestionReviewCard({
    super.key,
    required this.review,
    required this.onTap,
    required this.onFlag,
  });

  @override
  State<QuestionReviewCard> createState() => _QuestionReviewCardState();
}

class _QuestionReviewCardState extends State<QuestionReviewCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    if (widget.review.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(QuestionReviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.review.isExpanded != oldWidget.review.isExpanded) {
      if (widget.review.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF525CEB).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: widget.review.isCorrect
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.red.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.review.isCorrect
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${widget.review.questionNumber}',
                      style: TextStyle(
                        color: widget.review.isCorrect
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.review.questionText,
                          style: const TextStyle(
                            color: Color(0xFF3D3B40),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              widget.review.isCorrect
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              size: 16,
                              color: widget.review.isCorrect
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.review.isCorrect ? 'Correct' : 'Incorrect',
                              style: TextStyle(
                                color: widget.review.isCorrect
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      widget.review.isFlagged
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: const Color(0xFF525CEB),
                    ),
                    onPressed: widget.onFlag,
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _controller,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    _buildAnswerSection(
                      'Your Answer:',
                      widget.review.userAnswer,
                      widget.review.isCorrect ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 8),
                    if (!widget.review.isCorrect)
                      _buildAnswerSection(
                        'Correct Answer:',
                        widget.review.correctAnswer,
                        Colors.green,
                      ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8EDFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 16,
                                color: Color(0xFF525CEB),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Explanation',
                                style: TextStyle(
                                  color: Color(0xFF525CEB),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.review.explanation,
                            style: const TextStyle(
                              color: Color(0xFF3D3B40),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerSection(String label, String text, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF3D3B40), fontSize: 14),
        ),
      ],
    );
  }
}
