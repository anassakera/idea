import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';

class SplashProvider extends ChangeNotifier {
  void init(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    });
  }
}
