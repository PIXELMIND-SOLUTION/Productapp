// // lib/providers/location_provider.dart

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:product_app/helper/location_helper.dart';
// import 'package:product_app/service/location_service.dart';

// class LocationProvider extends ChangeNotifier {
//   final LocationService _locationService = LocationService();

//   // State variables
//   bool _isLoading = false;
//   bool _hasPermission = false;
//   Position? _currentPosition;
//   String? _errorMessage;
//   Map<String, dynamic>? _updateResponse;
//   StreamSubscription<Position>? _locationSubscription;
//   bool _isTrackingEnabled = false;

  

//   // Getters
//   bool get isLoading => _isLoading;
//   bool get hasPermission => _hasPermission;
//   Position? get currentPosition => _currentPosition;
//   String? get errorMessage => _errorMessage;
//   Map<String, dynamic>? get updateResponse => _updateResponse;
//   bool get isTrackingEnabled => _isTrackingEnabled;

//   // Get latitude
//   double? get latitude => _currentPosition?.latitude;

//   // Get longitude
//   double? get longitude => _currentPosition?.longitude;

//   /// Check and request location permission
//   Future<bool> checkPermission() async {
//     _setLoading(true);
//     _errorMessage = null;

//     try {
//       _hasPermission = await _locationService.checkLocationPermission();
      
//       if (!_hasPermission) {
//         _errorMessage = 'Location permission denied';
//       }
      
//       return _hasPermission;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _hasPermission = false;
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Get current location
//   Future<void> getCurrentLocation() async {
//     _setLoading(true);
//     _errorMessage = null;

//     try {
//       _currentPosition = await _locationService.getCurrentLocation();
      
//       if (_currentPosition == null) {
//         _errorMessage = 'Unable to get location';
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _setLoading(false);
//     }
//   }


//   void setManualLocation({
//   required double latitude,
//   required double longitude,
// })async {
//   _currentPosition = Position(
//     latitude: latitude,
//     longitude: longitude,
//     timestamp: DateTime.now(),
//     accuracy: 0,
//     altitude: 0,
//     heading: 0,
//     speed: 0,
//     speedAccuracy: 0,
//     altitudeAccuracy: 0,
//     headingAccuracy: 0,
//   );

//    await LocationPrefHelper.saveLocation(
//     latitude: latitude,
//     longitude: longitude,
//   );
//   notifyListeners();
// }

//   /// Update location to server
//   Future<bool> updateLocationToServer() async {
//     _setLoading(true);
//     _errorMessage = null;

//     try {
//       if (_currentPosition == null) {
//         await getCurrentLocation();
//       }

//       if (_currentPosition == null) {
//         _errorMessage = 'No location data available';
//         return false;
//       }

//       _updateResponse = await _locationService.updateLiveLocation(
//         latitude: _currentPosition!.latitude,
//         longitude: _currentPosition!.longitude,
//       );

//       if (_updateResponse!['success'] == true) {
//         return true;
//       } else {
//         _errorMessage = _updateResponse!['message'];
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Fetch current location and update to server (one-shot)
//   Future<bool> fetchAndUpdateLocation() async {
//     _setLoading(true);
//     _errorMessage = null;

//     try {
//       _updateResponse = await _locationService.fetchAndUpdateLocation();

//       if (_updateResponse!['success'] == true) {
//         // Update current position from response if available
//         await getCurrentLocation();
//         return true;
//       } else {
//         _errorMessage = _updateResponse!['message'];
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Start real-time location tracking
//   Future<void> startLocationTracking({
//     Duration updateInterval = const Duration(seconds: 30),
//   }) async {
//     if (_isTrackingEnabled) {
//       return; // Already tracking
//     }

//     bool hasPermission = await checkPermission();
//     if (!hasPermission) {
//       _errorMessage = 'Location permission required for tracking';
//       return;
//     }

//     _isTrackingEnabled = true;
//     notifyListeners();

//     _locationSubscription = _locationService.getLocationStream().listen(
//       (Position position) {
//         _currentPosition = position;
//         notifyListeners();

//         // Update to server
//         _locationService.updateLiveLocation(
//           latitude: position.latitude,
//           longitude: position.longitude,
//         );
//       },
//       onError: (error) {
//         _errorMessage = error.toString();
//         notifyListeners();
//       },
//     );
//   }

//   /// Stop real-time location tracking
//   void stopLocationTracking() {
//     _locationSubscription?.cancel();
//     _locationSubscription = null;
//     _isTrackingEnabled = false;
//     notifyListeners();
//   }

//   /// Open location settings
//   Future<void> openLocationSettings() async {
//     await _locationService.openLocationSettings();
//   }

//   /// Open app settings
//   Future<void> openAppSettings() async {
//     await _locationService.openAppSettings();
//   }

