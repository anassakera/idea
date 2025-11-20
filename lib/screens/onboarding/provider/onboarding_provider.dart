import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/onboarding/data/onboarding_data.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentIndex < onboardingContents.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      finishOnboarding(context);
    }
  }

  void skip(BuildContext context) {
    finishOnboarding(context);
  }

  void finishOnboarding(BuildContext context) {
    // Navigate to Account Type Selection
    Navigator.pushReplacementNamed(context, AppRoutes.accountType);
  }
}
