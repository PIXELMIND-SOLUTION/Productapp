// lib/helper/location_helper.dart

import 'package:shared_preferences/shared_preferences.dart';

class LocationPrefHelper {
  // Keys for storing location data
  static const String _latitudeKey = 'user_latitude';
  static const String _longitudeKey = 'user_longitude';

  /// Save location to shared preferences
  static Future<bool> saveLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_latitudeKey, latitude);
      await prefs.setDouble(_longitudeKey, longitude);
      return true;
    } catch (e) {
      print('Error saving location: $e');
      return false;
    }
  }

  /// Get saved location from shared preferences
  static Future<Map<String, double>?> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final latitude = prefs.getDouble(_latitudeKey);
      final longitude = prefs.getDouble(_longitudeKey);

      if (latitude != null && longitude != null) {
        return {
          'latitude': latitude,
          'longitude': longitude,
        };
      }
      return null;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  /// Check if location is saved
  static Future<bool> hasLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_latitudeKey) && 
             prefs.containsKey(_longitudeKey);
    } catch (e) {
      print('Error checking location: $e');
      return false;
    }
  }

  /// Clear saved location
  static Future<bool> clearLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_latitudeKey);
      await prefs.remove(_longitudeKey);
      return true;
    } catch (e) {
      print('Error clearing location: $e');
      return false;
    }
  }

  /// Get latitude only
  static Future<double?> getLatitude() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_latitudeKey);
    } catch (e) {
      print('Error getting latitude: $e');
      return null;
    }
  }

  /// Get longitude only
  static Future<double?> getLongitude() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_longitudeKey);
    } catch (e) {
      print('Error getting longitude: $e');
      return null;
    }
  }
}