import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';

class UploadProvider extends ChangeNotifier {
  String? _fileName;
  String? _selectedSubject;
  double _questionCount = 10;
  String _difficulty = 'Medium';
  final Map<String, bool> _questionTypes = {
    'Multiple Choice': true,
    'True/False': false,
    'Fill in Blanks': false,
    'Essay': false,
  };

  String? get fileName => _fileName;
  String? get selectedSubject => _selectedSubject;
  double get questionCount => _questionCount;
  String get difficulty => _difficulty;
  Map<String, bool> get questionTypes => _questionTypes;

  final List<String> subjects = [
    'Math',
    'Science',
    'History',
    'English',
    'Physics',
  ];
  final List<String> difficulties = ['Easy', 'Medium', 'Hard', 'Mixed'];

  void pickFile() {
    // Simulate file picking
    _fileName = 'Chapter_1_Algebra.pdf';
    notifyListeners();
  }

  void setSubject(String? subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  void setQuestionCount(double value) {
    _questionCount = value;
    notifyListeners();
  }

  void setDifficulty(String? value) {
    if (value != null) {
      _difficulty = value;
      notifyListeners();
    }
  }

  void toggleQuestionType(String type, bool? value) {
    if (value != null) {
      _questionTypes[type] = value;
      notifyListeners();
    }
  }

  void analyzeDocument(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.analysisLoading);
  }
}
