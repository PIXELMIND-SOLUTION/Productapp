// lib/services/auth_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/model/login_model.dart';

class AuthService {

  Future<OtpResponseModel?> sendOtp(String mobile) async {
    try {
      final request = SendOtpRequest(mobile: mobile);
      final response = await http
          .post(
            Uri.parse(ApiConstants.sendOtpUrl),
            headers: ApiConstants.headers,
            body: jsonEncode(request.toJson()),
          )
          .timeout(ApiConstants.connectionTimeout);

      print('Response status code for send otp ${response.statusCode}');
      print('Response bodyyyyyyyyy code for send otp ${response.body}');

      // Check response status
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OtpResponseModel.fromJson(data);
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Bad request');
      } else if (response.statusCode == 500) {
        throw Exception('Server error. Please try again later');
      } else {
        throw Exception('Failed to send OTP: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on http.ClientException {
      throw Exception('Failed to connect to server');
    } on FormatException {
      throw Exception('Invalid response format');
    } on TimeoutException {
      throw Exception('Request timeout. Please try again');
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    }
  }


  bool isValidMobile(String mobile) {
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(mobile);
  }

  String formatMobile(String mobile) {
    return mobile.replaceAll(RegExp(r'[^\d]'), '');
  }

  bool isValidOtp(String otp) {
    final regex = RegExp(r'^\d{4}$');
    return regex.hasMatch(otp);
  }
}
