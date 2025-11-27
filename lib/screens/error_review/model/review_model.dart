class ReviewModel {
  final int questionNumber;
  final String questionText;
  final String userAnswer;
  final String correctAnswer;
  final String explanation;
  final bool isCorrect;
  bool isExpanded;
  bool isFlagged;

  ReviewModel({
    required this.questionNumber,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
    required this.explanation,
    required this.isCorrect,
    this.isExpanded = false,
    this.isFlagged = false,
  });
}
