// lib/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/model/login_model.dart';
import 'package:product_app/service/login_service.dart';


/// Provider class for managing authentication state
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  // Private state variables
  OtpResponseModel? _otpResponse;
  bool _isLoading = false;
  String? _errorMessage;
  String? _mobile;

  // ============== GETTERS ==============
  
  /// Get OTP response data
  OtpResponseModel? get otpResponse => _otpResponse;
  
  /// Check if any operation is in progress
  bool get isLoading => _isLoading;
  
  /// Get current error message
  String? get errorMessage => _errorMessage;
  
  /// Get saved mobile number
  String? get mobile => _mobile;
  
  /// Check if user is authenticated
  bool get isAuthenticated => SharedPrefHelper.isLoggedIn();
  
  /// Get authentication token
  String? get token => SharedPrefHelper.getToken();

  // ============== PRIVATE METHODS ==============
  
  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // ============== PUBLIC METHODS ==============
  
  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Send OTP to mobile number
  /// Returns true if OTP sent successfully
  Future<bool> sendOtp(String mobile) async {
    try {
      _setLoading(true);
      _setError(null);

      // Validate and format mobile number
      final formattedMobile = _authService.formatMobile(mobile);
      if (!_authService.isValidMobile(formattedMobile)) {
        _setError('Please enter a valid 10-digit mobile number');
        _setLoading(false);
        return false;
      }

      // Call API service
      _otpResponse = await _authService.sendOtp(formattedMobile);

      if (_otpResponse != null && _otpResponse!.success) {
        _mobile = formattedMobile;
        
        // Save data to SharedPreferences
        await SharedPrefHelper.saveMobile(formattedMobile);
        await SharedPrefHelper.saveToken(_otpResponse!.token);
        await SharedPrefHelper.saveOtp(_otpResponse!.otp);
        
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(_otpResponse?.message ?? 'Failed to send OTP');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  /// Verify entered OTP
  /// Returns true if OTP is valid
  Future<bool> verifyOtp(String enteredOtp) async {
    try {
      _setLoading(true);
      _setError(null);

      // Validate OTP format
      if (!_authService.isValidOtp(enteredOtp)) {
        _setError('Please enter a valid 4-digit OTP');
        _setLoading(false);
        return false;
      }

      // Get saved OTP from SharedPreferences
      final savedOtp = SharedPrefHelper.getOtp();

      if (savedOtp == null) {
        _setError('OTP expired. Please request a new OTP');
        _setLoading(false);
        return false;
      }

      // Verify OTP
      if (enteredOtp == savedOtp) {
        // OTP verified successfully
        await SharedPrefHelper.setLoggedIn(true);
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError('Invalid OTP. Please try again');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  /// Resend OTP
  Future<bool> resendOtp() async {
    if (_mobile != null) {
      return await sendOtp(_mobile!);
    } else {
      _setError('Mobile number not found. Please start again');
      return false;
    }
  }

  /// Logout user and clear all data
  Future<void> logout() async {
    try {
      await SharedPrefHelper.clearAuthData();
      _otpResponse = null;
      _mobile = null;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _setError('Failed to logout: $e');
    }
  }

  /// Load saved session data
  Future<void> loadSession() async {
    try {
      _mobile = SharedPrefHelper.getMobile();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading session: $e');
    }
  }

  /// Check if user has valid session
  bool hasValidSession() {
    return SharedPrefHelper.hasValidSession();
  }
}