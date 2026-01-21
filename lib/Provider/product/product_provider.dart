// // lib/providers/product_provider.dart

// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:product_app/model/product_model.dart';
// import 'package:product_app/service/product_service.dart';

// enum ProductStatus { idle, loading, success, error }

// class ProductProvider with ChangeNotifier {
//   final ProductService _productService = ProductService();

//   // State variables
//   ProductStatus _status = ProductStatus.idle;
//   List<Product> _allProducts = [];
//   List<Product> _filteredProducts = [];
//   Product? _selectedProduct;
//   String? _errorMessage;

//   // Filters
//   String? _selectedType;
//   String? _selectedSubCategory;
//   String _searchQuery = '';

//   // Getters
//   ProductStatus get status => _status;
//   List<Product> get products => _filteredProducts;
//   List<Product> get allProducts => _allProducts;
//   Product? get selectedProduct => _selectedProduct;
//   String? get errorMessage => _errorMessage;
//   String? get selectedType => _selectedType;
//   String? get selectedSubCategory => _selectedSubCategory;
//   String get searchQuery => _searchQuery;
//   bool get isLoading => _status == ProductStatus.loading;
//   bool get hasError => _status == ProductStatus.error;

//   /// Fetch all products
//   Future<void> fetchAllProducts() async {
//     _setStatus(ProductStatus.loading);

//     try {
//       final response = await _productService.getAllProducts();
//       _allProducts = response.products;
//       _applyFilters();
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Create a new listing
//   Future<bool> createListing({
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
//     _setStatus(ProductStatus.loading);

//     try {
//       print('subcategoryiddd$subCategoryId');
//       print('nameeeeeeeeeeeee$name');
//       print('ttypeeeeeeeeeeee$type');
//       print('descriptionn$description');
//       print('addresss$address');
//       print('latitude$latitude');
//       print('longitude$longitude');
//       print('featurename$featureNames');
//       print('imageaaaaaaaaaaaaa$images');
//       print('featureimaages$featureImages');
//       await _productService.createListing(
//         subCategoryId: subCategoryId,
//         name: name,
//         type: type,
//         address: address,
//         description: description,
//         latitude: latitude,
//         longitude: longitude,
//         featureNames: featureNames,
//         images: images,
//         featureImages: featureImages,
//       );

//       // Refresh products list after creating
//       await fetchAllProducts();
//       _setStatus(ProductStatus.success);
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//       return false;
//     }
//   }

//   /// Get products by type (Sale/Rent)
//   Future<void> fetchProductsByType(String type) async {
//     _setStatus(ProductStatus.loading);

//     try {
//       final products = await _productService.getProductsByType(type);
//       _allProducts = products;
//       _selectedType = type;
//       _applyFilters();
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Get products by subcategory
//   Future<void> fetchProductsBySubCategory(String subCategoryId) async {
//     _setStatus(ProductStatus.loading);

//     try {
//       final products =
//           await _productService.getProductsBySubCategory(subCategoryId);
//       _allProducts = products;
//       _selectedSubCategory = subCategoryId;
//       _applyFilters();
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Get approved products only
//   Future<void> fetchApprovedProducts() async {
//     _setStatus(ProductStatus.loading);

//     try {
//       final products = await _productService.getApprovedProducts();
//       _allProducts = products;
//       _applyFilters();
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Get user's own products
//   Future<void> fetchUserProducts() async {
//     _setStatus(ProductStatus.loading);

//     try {
//       final products = await _productService.getUserProducts();
//       _allProducts = products;
//       _applyFilters();
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Search products
//   Future<void> searchProducts(String query) async {
//     _searchQuery = query;

//     if (query.isEmpty) {
//       _applyFilters();
//       return;
//     }

//     _setStatus(ProductStatus.loading);

//     try {
//       final products = await _productService.searchProducts(query);
//       _filteredProducts = products;
//       _setStatus(ProductStatus.success);
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setStatus(ProductStatus.error);
//     }
//   }

//   /// Set selected product
//   void selectProduct(Product product) {
//     _selectedProduct = product;
//     notifyListeners();
//   }

