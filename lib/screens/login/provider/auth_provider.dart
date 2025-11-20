import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    // Navigate to Home (not implemented yet, so maybe just show success or go to dashboard placeholder)
    // For now, let's assume successful login goes to a Dashboard placeholder or stays here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login Successful!')),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerStudent);
  }
}
