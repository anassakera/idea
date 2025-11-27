import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Navigate to upload document screen for creating new quiz
  void navigateToUpload(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.uploadDocument);
  }

  /// Navigate to library screen
  void navigateToLibrary(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.library);
  }

  /// Navigate to statistics screen
  void navigateToStatistics(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.statistics);
  }

  /// Navigate to profile screen
  void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profile);
  }

  /// Handle bottom navigation bar taps
  void handleNavigation(BuildContext context, int index) {
    setIndex(index);

    switch (index) {
      case 0:
        // Home - already on dashboard, no navigation needed
        break;
      case 1:
        // Library
        navigateToLibrary(context);
        break;
      case 2:
        // Stats
        navigateToStatistics(context);
        break;
      case 3:
        // Profile
        navigateToProfile(context);
        break;
    }
  }
}
