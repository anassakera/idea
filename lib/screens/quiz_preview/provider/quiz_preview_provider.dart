import 'package:flutter/material.dart';
import '../model/quiz_preview_model.dart';

class QuizPreviewProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  QuizPreviewModel? _quizDetails;
  QuizPreviewModel? get quizDetails => _quizDetails;

  // Simulate fetching data
  Future<void> loadQuizDetails(String quizId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Mock delay

    // Mock Data
    _quizDetails = QuizPreviewModel(
      id: quizId,
      title: "Basic Addition",
      subject: "Mathematics",
      questionCount: 10,
      estimatedTimeMinutes: 15,
      difficulty: "Easy",
      questions: List.generate(
        10,
        (index) => QuestionPreview(
          number: index + 1,
          text: "What is the result of ${index + 2} + ${index + 3}?",
          type: index % 2 == 0 ? "Multiple Choice" : "True/False",
        ),
      ),
    );

    _isLoading = false;
    notifyListeners();
  }
}
