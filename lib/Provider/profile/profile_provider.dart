// // lib/providers/profile_provider.dart

// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:product_app/service/update_profile_service.dart';

// class ProfileProvider with ChangeNotifier {
//   final ProfileService _profileService = ProfileService();

//   // State variables
//   bool _isLoading = false;
//   String? _errorMessage;
//   Map<String, dynamic>? _profileData;

//   // Getters
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   Map<String, dynamic>? get profileData => _profileData;

//   // Profile fields
//   String? get name => _profileData?['name'];
//   String? get email => _profileData?['email'];
//   String? get profileImageUrl => _profileData?['profileImage'];
//   String? get mobile => _profileData?['mobile'];

//   /// Update user profile
//   Future<bool> updateProfile({
//     required String name,
//     required String email,
//     File? profileImage,
//   }) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final result = await _profileService.updateProfile(
//         name: name,
//         email: email,
//         profileImage: profileImage,
//       );

//       print('nameeeeeeeeeeeeee $name');
//       print('emaillllllllllllll $email');
//       print('profileeeeimage $profileImage');

//       _isLoading = false;

//       if (result['success']) {
//         _profileData = result['data'];
//         _errorMessage = null;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = result['message'];
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = 'An unexpected error occurred';
//       notifyListeners();
//       return false;
//     }
//   }



//     Future<bool> fetchProfile(String userId) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final result = await _profileService.getProfile(userId);

//       print('Fetching profile for userId: $userId');
//       print('Fetch profile result: $result');

//       _isLoading = false;

//       if (result['success']) {
//         _profileData = result['user'];
//         _errorMessage = null;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = result['message'];
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = 'An unexpected error occurred: ${e.toString()}';
//       notifyListeners();
//       return false;
//     }
//   }

//   /// Fetch user profile
//   // Future<bool> fetchProfile() async {
//   //   _isLoading = true;
//   //   _errorMessage = null;
//   //   notifyListeners();

//   //   try {
//   //     final result = await _profileService.getProfile();

//   //     _isLoading = false;

//   //     if (result['success']) {
//   //       _profileData = result['data'];
//   //       _errorMessage = null;
//   //       notifyListeners();
//   //       return true;
//   //     } else {
//   //       _errorMessage = result['message'];
//   //       notifyListeners();
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _isLoading = false;
//   //     _errorMessage = 'An unexpected error occurred';
//   //     notifyListeners();
//   //     return false;
//   //   }
//   // }

//   /// Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   /// Clear profile data
//   void clearProfile() {
//     _profileData = null;
//     _errorMessage = null;
//     _isLoading = false;
//     notifyListeners();
//   }

//   /// Reset state
//   void reset() {
//     _isLoading = false;
//     _errorMessage = null;
//     _profileData = null;
//     notifyListeners();
//   }
// }















// lib/providers/profile_provider.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:product_app/service/update_profile_service.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _profileData;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get profileData => _profileData;

  // Profile fields
  String? get name => _profileData?['name'];
  String? get email => _profileData?['email'];
  String? get profileImageUrl => _profileData?['profileImage'];
  String? get mobile => _profileData?['mobile'];

  /// Update user profile
  Future<bool> updateProfile({
    required String userId,  // Added userId parameter
    required String name,
    required String email,
    File? profileImage,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _profileService.updateProfile(
        userId: userId,  // Pass userId to service
        name: name,
        email: email,
        profileImage: profileImage,
      );

      print('userId: $userId');
      print('name: $name');
      print('email: $email');
      print('profileImage: $profileImage');

      _isLoading = false;

      if (result['success']) {
        _profileData = result['data'];
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  /// Fetch user profile
  Future<bool> fetchProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _profileService.getProfile(userId);

      print('Fetching profile for userId: $userId');
      print('Fetch profile result: $result');

      _isLoading = false;

      if (result['success']) {
        _profileData = result['user'];
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear profile data
  void clearProfile() {
    _profileData = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Reset state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _profileData = null;
    notifyListeners();
  }
}