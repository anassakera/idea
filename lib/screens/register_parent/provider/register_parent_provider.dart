import 'package:flutter/material.dart';

class RegisterParentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final List<String> _children = []; // List of child emails or codes

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  List<String> get children => _children;

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

  Future<void> register(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Parent Account Created!')));

    Navigator.pop(context);
  }
}
