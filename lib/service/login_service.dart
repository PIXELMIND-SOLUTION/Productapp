// // lib/services/auth_service.dart

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:product_app/constant/api_constant.dart';
// import 'package:product_app/model/login_model.dart';

// class AuthService {

//   Future<OtpResponseModel?> sendOtp(String mobile) async {
//     try {
//       final request = SendOtpRequest(mobile: mobile);
//       final response = await http
//           .post(
//             Uri.parse(ApiConstants.sendOtpUrl),
//             headers: ApiConstants.headers,
//             body: jsonEncode(request.toJson()),
//           )
//           .timeout(ApiConstants.connectionTimeout);

//       print('Response status code for send otp ${response.statusCode}');
//       print('Response bodyyyyyyyyy code for send otp ${response.body}');

//       // Check response status
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return OtpResponseModel.fromJson(data);
//       } else if (response.statusCode == 400) {
//         final data = jsonDecode(response.body);
//         throw Exception(data['message'] ?? 'Bad request');
//       } else if (response.statusCode == 500) {
//         throw Exception('Server error. Please try again later');
//       } else {
//         throw Exception('Failed to send OTP: ${response.statusCode}');
//       }
//     } on SocketException {
//       throw Exception('No internet connection');
//     } on http.ClientException {
//       throw Exception('Failed to connect to server');
//     } on FormatException {
//       throw Exception('Invalid response format');
//     } on TimeoutException {
//       throw Exception('Request timeout. Please try again');
//     } catch (e) {
//       throw Exception('Error sending OTP: $e');
//     }
//   }


//   bool isValidMobile(String mobile) {
//     final regex = RegExp(r'^[6-9]\d{9}$');
//     return regex.hasMatch(mobile);
//   }

//   String formatMobile(String mobile) {
//     return mobile.replaceAll(RegExp(r'[^\d]'), '');
//   }

//   bool isValidOtp(String otp) {
//     final regex = RegExp(r'^\d{4}$');
//     return regex.hasMatch(otp);
//   }
// }















// lib/services/auth_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/model/auth_response.dart';

class AuthService {
  // Send OTP (for your existing backend)
  Future<OtpResponse> sendOtp(String mobile) async {
    try {
            print("llllllllllllllllllllllllllllllllllll$mobile");

      final response = await http.post(
        Uri.parse(ApiConstants.sendOtp),
        headers: ApiConstants.headers,
        body: jsonEncode({'mobile': mobile}),
      ).timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);

      print("llllllllllllllllllllllllllllllllllll${response.body}");

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to send OTP');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // Verify OTP with Firebase ID Token
  Future<VerifyOtpResponse> verifyOtpWithFirebase({
    required String idToken,
    String? fcmToken,
    String? phoneNumber,
  }) async {
    try {
        print("dfgdsgdsgdsgdsfgdsfgd$idToken");
            print("sadgdsfgdsfgdsfds$fcmToken");

      print("sdfgdsfdsfdfds$phoneNumber");
      final response = await http.post(
        Uri.parse(ApiConstants.verifyOtpWithFirebase),
        headers: ApiConstants.headers,
        body: jsonEncode({
          'idToken': idToken,
          'fcmToken': fcmToken,
          'phoneNumber': phoneNumber,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Verification failed');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }



    Future<VerifyOtpResponse> verifyOtp({
    String? fcmToken,
    String? otp,
    String? mobile
  }) async {
    try {

      print("pppppppppppppppppp$fcmToken");
print("pppppppppppppppppp$otp");
print("pppppppppppppppppp$mobile");

      final response = await http.post(
        Uri.parse(ApiConstants.verifyOtp),
        headers: ApiConstants.headers,
        body: jsonEncode({
          'fcmToken': fcmToken,
          'otp': otp,
          "mobile": mobile
        }),
      );
            print("lllllllllllllllllllll${response.body}");


      final data = jsonDecode(response.body);

      print("lllllllllllllllllllll${response.body}");

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Verification failed');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // Google Sign In
  Future<GoogleSignInResponse> googleSignIn({
    required String idToken,
    String? fcmToken,
    String? email,
    String? name,
    String? profileImage,
    String? phoneNumber
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.googleSignIn),
        headers: ApiConstants.headers,
        body: jsonEncode({
          'idToken': idToken,
          'fcmToken': fcmToken,
          'email': email,
          'name': name,
          'profileImage': profileImage,
          'phoneNumber': phoneNumber
        }),
      ).timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);
      print("rrrrrrrrrrrrrrrrrrrrr$phoneNumber");

      print("rrrrrrrrrrrrrrrrrrrrr${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GoogleSignInResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Google Sign-In failed');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // Resend OTP
  Future<OtpResponse> resendOtp(String mobile) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.resendOtp),
        headers: ApiConstants.headers,
        body: jsonEncode({'mobile': mobile}),
      ).timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to resend OTP');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}