//   /// Clear selected product
//   void clearSelectedProduct() {
//     _selectedProduct = null;
//     notifyListeners();
//   }

//   /// Filter by type
//   void filterByType(String? type) {
//     _selectedType = type;
//     _applyFilters();
//   }

//   /// Filter by subcategory
//   void filterBySubCategory(String? subCategoryId) {
//     _selectedSubCategory = subCategoryId;
//     _applyFilters();
//   }

//   /// Clear all filters
//   void clearFilters() {
//     _selectedType = null;
//     _selectedSubCategory = null;
//     _searchQuery = '';
//     _applyFilters();
//   }

//   /// Apply filters to products list
//   void _applyFilters() {
//     _filteredProducts = List.from(_allProducts);

//     // Filter by type
//     if (_selectedType != null) {
//       _filteredProducts = _filteredProducts
//           .where((p) => p.type.toLowerCase() == _selectedType!.toLowerCase())
//           .toList();
//     }

//     // Filter by subcategory
//     if (_selectedSubCategory != null) {
//       _filteredProducts = _filteredProducts
//           .where((p) => p.subCategory.id == _selectedSubCategory)
//           .toList();
//     }

//     // Filter by search query
//     if (_searchQuery.isNotEmpty) {
//       final query = _searchQuery.toLowerCase();
//       _filteredProducts = _filteredProducts.where((p) {
//         return p.name.toLowerCase().contains(query) ||
//             p.description.toLowerCase().contains(query) ||
//             p.address.toLowerCase().contains(query);
//       }).toList();
//     }

//     notifyListeners();
//   }

//   /// Set status and notify listeners
//   void _setStatus(ProductStatus status) {
//     _status = status;
//     notifyListeners();
//   }

//   /// Refresh products
//   Future<void> refresh() async {
//     await fetchAllProducts();
//   }

//   /// Clear error message
//   void clearError() {
//     _errorMessage = null;
//     _setStatus(ProductStatus.idle);
//   }

//   /// Get product count by type
//   int getProductCountByType(String type) {
//     return _allProducts
//         .where((p) => p.type.toLowerCase() == type.toLowerCase())
//         .length;
//   }

//   /// Get sale products count
//   int get saleProductsCount => getProductCountByType('sale');

//   /// Get rent products count
//   int get rentProductsCount => getProductCountByType('rent');

//   /// Check if there are any products
//   bool get hasProducts => _filteredProducts.isNotEmpty;

//   @override
//   void dispose() {
//     _allProducts.clear();
//     _filteredProducts.clear();
//     _selectedProduct = null;
//     super.dispose();
//   }
// }















// lib/providers/product_provider.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:product_app/model/product_model.dart';
import 'package:product_app/service/product_service.dart';

