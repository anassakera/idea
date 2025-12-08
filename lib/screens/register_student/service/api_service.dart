import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for handling student registration API calls
class RegisterStudentApiService {
  // Base URL for the API - Update this to match your server URL
  static const String baseUrl = 'http://localhost/idea_APIs';

  // API endpoints
  static const String registerEndpoint = '$baseUrl/auth/register.php';

  /// Register a new student
  /// Returns a map containing user data and token on success
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> registerStudent({
    required String fullName,
    required String email,
    required String password,
    String? phone,
    String? grade,
    String? dateOfBirth,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'full_name': fullName,
        'email': email,
        'password': password,
        'user_type': 'student',
      };

      // Add optional fields if provided
      if (phone != null && phone.isNotEmpty) {
        requestBody['phone'] = phone;
      }
      if (grade != null && grade.isNotEmpty) {
        requestBody['grade'] = grade;
      }
      if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
        requestBody['date_of_birth'] = dateOfBirth;
      }

      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
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
}
