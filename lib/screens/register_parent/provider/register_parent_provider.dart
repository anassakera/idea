import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/register_parent/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterParentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final List<String> _children = []; // List of child emails or codes
  String? _errorMessage;

  // Text controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  List<String> get children => _children;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void addChild(String childInfo) {
    if (childInfo.isNotEmpty) {
      _children.add(childInfo);
      notifyListeners();
    }
  }

  void removeChild(int index) {
    _children.removeAt(index);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Validate registration form
  String? _validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (emailController.text.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!_isValidEmail(emailController.text.trim())) {
      return 'Please enter a valid email address';
    }
    if (phoneController.text.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (passwordController.text.isEmpty) {
      return 'Please enter a password';
    }
    if (passwordController.text.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> register(BuildContext context) async {
    // Validate form
    final validationError = _validateForm();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError), backgroundColor: Colors.red),
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await RegisterParentApiService.registerParent(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: phoneController.text.trim(),
        children: _children.isNotEmpty ? _children : null,
      );

      // Save token to local storage
      if (response['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response['token']);
      }

      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome, ${response['user']['full_name'] ?? 'Parent'}!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to Dashboard
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashboard,
          (route) => false,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
