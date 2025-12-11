import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  void init(BuildContext context) {
    _checkSessionAndNavigate(context);
  }

  Future<void> _checkSessionAndNavigate(BuildContext context) async {
    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    final prefs = await SharedPreferences.getInstance();

    // Check if user has completed onboarding
    final hasCompletedOnboarding =
        prefs.getBool('has_completed_onboarding') ?? false;

    // Check if user is logged in
    final authToken = prefs.getString('auth_token');
    final isLoggedIn = authToken != null && authToken.isNotEmpty;

    if (!context.mounted) return;

    if (isLoggedIn) {
      // User is logged in → go to dashboard
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else if (hasCompletedOnboarding) {
      // User completed onboarding but not logged in → go to account type
      Navigator.pushReplacementNamed(context, AppRoutes.accountType);
    } else {
      // New user → show onboarding
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }
}
