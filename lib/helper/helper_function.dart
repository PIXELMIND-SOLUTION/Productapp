
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _preferences;

  static const String _keyToken = 'auth_token';
  static const String _keyMobile = 'mobile_number';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyOtp = 'otp';
  static const String _keyUserId = 'user_id';
  static const String _keyFcmToken = 'fcm_token';
  static const String _keyUserData = 'user_data';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _preferences!;
  }

  // Token
  static Future<bool> setToken(String token) async {
    return await prefs.setString(_keyToken, token);
  }

  static Future<bool> saveToken(String token) async {
    return await prefs.setString(_keyToken, token);
  }

  static String? getToken() {
    return prefs.getString(_keyToken);
  }

  static Future<bool> removeToken() async {
    return await prefs.remove(_keyToken);
  }

  // User ID
  static Future<bool> setUserId(String userId) async {
    return await prefs.setString(_keyUserId, userId);
  }

  static Future<bool> saveUserId(String userId) async {
    return await prefs.setString(_keyUserId, userId);
  }

  static String? getUserId() {
    return prefs.getString(_keyUserId);
  }

  static Future<bool> removeUserId() async {
    return await prefs.remove(_keyUserId);
  }

  // Mobile
  static Future<bool> setMobile(String mobile) async {
    return await prefs.setString(_keyMobile, mobile);
  }

  static Future<bool> saveMobile(String mobile) async {
    return await prefs.setString(_keyMobile, mobile);
  }

  static String? getMobile() {
    return prefs.getString(_keyMobile);
  }

  static Future<bool> removeMobile() async {
    return await prefs.remove(_keyMobile);
  }

  // OTP
  static Future<bool> setOtp(String otp) async {
    return await prefs.setString(_keyOtp, otp);
  }

  static Future<bool> saveOtp(String otp) async {
    return await prefs.setString(_keyOtp, otp);
  }

  static String? getOtp() {
    return prefs.getString(_keyOtp);
  }

  static Future<bool> removeOtp() async {
    return await prefs.remove(_keyOtp);
  }

  // Login
  static Future<bool> setLoggedIn(bool value) async {
    return await prefs.setBool(_keyIsLoggedIn, value);
  }

  static bool isLoggedIn() {
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // FCM Token
  static Future<bool> setFCMToken(String token) async {
    return await prefs.setString(_keyFcmToken, token);
  }

  static Future<bool> saveFCMToken(String token) async {
    return await prefs.setString(_keyFcmToken, token);
  }

  static String? getFCMToken() {
    return prefs.getString(_keyFcmToken);
  }

  static Future<bool> removeFCMToken() async {
    return await prefs.remove(_keyFcmToken);
  }

  // User Data
  static Future<bool> setUserData(String userData) async {
    return await prefs.setString(_keyUserData, userData);
  }

  static String? getUserData() {
    return prefs.getString(_keyUserData);
  }

  static Future<bool> removeUserData() async {
    return await prefs.remove(_keyUserData);
  }

  // Clear
  static Future<bool> clear() async {
    return await prefs.clear();
  }

  static Future<bool> clearAll() async {
    return await prefs.clear();
  }

  static Future<void> clearAuthData() async {
    await removeToken();
    await removeMobile();
    await removeOtp();
    await removeUserId();
    await removeFCMToken();
    await removeUserData();
    await setLoggedIn(false);
  }

  // Utility
  static bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static bool hasValidSession() {
    return isLoggedIn() && hasToken();
  }
}