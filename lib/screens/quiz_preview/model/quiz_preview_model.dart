class QuizPreviewModel {
  final String id;
  final String title;
  final String subject;
  final int questionCount;
  final int estimatedTimeMinutes;
  final String difficulty;
  final List<QuestionPreview> questions;

  QuizPreviewModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.questionCount,
    required this.estimatedTimeMinutes,
    required this.difficulty,
    required this.questions,
  });
}

class QuestionPreview {
  final int number;
  final String text;
  final String type;

  QuestionPreview({
    required this.number,
    required this.text,
    required this.type,
  });
}
