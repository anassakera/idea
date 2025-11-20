import 'package:flutter/material.dart';
import 'dart:async';

class AnalysisProvider extends ChangeNotifier {
  double _progress = 0.0;
  String _loadingText = 'Reading Document...';
  Timer? _timer;

  double get progress => _progress;
  String get loadingText => _loadingText;

  void startAnalysis(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_progress < 1.0) {
        _progress += 0.1;
        if (_progress > 0.2 && _progress <= 0.5) {
          _loadingText = 'Extracting Content...';
        } else if (_progress > 0.5 && _progress <= 0.8) {
          _loadingText = 'Generating Questions...';
        } else if (_progress > 0.8) {
          _loadingText = 'Verifying Answers...';
        }
        notifyListeners();
      } else {
        _timer?.cancel();
        _loadingText = 'Analysis Complete!';
        notifyListeners();
        // Navigate to Quiz Preview (Screen 11 - not implemented yet)
        Future.delayed(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Analysis Complete! Ready for Quiz Preview.'),
            ),
          );
          Navigator.pop(context); // Go back for now
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
