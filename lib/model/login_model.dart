// lib/models/otp_response_model.dart

/// Response Model - Maps the API response
class OtpResponseModel {
  final bool success;
  final String message;
  final String otp;
  final String token;

  OtpResponseModel({
    required this.success,
    required this.message,
    required this.otp,
    required this.token,
  });

  // Convert JSON to Model
  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      otp: json['otp'] ?? '',
      token: json['token'] ?? '',
    );
  }

  // Convert Model to JSON
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
    return 'OtpResponseModel(success: $success, message: $message, otp: $otp, token: $token)';
  }
}

/// Request Model - For sending OTP request
class SendOtpRequest {
  final String mobile;

  SendOtpRequest({required this.mobile});

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
    };
  }

  @override
  String toString() {
    return 'SendOtpRequest(mobile: $mobile)';
  }
}