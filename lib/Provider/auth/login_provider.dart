// lib/providers/auth_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/model/user_model.dart';
import 'package:product_app/service/firebase_auth_service.dart';
import 'package:product_app/service/login_service.dart';
import 'package:product_app/service/notification_service.dart';
import 'package:product_app/utils/shared_preference.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();

  // State
  AuthStatus _status = AuthStatus.initial;
  User? _currentUser;
  String? _authToken;
  String? _errorMessage;
  String? _verificationId;

  // Getters
  AuthStatus get status => _status;
  User? get currentUser => _currentUser;
  String? get authToken => _authToken;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // Constructor
  AuthProvider() {
    checkAuthStatus();
  }

  // Set loading state
  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  // Set authenticated state
  void _setAuthenticated(User user, String token) {
    _currentUser = user;
    _authToken = token;
    _status = AuthStatus.authenticated;
    _errorMessage = null;
    notifyListeners();
  }

  // Set error state
  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  // Set unauthenticated state
  void _setUnauthenticated() {
    _status = AuthStatus.unauthenticated;
    _currentUser = null;
    _authToken = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Check existing auth status
  Future<void> checkAuthStatus() async {
    final token = SharedPrefHelper.getToken();
    if (token != null && token.isNotEmpty) {
      try {
        _setLoading();
        // Verify token with backend (optional)
        // For now, just set authenticated
        _authToken = token;
        _status = AuthStatus.authenticated;
        notifyListeners();
      } catch (e) {
        _setUnauthenticated();
      }
    } else {
      _setUnauthenticated();
    }
  }

  // Send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    try {
      _setLoading();

      // Format phone number
      String formattedNumber = phoneNumber;
      if (!phoneNumber.startsWith('+')) {
        formattedNumber = '+91$phoneNumber'; // For India
      }

      // 1. Send OTP via Firebase
      _verificationId = await _firebaseAuth.sendOtp(formattedNumber);

      if (_verificationId != null) {
        await SharedPrefHelper.setMobile(formattedNumber);
        _status = AuthStatus.initial;
        notifyListeners();
        return true;
      } else {
        _setError('Failed to send OTP');
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<bool> sendOtp1(String phoneNumber) async {
    try {
      _setLoading();

      String formattedNumber = phoneNumber;
      if (!phoneNumber.startsWith('+')) {
        formattedNumber = '+91$phoneNumber';
      }

      /// CALL BACKEND SEND OTP API
      final response = await _authService.sendOtp(
        formattedNumber,
      );

      if (response.success) {
        await SharedPrefHelper.setMobile(formattedNumber);

        _status = AuthStatus.initial;
        notifyListeners();
        return true;
      } else {
        _setError(response.message);
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(
    String otp,
  ) async {
    try {
      _setLoading();

      if (_verificationId == null) {
        _setError('Verification ID not found. Please resend OTP.');
        return false;
      }

      // 1. Verify OTP with Firebase
      firebase_auth.User? firebaseUser = await _firebaseAuth.verifyOtp(
        _verificationId!,
        otp,
      );

      if (firebaseUser == null) {
        _setError('Invalid OTP');
        return false;
      }

      // 2. Get Firebase ID Token
      String? idToken = await firebaseUser.getIdToken();

      if (idToken == null) {
        _setError('Failed to get authentication token');
        return false;
      }

      // 3. Get FCM Token
      String? fcmToken = await NotificationService.getFCMToken();

      print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$idToken");
      print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$fcmToken");

      print(
          "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii${firebaseUser.phoneNumber}");

      // 4. Send to your backend for verification
      final response = await _authService.verifyOtpWithFirebase(
        idToken: idToken,
        fcmToken: fcmToken,
        phoneNumber: firebaseUser.phoneNumber,
      );

      if (response.success) {
        // Save auth data
        await SharedPrefHelper.setToken(response.token);
        await SharedPrefHelper.setUserId(response.user.id);
        await SharedPrefHelper.setLoggedIn(true);

        _setAuthenticated(response.user, response.token);
        return true;
      } else {
        _setError(response.message);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<bool> verifyOtp1(String otp, String mobile) async {
    try {
      _setLoading();

      // 3. Get FCM Token
      String? fcmToken = await NotificationService.getFCMToken();

      print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$fcmToken");

      // 4. Send to your backend for verification
      final response = await _authService.verifyOtp(
          fcmToken: fcmToken, otp: otp, mobile: mobile);

      if (response.success) {
        // Save auth data
        await SharedPrefHelper.setToken(response.token);
        await SharedPrefHelper.setUserId(response.user.id);
        await SharedPrefHelper.setLoggedIn(true);

        _setAuthenticated(response.user, response.token);
        return true;
      } else {
        _setError(response.message);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading();

      // 1. Sign in with Google via Firebase
      firebase_auth.User? firebaseUser = await _firebaseAuth.signInWithGoogle();

      if (firebaseUser == null) {
        _setError('Google Sign-In cancelled');
        return false;
      }

      // 2. Get Firebase ID Token
      String? idToken = await firebaseUser.getIdToken();

      if (idToken == null) {
        _setError('Failed to get authentication token');
        return false;
      }

      // 3. Get FCM Token
      String? fcmToken = await NotificationService.getFCMToken();

      // 4. Send to your backend
      final response = await _authService.googleSignIn(
          idToken: idToken,
          fcmToken: fcmToken,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
          profileImage: firebaseUser.photoURL,
          phoneNumber: firebaseUser.phoneNumber);

      if (response.success) {
        // Save auth data
        await SharedPrefHelper.setToken(response.token);
        await SharedPrefHelper.setUserId(response.user.id);
        await SharedPrefHelper.setLoggedIn(true);

        _setAuthenticated(response.user, response.token);
        return true;
      } else {
        _setError(response.message);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  // Resend OTP
  Future<bool> resendOtp(String phoneNumber) async {
    try {
      _setLoading();

      // Format phone number
      String formattedNumber = phoneNumber;
      if (!phoneNumber.startsWith('+')) {
        formattedNumber = '+91$phoneNumber';
      }

      // Resend OTP via Firebase
      _verificationId = await _firebaseAuth.sendOtp(formattedNumber);

      if (_verificationId != null) {
        // Also resend via backend if needed
        // await _authService.resendOtp(formattedNumber);
        // _status = AuthStatus.initial;
        // notifyListeners();
        return true;
      } else {
        _setError('Failed to resend OTP');
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      _setLoading();

      // Sign out from Firebase
      await _firebaseAuth.signOut();

      // Clear local storage
      await SharedPrefHelper.clear();

      _setUnauthenticated();
    } catch (e) {
      _setError('Logout failed');
    }
  }
}
