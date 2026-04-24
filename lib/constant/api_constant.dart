// lib/constants/api_constants.dart

class ApiConstants {
  // Base URL
  // static const String baseUrl = 'https://estatehouz-backend.onrender.com';

  static const String baseUrl = 'http://31.97.228.17:9174';

  // API Endpoints
  static const String sendOtp = '$baseUrl/api/auth/send-otp';
  static const String verifyOtp = '$baseUrl/api/auth/verify-otp';
  static const String verifyOtpWithFirebase =
      '$baseUrl/api/auth/verify-firebase-otp';
  static const String resendOtp = '/api/auth/resend-otp';
  static const String googleSignIn = '$baseUrl/api/auth/google-signin';
  static const String updateProfile = '/api/auth/update-profile/:userId';
  static const String livelocation = '/api/auth/update-location/:userId';
  static const String wishlist = '/api/wishlist/toggle';
  static const String getwishlist = '/api/wishlist/:userid';
  static const String createListing = '/api/create/:subCategoryId';
  static const String listProduct = '/api/getallProducts';
  static const String updatelocationurl =
      '$baseUrl/api/auth/update-location/:userId';

  // Full URLs
  static String get sendOtpUrl => '$baseUrl$sendOtp';
  static String get verifyOtpUrl => '$baseUrl$verifyOtp';
  static String get resendOtpUrl => '$baseUrl$resendOtp';
  static String get updateProfileurl => '$baseUrl$updateProfile';
  // static String get updatelocationurl => '$baseUrl$livelocation';
  static String get wishlisturl => '$baseUrl$wishlist';
  static String get getwishlisturl => '$baseUrl$getwishlist';
  static String get createlistUrl => '$baseUrl$createListing';
  static String get getProductlist => '$baseUrl$listProduct';

  // Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Map<String, String> getAuthHeaders(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  // Timeout durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
