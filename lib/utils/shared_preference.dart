// // lib/utils/shared_prefs.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   static late SharedPreferences _prefs;

//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // Auth Token
//   static Future<void> setToken(String token) async {
//     await _prefs.setString('auth_token', token);
//   }

//   static String? getToken() {
//     return _prefs.getString('auth_token');
//   }

//   // User ID
//   static Future<void> setUserId(String userId) async {
//     await _prefs.setString('user_id', userId);
//   }

//   static String? getUserId() {
//     return _prefs.getString('user_id');
//   }

//   // User Data
//   static Future<void> setUserData(Map<String, dynamic> userData) async {
//     await _prefs.setString('user_data', userData.toString());
//   }

//   static Map<String, dynamic>? getUserData() {
//     final data = _prefs.getString('user_data');
//     if (data != null) {
//       // Parse if needed
//     }
//     return null;
//   }

//   // Login Status
//   static Future<void> setLoggedIn(bool value) async {
//     await _prefs.setBool('is_logged_in', value);
//   }

//   static bool isLoggedIn() {
//     return _prefs.getBool('is_logged_in') ?? false;
//   }

//   // FCM Token
//   static Future<void> setFCMToken(String token) async {
//     await _prefs.setString('fcm_token', token);
//   }

//   static String? getFCMToken() {
//     return _prefs.getString('fcm_token');
//   }

//   // Mobile Number
//   static Future<void> setMobile(String mobile) async {
//     await _prefs.setString('mobile', mobile);
//   }

//   static String? getMobile() {
//     return _prefs.getString('mobile');
//   }

//   // Clear all data
//   static Future<void> clear() async {
//     await _prefs.clear();
//   }
// }