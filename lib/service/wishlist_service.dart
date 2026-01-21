// lib/services/wishlist_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';


class WishlistService {
  /// Toggle wishlist (Add/Remove)
  Future<Map<String, dynamic>> toggleWishlist(String productId) async {
    try {
      final userId = SharedPrefHelper.getUserId();
      final token = SharedPrefHelper.getToken();

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found. Please login again.');
      }

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please login again.');
      }

      final response = await http.post(
        Uri.parse(ApiConstants.wishlisturl),
        headers: ApiConstants.getAuthHeaders(token),
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
        }),
      ).timeout(
        ApiConstants.connectionTimeout,
        onTimeout: () {
          throw Exception('Connection timeout. Please try again.');
        },
      );

      final data = jsonDecode(response.body);

      print('response status code for get add and remove wishlist ${response.statusCode}');
            print('response bodyyyyyyyy add and remove wishlist ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Wishlist updated',
          'isAdded': data['message']?.toLowerCase().contains('added') ?? false,
        };
      } else {
        throw Exception(data['message'] ?? 'Failed to update wishlist');
      }
    } catch (e) {
      throw Exception('Error toggling wishlist: ${e.toString()}');
    }
  }

  /// Get user's wishlist
  Future<List<dynamic>> getWishlist() async {
    try {
      final userId = SharedPrefHelper.getUserId();
      final token = SharedPrefHelper.getToken();

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found. Please login again.');
      }

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please login again.');
      }

      // Replace :userid with actual userId
      final url = ApiConstants.getwishlisturl.replaceAll(':userid', userId);

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConstants.getAuthHeaders(token),
      ).timeout(
        ApiConstants.connectionTimeout,
        onTimeout: () {
          throw Exception('Connection timeout. Please try again.');
        },
      );

      final data = jsonDecode(response.body);

       print('response status code for get  wishlist ${response.statusCode}');
            print('response bodyyyyyyyy get  wishlist ${response.body}');

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return data['wishlist'] ?? [];
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch wishlist');
        }
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch wishlist');
      }
    } catch (e) {
      throw Exception('Error fetching wishlist: ${e.toString()}');
    }
  }

  /// Check if product is in wishlist
  Future<bool> isInWishlist(String productId) async {
    try {
      final wishlist = await getWishlist();
      return wishlist.any((item) => item['_id'] == productId);
    } catch (e) {
      return false;
    }
  }
}