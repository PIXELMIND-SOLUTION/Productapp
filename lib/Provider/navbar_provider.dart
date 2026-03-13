// Provider/navbar_provider.dart
import 'package:flutter/material.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int _currentIndex;

  BottomNavbarProvider({int initialIndex = 0}) : _currentIndex = initialIndex;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}