import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToUpload(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.uploadDocument);
  }
}
