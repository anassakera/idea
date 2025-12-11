import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for handling authentication-related API calls
class ApiService {
  // Base URL for the API - Update this to your local server URL
  static const String baseUrl = 'http://192.168.0.101/idea_APIs';

  // API endpoints
  static const String loginEndpoint = '$baseUrl/auth/login.php';
  static const String registerEndpoint = '$baseUrl/auth/register.php';
  static const String forgotPasswordEndpoint =
      '$baseUrl/auth/forgot_password.php';
  static const String resetPasswordEndpoint =
      '$baseUrl/auth/reset_password.php';
  static const String logoutEndpoint = '$baseUrl/auth/logout.php';

  /// Login user with email and password
  /// Returns a map containing user data and token on success
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return responseData['data'];
      } else {
        throw Exception(responseData['error'] ?? 'Login failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: Unable to connect to server');
    }
  }

  /// Register a new user
  /// Returns a map containing user data and token on success
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
    String userType = 'student',
  }) async {
    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'phone': phone,
          'user_type': userType,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return responseData['data'];
      } else {
        throw Exception(responseData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: Unable to connect to server');
    }
  }

  /// Request password reset
  /// Sends a password reset token to the user's email
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
        return responseData['data'];
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

  /// Reset password using token
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
        return responseData['data'];
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

  /// Logout user
  /// Invalidates the session token
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> logout({required String token}) async {
    try {
      final response = await http.post(
        Uri.parse(logoutEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return responseData['data'];
      } else {
        throw Exception(responseData['error'] ?? 'Logout failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: Unable to connect to server');
    }
  }
}
