import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for handling forgot password related API calls
class ForgotPasswordApiService {
  // Base URL for the API - Update this to match your server URL
  static const String baseUrl = 'http://192.168.0.101/idea_APIs';

  // API endpoints
  static const String forgotPasswordEndpoint =
      '$baseUrl/auth/forgot_password.php';
  static const String resetPasswordEndpoint =
      '$baseUrl/auth/reset_password.php';

  /// Request password reset
  /// Sends a password reset token to the user's email
  /// Returns a map containing the response message
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(forgotPasswordEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return responseData['data'] ?? responseData;
      } else {
        throw Exception(
          responseData['error'] ?? 'Password reset request failed',
        );
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: Unable to connect to server');
    }
  }

  /// Reset password with token
  /// Uses the reset code from email to set a new password
  /// Returns a map containing the success message
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(resetPasswordEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'new_password': newPassword}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return responseData['data'] ?? responseData;
      } else {
        throw Exception(responseData['error'] ?? 'Password reset failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: Unable to connect to server');
    }
  }
}
