// // lib/services/product_service.dart

// // ignore_for_file: unused_import

// import 'dart:convert';
// import 'dart:io';
// import 'dart:math' show sin, cos, sqrt, asin;
// import 'package:http/http.dart' as http;
// import 'package:product_app/constant/api_constant.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/model/product_model.dart';


// class ProductService {
//   Future<ProductListResponse> getAllProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse(ApiConstants.getProductlist),
//         headers: ApiConstants.headers,
//       ).timeout(ApiConstants.connectionTimeout);


//       print('Response status code for get all product ${response.statusCode}');
//       print('Response bodyyyyyyyyyyy code for get all product ${response.body}');


//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return ProductListResponse.fromJson(data);
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching products: $e');
//     }
//   }

//   /// Create a new listing with images
//   Future<Map<String, dynamic>> createListing({
//     required String subCategoryId,
//     required String name,
//     required String type,
//     required String address,
//     required String description,
//     required double latitude,
//     required double longitude,
//     required List<String> featureNames,
//     required List<File> images,
//     List<File>? featureImages,
//   }) async {
//     try {
//       final String? userId = SharedPrefHelper.getUserId();
//       final String? token = SharedPrefHelper.getToken();

//       if (userId == null || userId.isEmpty) {
//         throw Exception('User ID not found. Please login again.');
//       }

//       // Create multipart request
//       final uri = Uri.parse(
//         ApiConstants.createlistUrl.replaceAll(':subCategoryId', subCategoryId),
//       );
//       final request = http.MultipartRequest('POST', uri);

//       print('melvinnnnnnnnnnnnnnnnnn $subCategoryId');

//       // Add headers
//       if (token != null && token.isNotEmpty) {
//         request.headers.addAll({
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         });
//       }

//       // Add text fields
//       request.fields['name'] = name;
//       request.fields['type'] = type;
//       request.fields['address'] = address;
//       request.fields['description'] = description;
//       request.fields['latitude'] = latitude.toString();
//       request.fields['longitude'] = longitude.toString();
//       request.fields['userId'] = userId;

//       // Add feature names as JSON array
//       request.fields['featureNames'] = json.encode(featureNames);

//       // Add property images
//       for (var imageFile in images) {
//         final file = await http.MultipartFile.fromPath(
//           'images',
//           imageFile.path,
//         );
//         request.files.add(file);
//       }

//       // Add feature images if provided
//       if (featureImages != null && featureImages.isNotEmpty) {
//         for (var featureImage in featureImages) {
//           final file = await http.MultipartFile.fromPath(
//             'featureImages',
//             featureImage.path,
//           );
//           request.files.add(file);
//         }
//       }

//       // Send request with timeout
//       final streamedResponse = await request.send().timeout(
//         const Duration(seconds: 60),
//       );

//       // Get response
//       final response = await http.Response.fromStream(streamedResponse);

//       print('Response status code for creaate product ${response.statusCode}');
//             print('Response bodyyyyyyyyy for creaate product ${response.body}');


//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return json.decode(response.body);
//       } else {
//         final errorData = json.decode(response.body);
//         throw Exception(errorData['message'] ?? 'Failed to create listing');
//       }
//     } catch (e) {
//       throw Exception('Error creating listing: $e');
//     }
//   }

//   /// Get products by subcategory
//   Future<List<Product>> getProductsBySubCategory(String subCategoryId) async {
//     try {
//       final allProducts = await getAllProducts();
//       return allProducts.products
//           .where((product) => product.subCategory.id == subCategoryId)
//           .toList();
//     } catch (e) {
//       throw Exception('Error fetching products by subcategory: $e');
//     }
//   }

//   /// Get products by type (Sale/Rent)
//   Future<List<Product>> getProductsByType(String type) async {
//     try {
//       final allProducts = await getAllProducts();
//       return allProducts.products
//           .where((product) => product.type.toLowerCase() == type.toLowerCase())
//           .toList();
//     } catch (e) {
//       throw Exception('Error fetching products by type: $e');
//     }
//   }

//   /// Get approved products only
//   Future<List<Product>> getApprovedProducts() async {
//     try {
//       final allProducts = await getAllProducts();
//       return allProducts.products
//           .where((product) => product.isApproved && product.isActive)
//           .toList();
//     } catch (e) {
//       throw Exception('Error fetching approved products: $e');
//     }
//   }

//   /// Get user's own products
//   Future<List<Product>> getUserProducts() async {
//     try {
//       final String? userId = SharedPrefHelper.getUserId();

//       if (userId == null || userId.isEmpty) {
//         throw Exception('User ID not found');
//       }

//       final allProducts = await getAllProducts();
//       return allProducts.products
//           .where((product) => product.user?.id == userId)
//           .toList();
//     } catch (e) {
//       throw Exception('Error fetching user products: $e');
//     }
//   }

//   /// Search products by name or description
//   Future<List<Product>> searchProducts(String query) async {
//     try {
//       final allProducts = await getAllProducts();
//       final searchQuery = query.toLowerCase();

//       return allProducts.products.where((product) {
//         return product.name.toLowerCase().contains(searchQuery) ||
//             product.description.toLowerCase().contains(searchQuery) ||
//             product.address.toLowerCase().contains(searchQuery);
//       }).toList();
//     } catch (e) {
//       throw Exception('Error searching products: $e');
//     }
//   }


// }























// lib/services/product_service.dart

// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:math' show sin, cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/model/product_model.dart';

class ProductService {
  Future<ProductListResponse> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getProductlist),
        headers: ApiConstants.headers,
      ).timeout(ApiConstants.connectionTimeout);

      print('Response status code for get all product ${response.statusCode}');
      print('Response bodyyyyyyyyyyy code for get all product ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ProductListResponse.fromJson(data);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Map<String, dynamic>> createListing({
    required String subCategoryId,
    required String name,
    required String type,
    required String address,
    required String description,
    required double latitude,
    required double longitude,
    required List<String> featureNames,
    required List<File> images,
    List<File>? featureImages,
    // New optional parameters
    Map<String, String>? contactDetails,
    String? businessLocation,
    Map<String, dynamic>? openingHours,
    Map<String, dynamic>? houseRent,
    Map<String, dynamic>? villaRent,
    List<String>? shopServices,
    List<String>? businessServices,
    Map<String, dynamic>? landDetails,
    List<String>? restaurantServices,
  }) async {
    try {
      final String? userId = SharedPrefHelper.getUserId();
      final String? token = SharedPrefHelper.getToken();

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found. Please login again.');
      }

      // Create multipart request
      final uri = Uri.parse(
        ApiConstants.createlistUrl.replaceAll(':subCategoryId', subCategoryId),
      );
      final request = http.MultipartRequest('POST', uri);

      print('melvinnnnnnnnnnnnnnnnnn $subCategoryId');

      // Add headers
      if (token != null && token.isNotEmpty) {
        request.headers.addAll({
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
      }

      // Add text fields
      request.fields['name'] = name;
      request.fields['type'] = type;
      request.fields['address'] = address;
      request.fields['description'] = description;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();
      request.fields['userId'] = userId;

      // Add feature names as JSON array
      request.fields['featureNames'] = json.encode(featureNames);

      // Add new optional fields
      if (contactDetails != null) {
        request.fields['contactDetails'] = json.encode(contactDetails);
      }

      if (businessLocation != null && businessLocation.isNotEmpty) {
        request.fields['businessLocation'] = businessLocation;
      }

      if (openingHours != null) {
        request.fields['openingHours'] = json.encode(openingHours);
      }

      if (houseRent != null) {
        request.fields['houseRent'] = json.encode(houseRent);
      }

      if (villaRent != null) {
        request.fields['villaRent'] = json.encode(villaRent);
      }

      if (shopServices != null && shopServices.isNotEmpty) {
        request.fields['shopServices'] = json.encode(shopServices);
      }

      if (businessServices != null && businessServices.isNotEmpty) {
        request.fields['businessServices'] = json.encode(businessServices);
      }

      if (landDetails != null) {
        request.fields['landDetails'] = json.encode(landDetails);
      }

      if (restaurantServices != null && restaurantServices.isNotEmpty) {
        request.fields['restaurantServices'] = json.encode(restaurantServices);
      }

      // Add property images
      for (var imageFile in images) {
        final file = await http.MultipartFile.fromPath(
          'images',
          imageFile.path,
        );
        request.files.add(file);
      }

      // Add feature images if provided
      if (featureImages != null && featureImages.isNotEmpty) {
        for (var featureImage in featureImages) {
          final file = await http.MultipartFile.fromPath(
            'featureImages',
            featureImage.path,
          );
          request.files.add(file);
        }
      }

      // Send request with timeout
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status code for creaate product ${response.statusCode}');
      print('Response bodyyyyyyyyy for creaate product ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to create listing');
      }
    } catch (e) {
      throw Exception('Error creating listing: $e');
    }
  }

  /// Get products by subcategory
  Future<List<Product>> getProductsBySubCategory(String subCategoryId) async {
    try {
      final allProducts = await getAllProducts();
      return allProducts.products
          .where((product) => product.subCategory.id == subCategoryId)
          .toList();
    } catch (e) {
      throw Exception('Error fetching products by subcategory: $e');
    }
  }

  /// Get products by type (Sale/Rent)
  Future<List<Product>> getProductsByType(String type) async {
    try {
      final allProducts = await getAllProducts();
      return allProducts.products
          .where((product) => product.type.toLowerCase() == type.toLowerCase())
          .toList();
    } catch (e) {
      throw Exception('Error fetching products by type: $e');
    }
  }

  /// Get approved products only
  Future<List<Product>> getApprovedProducts() async {
    try {
      final allProducts = await getAllProducts();
      return allProducts.products
          .where((product) => product.isApproved && product.isActive)
          .toList();
    } catch (e) {
      throw Exception('Error fetching approved products: $e');
    }
  }

  /// Get user's own products
  Future<List<Product>> getUserProducts() async {
    try {
      final String? userId = SharedPrefHelper.getUserId();

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found');
      }

      final allProducts = await getAllProducts();
      return allProducts.products
          .where((product) => product.user?.id == userId)
          .toList();
    } catch (e) {
      throw Exception('Error fetching user products: $e');
    }
  }

  /// Search products by name or description
  Future<List<Product>> searchProducts(String query) async {
    try {
      final allProducts = await getAllProducts();
      final searchQuery = query.toLowerCase();

      return allProducts.products.where((product) {
        return product.name.toLowerCase().contains(searchQuery) ||
            product.description.toLowerCase().contains(searchQuery) ||
            product.address.toLowerCase().contains(searchQuery);
      }).toList();
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}