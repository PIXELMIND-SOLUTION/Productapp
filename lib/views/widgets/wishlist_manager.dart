import 'package:flutter/material.dart';

class WishlistManager extends ChangeNotifier {
  static final WishlistManager _instance = WishlistManager._internal();
  factory WishlistManager() => _instance;
  WishlistManager._internal();

  final List<Map<String, dynamic>> _wishlist = [];

  List<Map<String, dynamic>> get wishlist => List.unmodifiable(_wishlist);

  bool isInWishlist(String title) {
    return _wishlist.any((item) => item['title'] == title);
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final index = _wishlist.indexWhere((item) => item['title'] == product['title']);
    
    if (index != -1) {
      _wishlist.removeAt(index);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  void removeFromWishlist(String title) {
    _wishlist.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }

  int get count => _wishlist.length;
}