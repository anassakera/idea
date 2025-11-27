import 'dart:async';
import 'package:flutter/material.dart';
import '../../quiz_preview/model/quiz_preview_model.dart';

class QuizInterfaceProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  final Map<int, dynamic> _answers = {}; // Index -> Answer
  Map<int, dynamic> get answers => _answers;

  final Set<int> _flaggedQuestions = {};
  Set<int> get flaggedQuestions => _flaggedQuestions;

  Timer? _timer;
  int _secondsRemaining = 0;
  int get secondsRemaining => _secondsRemaining;

  bool _isQuizSubmitted = false;
  bool get isQuizSubmitted => _isQuizSubmitted;

  // Mock Quiz Data (In real app, pass this in)
  late QuizPreviewModel _quiz;
  QuizPreviewModel get quiz => _quiz;

  void initQuiz(QuizPreviewModel quiz) {
    _quiz = quiz;
    _secondsRemaining = quiz.estimatedTimeMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
        // Handle timeout
      }
    });
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _quiz.questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void selectAnswer(dynamic answer) {
    _answers[_currentQuestionIndex] = answer;
    notifyListeners();
  }

  void toggleFlag() {
    if (_flaggedQuestions.contains(_currentQuestionIndex)) {
      _flaggedQuestions.remove(_currentQuestionIndex);
    } else {
      _flaggedQuestions.add(_currentQuestionIndex);
    }
    notifyListeners();
  }

  void submitQuiz() {
    _isQuizSubmitted = true;
    _timer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerString {
    final minutes = (_secondsRemaining / 60).floor().toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  double get progress => (_currentQuestionIndex + 1) / _quiz.questions.length;
}
