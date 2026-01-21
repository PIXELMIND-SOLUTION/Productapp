// // lib/services/profile_service.dart

// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:product_app/constant/api_constant.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'dart:convert';

// class ProfileService {
//   Future<Map<String, dynamic>> updateProfile({
//     required String name,
//     required String email,
//     File? profileImage,

//   }) async {
//     try {
//       // Get token from shared preferences
//       final token = SharedPrefHelper.getToken();

//       if (token == null || token.isEmpty) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       // Create multipart request
//       var request = http.MultipartRequest(
//         'PUT',
//         Uri.parse(ApiConstants.updateProfileurl),
//       );

//       // Add headers
//       request.headers.addAll({
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       });

//       // Add form fields
//       request.fields['name'] = name;
//       request.fields['email'] = email;

//       // Add profile image if provided
//       if (profileImage != null) {
//         var stream = http.ByteStream(profileImage.openRead());
//         var length = await profileImage.length();

//         var multipartFile = http.MultipartFile(
//           'profileImage',
//           stream,
//           length,
//           filename: profileImage.path.split('/').last,
//         );

//         request.files.add(multipartFile);
//       }

//       // Send request
//       var streamedResponse = await request.send().timeout(
//             ApiConstants.connectionTimeout,
//           );

//       // Get response
//       var response = await http.Response.fromStream(streamedResponse);

//       print('Response status code for update profile ${response.statusCode}');
//       print(
//           'Response bodyyyyyyyyyyyyyy code for update profile ${response.body}');

//       // Parse response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = json.decode(response.body);
//         return {
//           'success': true,
//           'message': data['message'] ?? 'Profile updated successfully',
//           'data': data['data'],
//         };
//       } else {
//         final data = json.decode(response.body);
//         return {
//           'success': false,
//           'message': data['message'] ?? 'Failed to update profile',
//         };
//       }
//     } on SocketException {
//       return {
//         'success': false,
//         'message': 'No internet connection',
//       };
//     } on http.ClientException {
//       return {
//         'success': false,
//         'message': 'Network error occurred',
//       };
//     } on FormatException {
//       return {
//         'success': false,
//         'message': 'Invalid response format',
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'An unexpected error occurred: ${e.toString()}',
//       };
//     }
//   }




//     Future<Map<String, dynamic>> getProfile(String userId) async {
//     try {
//       final token = SharedPrefHelper.getUserId();

//       if (token == null || token.isEmpty) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/api/auth/profile/$userId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       ).timeout(ApiConstants.connectionTimeout);

//       print('Response status code for get profile: ${response.statusCode}');
//       print('Response body for get profile: ${response.body}');
//       print('useridddddddddddddddd $userId');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return {
//           'success': true,
//           'message': data['message'] ?? 'Profile fetched successfully',
//           'user': data['user'],
//         };
//       } else {
//         final data = json.decode(response.body);
//         return {
//           'success': false,
//           'message': data['message'] ?? 'Failed to fetch profile',
//         };
//       }
//     } on SocketException {
//       return {
//         'success': false,
//         'message': 'No internet connection',
//       };
//     } on http.ClientException {
//       return {
//         'success': false,
//         'message': 'Network error occurred',
//       };
//     } on FormatException {
//       return {
//         'success': false,
//         'message': 'Invalid response format',
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'An unexpected error occurred: ${e.toString()}',
//       };
//     }
//   }
// }















// lib/services/profile_service.dart

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'dart:convert';

class ProfileService {
  Future<Map<String, dynamic>> updateProfile({
    required String userId,  // Added userId parameter
    required String name,
    required String email,
    File? profileImage,
  }) async {
    try {
      // Get token from shared preferences
      final token = SharedPrefHelper.getToken();

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      // Construct URL with userId
      final url = '${ApiConstants.baseUrl}/api/auth/update-profile/$userId';

      // Create multipart request
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(url),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Add form fields
      request.fields['name'] = name;
      request.fields['email'] = email;

      // Add profile image if provided
      if (profileImage != null) {
        var stream = http.ByteStream(profileImage.openRead());
        var length = await profileImage.length();

        var multipartFile = http.MultipartFile(
          'profileImage',
          stream,
          length,
          filename: profileImage.path.split('/').last,
        );

        request.files.add(multipartFile);
      }

      // Send request
      var streamedResponse = await request.send().timeout(
            ApiConstants.connectionTimeout,
          );

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status code for update profile ${response.statusCode}');
      print('Response body for update profile ${response.body}');

      // Parse response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Profile updated successfully',
          'data': data['data'],
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update profile',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Network error occurred',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getProfile(String userId) async {
    try {
      final token = SharedPrefHelper.getToken();  // Changed from getUserId() to getToken()

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/profile/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ).timeout(ApiConstants.connectionTimeout);

      print('Response status code for get profile: ${response.statusCode}');
      print('Response body for get profile: ${response.body}');
      print('userId: $userId');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Profile fetched successfully',
          'user': data['user'],
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch profile',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Network error occurred',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }
}