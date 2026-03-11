// lib/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:product_app/model/otp_model.dart';
import 'package:product_app/service/otp_service.dart';


/// Provider class for managing authentication state
class OtpProvider with ChangeNotifier {
  final OtpService _authService = OtpService();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;
  String? _authToken;
  bool _isLoggedIn = false;

  // Resend OTP state
  bool _isResending = false;
  int _resendCountdown = 0;

  // Getters
  bool get isLoading => _isLoading;
  bool get isResending => _isResending;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;
  String? get authToken => _authToken;
  bool get isLoggedIn => _isLoggedIn;
  int get resendCountdown => _resendCountdown;
  bool get canResend => _resendCountdown == 0 && !_isResending;

  /// Verify OTP
  Future<bool> verifyOtp({
    required String otp,
    required String token,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // Call service
      final response = await _authService.verifyOtp(
        otp: otp,
        token: token,
      );

      // Update state
      _currentUser = response.user;
      _authToken = response.token;
      _isLoggedIn = true;

      _setLoading(false);
      
      print('✅ Provider: OTP verified, user logged in');
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      print('❌ Provider: OTP verification failed - $e');
      return false;
    }
  }

  /// Resend OTP
  Future<bool> resendOtp({
    required String mobile,
  }) async {
    if (!canResend) {
      _setError('Please wait before resending OTP');
      return false;
    }

    try {
      _isResending = true;
      _clearError();
      notifyListeners();

      // Call service
      final response = await _authService.resendOtp(mobile: mobile);

      // Start countdown timer (e.g., 60 seconds)
      _startResendCountdown(60);

      _isResending = false;
      notifyListeners();

      print('✅ Provider: OTP resent successfully');
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _isResending = false;
      notifyListeners();
      print('❌ Provider: Resend OTP failed - $e');
      return false;
    }
  }

  /// Start resend countdown timer
  void _startResendCountdown(int seconds) {
    _resendCountdown = seconds;
    notifyListeners();

    // Countdown timer
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendCountdown > 0) {
        _resendCountdown--;
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _authService.logout();
      
      // Clear state
      _currentUser = null;
      _authToken = null;
      _isLoggedIn = false;
      _clearError();
      
      notifyListeners();
      print('✅ Provider: User logged out');
    } catch (e) {
      _setError('Logout failed');
      print('❌ Provider: Logout failed - $e');
    }
  }

  /// Check session on app start
  void checkSession() {
    _isLoggedIn = _authService.hasValidSession();
    _authToken = _authService.getAuthToken();
    notifyListeners();
    
    if (_isLoggedIn) {
      print('✅ Provider: Valid session found');
    } else {
      print('ℹ️ Provider: No valid session');
    }
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _clearError();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset resend countdown (useful for testing)
  void resetResendCountdown() {
    _resendCountdown = 0;
    notifyListeners();
  }
}