//   /// Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   /// Reset all state
//   void reset() {
//     stopLocationTracking();
//     _currentPosition = null;
//     _errorMessage = null;
//     _updateResponse = null;
//     _hasPermission = false;
//     notifyListeners();
//   }

//   // Private helper to set loading state
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     stopLocationTracking();
//     super.dispose();
//   }
// }

















// lib/providers/location_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:product_app/helper/location_helper.dart';
import 'package:product_app/service/location_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  // State variables
  bool _isLoading = false;
  bool _hasPermission = false;
  Position? _currentPosition;
  String? _errorMessage;
  Map<String, dynamic>? _updateResponse;
  StreamSubscription<Position>? _locationSubscription;
  bool _isTrackingEnabled = false;

  // Getters
  bool get isLoading => _isLoading;
  bool get hasPermission => _hasPermission;
  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get updateResponse => _updateResponse;
  bool get isTrackingEnabled => _isTrackingEnabled;

  // Get latitude
  double? get latitude => _currentPosition?.latitude;

  // Get longitude
  double? get longitude => _currentPosition?.longitude;

  /// Load saved location from shared preferences
  Future<void> loadSavedLocation() async {
    try {
      final savedLocation = await LocationPrefHelper.getLocation();
      
      if (savedLocation != null && 
          savedLocation['latitude'] != null && 
          savedLocation['longitude'] != null) {
        _currentPosition = Position(
          latitude: savedLocation['latitude']!,
          longitude: savedLocation['longitude']!,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error loading saved location: $e');
    }
  }

  // Alternative implementation if getLocation() doesn't exist
  // Use this instead if you have separate getLatitude() and getLongitude() methods
  /*
  Future<void> loadSavedLocation() async {
    try {
      final latitude = await LocationPrefHelper.getLatitude();
      final longitude = await LocationPrefHelper.getLongitude();
      
      if (latitude != null && longitude != null) {
        _currentPosition = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error loading saved location: $e');
    }
  }
  */

  /// Check and request location permission
  Future<bool> checkPermission() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _hasPermission = await _locationService.checkLocationPermission();
      
      if (!_hasPermission) {
        _errorMessage = 'Location permission denied';
      }
      
      return _hasPermission;
    } catch (e) {
      _errorMessage = e.toString();
      _hasPermission = false;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Get current location
  Future<void> getCurrentLocation() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _currentPosition = await _locationService.getCurrentLocation();
      
      if (_currentPosition == null) {
        _errorMessage = 'Unable to get location';
      } else {
        await LocationPrefHelper.saveLocation(
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void setManualLocation({
    required double latitude,
    required double longitude,
  }) async {
    _currentPosition = Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    await LocationPrefHelper.saveLocation(
      latitude: latitude,
      longitude: longitude,
    );
    notifyListeners();
  }

  /// Update location to server
  Future<bool> updateLocationToServer() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      if (_currentPosition == null) {
        await getCurrentLocation();
      }

      if (_currentPosition == null) {
        _errorMessage = 'No location data available';
        return false;
      }

      _updateResponse = await _locationService.updateLiveLocation(
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
      );

      if (_updateResponse!['success'] == true) {
        return true;
      } else {
        _errorMessage = _updateResponse!['message'];
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Fetch current location and update to server (one-shot)
  Future<bool> fetchAndUpdateLocation() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _updateResponse = await _locationService.fetchAndUpdateLocation();

      if (_updateResponse!['success'] == true) {
        // Update current position from response if available
        await getCurrentLocation();
        return true;
      } else {
        _errorMessage = _updateResponse!['message'];
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Start real-time location tracking
  Future<void> startLocationTracking({
    Duration updateInterval = const Duration(seconds: 30),
  }) async {
    if (_isTrackingEnabled) {
      return; // Already tracking
    }

    bool hasPermission = await checkPermission();
    if (!hasPermission) {
      _errorMessage = 'Location permission required for tracking';
      return;
    }

    _isTrackingEnabled = true;
    notifyListeners();

    _locationSubscription = _locationService.getLocationStream().listen(
      (Position position) {
        _currentPosition = position;
        notifyListeners();

        // Save location to shared preferences
        LocationPrefHelper.saveLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        // Update to server
        _locationService.updateLiveLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  /// Stop real-time location tracking
  void stopLocationTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    _isTrackingEnabled = false;
    notifyListeners();
  }

  /// Open location settings
  Future<void> openLocationSettings() async {
    await _locationService.openLocationSettings();
  }

  /// Open app settings
  Future<void> openAppSettings() async {
    await _locationService.openAppSettings();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset all state
  void reset() {
    stopLocationTracking();
    _currentPosition = null;
    _errorMessage = null;
    _updateResponse = null;
    _hasPermission = false;
    notifyListeners();
  }

  // Private helper to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    stopLocationTracking();
    super.dispose();
  }
}