enum ProductStatus { idle, loading, success, error }

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  // State variables
  ProductStatus _status = ProductStatus.idle;
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  Product? _selectedProduct;
  String? _errorMessage;

  // Filters
  String? _selectedType;
  String? _selectedSubCategory;
  String _searchQuery = '';

  // Getters
  ProductStatus get status => _status;
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;
  Product? get selectedProduct => _selectedProduct;
  String? get errorMessage => _errorMessage;
  String? get selectedType => _selectedType;
  String? get selectedSubCategory => _selectedSubCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _status == ProductStatus.loading;
  bool get hasError => _status == ProductStatus.error;

  /// Fetch all products
  Future<void> fetchAllProducts() async {
    _setStatus(ProductStatus.loading);

    try {
      final response = await _productService.getAllProducts();
      _allProducts = response.products;
      _applyFilters();
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Create a new listing with all optional fields
  Future<bool> createListing({
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
    _setStatus(ProductStatus.loading);

    try {
      print('subcategoryiddd$subCategoryId');
      print('nameeeeeeeeeeeee$name');
      print('ttypeeeeeeeeeeee$type');
      print('descriptionn$description');
      print('addresss$address');
      print('latitude$latitude');
      print('longitude$longitude');
      print('featurename$featureNames');
      print('imageaaaaaaaaaaaaa$images');
      print('featureimaages$featureImages');
      print('contactDetails$contactDetails');
      print('businessLocation$businessLocation');
      print('openingHours$openingHours');
      print('houseRent$houseRent');
      print('villaRent$villaRent');
      print('shopServices$shopServices');
      print('businessServices$businessServices');
      print('landDetails$landDetails');
      print('restaurantServices$restaurantServices');

      await _productService.createListing(
        subCategoryId: subCategoryId,
        name: name,
        type: type,
        address: address,
        description: description,
        latitude: latitude,
        longitude: longitude,
        featureNames: featureNames,
        images: images,
        featureImages: featureImages,
        contactDetails: contactDetails,
        businessLocation: businessLocation,
        openingHours: openingHours,
        houseRent: houseRent,
        villaRent: villaRent,
        shopServices: shopServices,
        businessServices: businessServices,
        landDetails: landDetails,
        restaurantServices: restaurantServices,
      );

      // Refresh products list after creating
      await fetchAllProducts();
      _setStatus(ProductStatus.success);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
      return false;
    }
  }

  /// Get products by type (Sale/Rent)
  Future<void> fetchProductsByType(String type) async {
    _setStatus(ProductStatus.loading);

    try {
      final products = await _productService.getProductsByType(type);
      _allProducts = products;
      _selectedType = type;
      _applyFilters();
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Get products by subcategory
  Future<void> fetchProductsBySubCategory(String subCategoryId) async {
    _setStatus(ProductStatus.loading);

    try {
      final products =
          await _productService.getProductsBySubCategory(subCategoryId);
      _allProducts = products;
      _selectedSubCategory = subCategoryId;
      _applyFilters();
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Get approved products only
  Future<void> fetchApprovedProducts() async {
    _setStatus(ProductStatus.loading);

    try {
      final products = await _productService.getApprovedProducts();
      _allProducts = products;
      _applyFilters();
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Get user's own products
  Future<void> fetchUserProducts() async {
    _setStatus(ProductStatus.loading);

    try {
      final products = await _productService.getUserProducts();
      _allProducts = products;
      _applyFilters();
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _applyFilters();
      return;
    }

    _setStatus(ProductStatus.loading);

    try {
      final products = await _productService.searchProducts(query);
      _filteredProducts = products;
      _setStatus(ProductStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ProductStatus.error);
    }
  }

  /// Set selected product
  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  /// Clear selected product
  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }

  /// Filter by type
  void filterByType(String? type) {
    _selectedType = type;
    _applyFilters();
  }

  /// Filter by subcategory
  void filterBySubCategory(String? subCategoryId) {
    _selectedSubCategory = subCategoryId;
    _applyFilters();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedType = null;
    _selectedSubCategory = null;
    _searchQuery = '';
    _applyFilters();
  }

  /// Apply filters to products list
  void _applyFilters() {
    _filteredProducts = List.from(_allProducts);

    // Filter by type
    if (_selectedType != null) {
      _filteredProducts = _filteredProducts
          .where((p) => p.type.toLowerCase() == _selectedType!.toLowerCase())
          .toList();
    }

    // Filter by subcategory
    if (_selectedSubCategory != null) {
      _filteredProducts = _filteredProducts
          .where((p) => p.subCategory.id == _selectedSubCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      _filteredProducts = _filteredProducts.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.address.toLowerCase().contains(query);
      }).toList();
    }

    notifyListeners();
  }

  /// Set status and notify listeners
  void _setStatus(ProductStatus status) {
    _status = status;
    notifyListeners();
  }

  /// Refresh products
  Future<void> refresh() async {
    await fetchAllProducts();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    _setStatus(ProductStatus.idle);
  }

  /// Get product count by type
  int getProductCountByType(String type) {
    return _allProducts
        .where((p) => p.type.toLowerCase() == type.toLowerCase())
        .length;
  }

  /// Get sale products count
  int get saleProductsCount => getProductCountByType('sale');

  /// Get rent products count
  int get rentProductsCount => getProductCountByType('rent');

  /// Check if there are any products
  bool get hasProducts => _filteredProducts.isNotEmpty;

  @override
  void dispose() {
    _allProducts.clear();
    _filteredProducts.clear();
    _selectedProduct = null;
    super.dispose();
  }
}