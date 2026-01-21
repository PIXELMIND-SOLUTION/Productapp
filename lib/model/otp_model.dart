// lib/models/verify_otp_models.dart

/// Verify OTP Request Model
class VerifyOtpRequest {
  final String otp;
  final String token;

  VerifyOtpRequest({
    required this.otp,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'VerifyOtpRequest(otp: $otp, token: ${token.substring(0, 20)}...)';
  }
}

/// User Model
class User {
  final String mobile;
  final String name;
  final String email;
  final String profileImage;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.mobile,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      mobile: json['mobile'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(id: $id, mobile: $mobile, name: $name)';
  }
}

/// Verify OTP Response Model
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
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  String toString() {
    return 'VerifyOtpResponse(success: $success, message: $message, user: ${user.toString()})';
  }
}

/// Resend OTP Request Model
class ResendOtpRequest {
  final String mobile;

  ResendOtpRequest({required this.mobile});

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
    };
  }

  @override
  String toString() {
    return 'ResendOtpRequest(mobile: $mobile)';
  }
}

/// Resend OTP Response Model
class ResendOtpResponse {
  final bool success;
  final String message;
  final String otp;
  final String token;

  ResendOtpResponse({
    required this.success,
    required this.message,
    required this.otp,
    required this.token,
  });

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      otp: json['otp'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'otp': otp,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'ResendOtpResponse(success: $success, message: $message, otp: $otp)';
  }
}