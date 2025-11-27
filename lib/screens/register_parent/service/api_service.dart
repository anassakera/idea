import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for handling parent registration API calls
class RegisterParentApiService {
  // Base URL for the API - Update this to match your server URL
  static const String baseUrl = 'http://192.168.0.104/idea_APIs';

  // API endpoints
  static const String registerEndpoint = '$baseUrl/auth/register.php';

  /// Register a new parent
  /// Returns a map containing user data and token on success
  /// Throws an exception with error message on failure
  static Future<Map<String, dynamic>> registerParent({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    List<String>? children,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'full_name': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'user_type': 'parent',
      };

      // Add children list if provided
      if (children != null && children.isNotEmpty) {
        requestBody['children'] = children;
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
