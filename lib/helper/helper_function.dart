// lib/utils/shared_pref_helper.dart

import 'package:shared_preferences/shared_preferences.dart';

/// Helper class for managing SharedPreferences operations
class SharedPrefHelper {
  static SharedPreferences? _preferences;

  // Storage Keys
  static const String _keyToken = 'auth_token';
  static const String _keyMobile = 'mobile_number';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyOtp = 'otp';
  static const String _keyUserId = 'user_id';
  

  /// Initialize SharedPreferences - Call this in main() before runApp()
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get prefs {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _preferences!;
  }

  // ============== TOKEN OPERATIONS ==============
  
  /// Save authentication token
  static Future<bool> saveToken(String token) async {
    return await prefs.setString(_keyToken, token);
  }


   static Future<bool> saveUserId(String userId) async {
  return await prefs.setString(_keyUserId, userId);
}


static String? getUserId() {
  return prefs.getString(_keyUserId);
}
  /// Get saved authentication token
  static String? getToken() {
    return prefs.getString(_keyToken);
  }

  /// Remove authentication token
  static Future<bool> removeToken() async {
    return await prefs.remove(_keyToken);
  }

  // ============== MOBILE NUMBER OPERATIONS ==============
  
  /// Save mobile number
  static Future<bool> saveMobile(String mobile) async {
    return await prefs.setString(_keyMobile, mobile);
  }

  /// Get saved mobile number
  static String? getMobile() {
    return prefs.getString(_keyMobile);
  }

  /// Remove mobile number
  static Future<bool> removeMobile() async {
    return await prefs.remove(_keyMobile);
  }


static Future<bool> removeUserId() async {
  return await prefs.remove(_keyUserId);
}
  // ============== OTP OPERATIONS ==============
  // Note: For development/testing only - In production, OTP should not be stored
  
  /// Save OTP (for development/testing)
  static Future<bool> saveOtp(String otp) async {
    return await prefs.setString(_keyOtp, otp);
  }

  /// Get saved OTP
  static String? getOtp() {
    return prefs.getString(_keyOtp);
  }

  /// Remove OTP
  static Future<bool> removeOtp() async {
    return await prefs.remove(_keyOtp);
  }

  // ============== LOGIN STATE OPERATIONS ==============
  
  /// Set login status
  static Future<bool> setLoggedIn(bool value) async {
    return await prefs.setBool(_keyIsLoggedIn, value);
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // ============== CLEAR OPERATIONS ==============
  
  /// Clear all stored data (complete logout)
  static Future<bool> clearAll() async {
    return await prefs.clear();
  }

  /// Clear only authentication related data
  static Future<void> clearAuthData() async {
    await removeToken();
    await removeMobile();
    await removeOtp();
     await removeUserId(); 
    await setLoggedIn(false);
  }

  // ============== UTILITY METHODS ==============
  
  /// Check if token exists
  static bool hasToken() {
    return getToken() != null && getToken()!.isNotEmpty;
  }

  /// Check if user session is valid
  static bool hasValidSession() {
    return isLoggedIn() && hasToken();
  }
}