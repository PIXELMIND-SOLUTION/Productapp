// lib/services/location_service.dart

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';


class LocationService {
  /// Check if location services are enabled and permissions are granted
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current location coordinates
  Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkLocationPermission();
      if (!hasPermission) {
        throw Exception('Location permission not granted');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  /// Update live location to the server
  Future<Map<String, dynamic>> updateLiveLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Get userId and token from SharedPreferences
      final userId = SharedPrefHelper.getUserId();
      final token = SharedPrefHelper.getToken();

      if (userId == null || userId.isEmpty) {
        return {
          'success': false,
          'message': 'User ID not found. Please login again.',
        };
      }

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found. Please login again.',
        };
      }

      // Replace :userId in the URL with actual userId
      final url = ApiConstants.updatelocationurl.replaceAll(':userId', userId);

      // Prepare request body
      final body = json.encode({
        'latitude': latitude,
        'longitude': longitude,
      });

      // Make API call
      final response = await http
          .put(
            Uri.parse(url),
            headers: ApiConstants.getAuthHeaders(token),
            body: body,
          )
          .timeout(ApiConstants.connectionTimeout);

      final responseData = json.decode(response.body);


      print('Response status code for live location ${response.statusCode}');
      print('Response bodyyyyyyyyyyyy  for live location ${response.body}');


      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Location updated successfully',
          'location': responseData['location'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to update location',
        };
      }
    } catch (e) {
      print('Error updating live location: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  /// Get current location and update it to the server
  Future<Map<String, dynamic>> fetchAndUpdateLocation() async {
    try {
      Position? position = await getCurrentLocation();

      if (position == null) {
        return {
          'success': false,
          'message': 'Unable to get current location',
        };
      }

      return await updateLiveLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  /// Start listening to location updates (for real-time tracking)
  Stream<Position> getLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  /// Open app settings for location permission
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Open app settings for app-specific permissions
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }
}