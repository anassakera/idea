enum LibraryItemType { document, quiz, note }

class LibraryItemModel {
  final String id;
  final String title;
  final String subject;
  final DateTime date;
  final LibraryItemType type;
  final String? fileSize; // For documents
  final int? score; // For quizzes
  final int? totalQuestions; // For quizzes

  LibraryItemModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.date,
    required this.type,
    this.fileSize,
    this.score,
    this.totalQuestions,
  });
}
