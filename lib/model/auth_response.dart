// lib/models/auth_response.dart
import 'user_model.dart';

class OtpResponse {
  final bool success;
  final String message;
  final String? otp;
  final String? token;

  OtpResponse({
    required this.success,
    required this.message,
    this.otp,
    this.token,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      otp: json['otp'],
      token: json['token'],
    );
  }
}

class VerifyOtpResponse {
  final bool success;
  final String message;
  final String token;
  final User user;

  VerifyOtpResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class GoogleSignInResponse {
  final bool success;
  final String message;
  final String token;
  final User user;
  final bool isNewUser;

  GoogleSignInResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
    required this.isNewUser,
  });

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) {
    return GoogleSignInResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      isNewUser: json['isNewUser'] ?? false,
    );
  }
}