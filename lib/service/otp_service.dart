// lib/services/auth_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/model/otp_model.dart';


class OtpService {
  Future<VerifyOtpResponse> verifyOtp({
    required String otp,
    required String token,
  }) async {
    try {
      // Create request body
      final request = VerifyOtpRequest(otp: otp, token: token);
      
      print('🔐 Verifying OTP...');
      print('URL: ${ApiConstants.verifyOtpUrl}');
      print('Request: ${request.toString()}');

      // Make API call
      final response = await http
          .post(
            Uri.parse(ApiConstants.verifyOtpUrl),
            headers: ApiConstants.headers,
            body: jsonEncode(request.toJson()),
          )
          .timeout(ApiConstants.connectionTimeout);

      print('📡 Response Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      // Parse response
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Handle different status codes
      if (response.statusCode == 200) {
        final verifyResponse = VerifyOtpResponse.fromJson(jsonResponse);
        
        if (verifyResponse.success) {
          // Save authentication data
          await SharedPrefHelper.saveToken(verifyResponse.token);
           await SharedPrefHelper.saveUserId(verifyResponse.user.id);
          await SharedPrefHelper.setLoggedIn(true);

          print('useridd while otp login ${verifyResponse.user.id}');
          
          print('✅ OTP verified successfully');
          return verifyResponse;
        } else {
          throw Exception(verifyResponse.message);
        }
      } else if (response.statusCode == 400) {
        // Invalid OTP or token
        throw Exception(jsonResponse['message'] ?? 'Invalid OTP or token');
      } else if (response.statusCode == 401) {
        // Unauthorized
        throw Exception(jsonResponse['message'] ?? 'OTP verification failed');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException {
      throw Exception('Network error. Please try again.');
    } on FormatException {
      throw Exception('Invalid response from server.');
    } catch (e) {
      print('❌ Error verifying OTP: $e');
      rethrow;
    }
  }

  Future<ResendOtpResponse> resendOtp({
    required String mobile,
  }) async {
    try {
      // Create request body
      final request = ResendOtpRequest(mobile: mobile);
      
      print('📲 Resending OTP...');
      print('URL: ${ApiConstants.resendOtpUrl}');
      print('Request: ${request.toString()}');

      // Make API call
      final response = await http
          .post(
            Uri.parse(ApiConstants.resendOtpUrl),
            headers: ApiConstants.headers,
            body: jsonEncode(request.toJson()),
          )
          .timeout(ApiConstants.connectionTimeout);

      print('📡 Response Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      // Parse response
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Handle different status codes
      if (response.statusCode == 200) {
        final resendResponse = ResendOtpResponse.fromJson(jsonResponse);
        
        if (resendResponse.success) {
          // Save OTP for development/testing (remove in production)
          await SharedPrefHelper.saveOtp(resendResponse.otp);
          
          print('✅ OTP resent successfully');
          return resendResponse;
        } else {
          throw Exception(resendResponse.message);
        }
      } else if (response.statusCode == 400) {
        // Bad request
        throw Exception(jsonResponse['message'] ?? 'Invalid mobile number');
      } else if (response.statusCode == 429) {
        // Too many requests
        throw Exception(jsonResponse['message'] ?? 'Too many requests. Please try again later.');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException {
      throw Exception('Network error. Please try again.');
    } on FormatException {
      throw Exception('Invalid response from server.');
    } catch (e) {
      print('❌ Error resending OTP: $e');
      rethrow;
    }
  }

  /// Logout - Clear all authentication data
  Future<void> logout() async {
    try {
      print('🚪 Logging out...');
      await SharedPrefHelper.clearAuthData();
      print('✅ Logout successful');
    } catch (e) {
      print('❌ Error during logout: $e');
      rethrow;
    }
  }

  /// Check if user has valid session
  bool hasValidSession() {
    return SharedPrefHelper.hasValidSession();
  }

  /// Get current auth token
  String? getAuthToken() {
    return SharedPrefHelper.getToken();
  }
}