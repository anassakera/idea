import 'package:flutter/material.dart';
import 'package:idea/screens/forgot_password/service/api_service.dart';

/// Enum for tracking the current step in the password reset flow
enum ResetStep { emailEntry, codeEntry }

class ForgotPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  ResetStep _currentStep = ResetStep.emailEntry;
  String _userEmail = '';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ResetStep get currentStep => _currentStep;
  String get userEmail => _userEmail;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Go back to email entry step
  void goBackToEmailStep() {
    _currentStep = ResetStep.emailEntry;
    _errorMessage = null;
    notifyListeners();
  }

  /// Request password reset link
  Future<void> sendResetLink(String email, BuildContext context) async {
    // Validate email input
    if (email.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Basic email validation
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ForgotPasswordApiService.forgotPassword(
        email: email.trim(),
      );

      _isLoading = false;
      _userEmail = email.trim();
      _currentStep = ResetStep.codeEntry; // Move to code entry step
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'] ?? 'Reset code sent to your email!',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'Failed to send reset code'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Reset password with code and new password
  Future<void> resetPassword(
    String code,
    String newPassword,
    String confirmPassword,
    BuildContext context,
  ) async {
    // Validate inputs
    if (code.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the reset code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a new password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (newPassword.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ForgotPasswordApiService.resetPassword(
        token: code.trim().toUpperCase(),
        newPassword: newPassword,
      );

      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'] ?? 'Password reset successfully!',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to login
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'Failed to reset password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
