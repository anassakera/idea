/// User model for storing user data
class User {
  final int id;
  final String fullName;
  final String email;
  final String userType;
  final bool emailVerified;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userType,
    required this.emailVerified,
  });

  /// Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      userType: json['user_type'] as String,
      emailVerified: json['email_verified'] as bool,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'user_type': userType,
      'email_verified': emailVerified,
    };
  }

  /// Copy with method for creating modified copies
  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? userType,
    bool? emailVerified,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }
}

/// Authentication response model
class AuthResponse {
  final User user;
  final String token;
  final String expiresAt;

  AuthResponse({
    required this.user,
    required this.token,
    required this.expiresAt,
  });

  /// Create AuthResponse from JSON
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      expiresAt: json['expires_at'] as String,
    );
  }

  /// Convert AuthResponse to JSON
  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token, 'expires_at': expiresAt};
  }
}
