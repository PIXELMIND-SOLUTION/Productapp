// lib/providers/wishlist_provider.dart

import 'package:flutter/material.dart';
import 'package:product_app/service/wishlist_service.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();

  List<dynamic> _wishlistItems = [];
  
  Set<String> _wishlistProductIds = {};

  // Loading states
  bool _isLoading = false;
  bool _isToggling = false;

  // Error message
  String? _errorMessage;

  // Getters
  List<dynamic> get wishlistItems => _wishlistItems;
  Set<String> get wishlistProductIds => _wishlistProductIds;
  bool get isLoading => _isLoading;
  bool get isToggling => _isToggling;
  String? get errorMessage => _errorMessage;
  int get wishlistCount => _wishlistItems.length;

  /// Check if product is in wishlist
  bool isInWishlist(String productId) {
    return _wishlistProductIds.contains(productId);
  }

  /// Toggle wishlist (Add/Remove)
  Future<bool> toggleWishlist(String productId) async {
    _isToggling = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _wishlistService.toggleWishlist(productId);
      
      if (result['success'] == true) {
        if (result['isAdded'] == true) {
          _wishlistProductIds.add(productId);
        } else {
          _wishlistProductIds.remove(productId);
          _wishlistItems.removeWhere((item) => item['_id'] == productId);
        }
        
        _isToggling = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Failed to update wishlist';
        _isToggling = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isToggling = false;
      notifyListeners();
      return false;
    }
  }

  /// Fetch wishlist from server
  Future<void> fetchWishlist() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final wishlist = await _wishlistService.getWishlist();
      
      _wishlistItems = wishlist;
      
      _wishlistProductIds = wishlist
          .map((item) => item['_id'] as String)
          .toSet();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh wishlist
  Future<void> refreshWishlist() async {
    await fetchWishlist();
  }

  /// Clear wishlist data (on logout)
  void clearWishlist() {
    _wishlistItems = [];
    _wishlistProductIds = {};
    _errorMessage = null;
    _isLoading = false;
    _isToggling = false;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}