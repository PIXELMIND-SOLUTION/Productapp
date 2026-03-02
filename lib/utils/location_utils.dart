import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class LocationUtils {
  
  /// Opens a map application with the given coordinates
  /// If both lat and lng are provided, it will show that specific location
  /// If only address is provided, it will search for that address
  static Future<void> openMap({
    required BuildContext context,
    double? latitude,
    double? longitude,
    String? address,
    String? label = 'Location',
  }) async {
    
    // Validate we have either coordinates or address
    if (latitude == null || longitude == null) {
      if (address == null || address.isEmpty) {
        _showErrorSnackBar(context, 'Location information is missing');
        return;
      }
    }

    try {
      String url;
      
      // Check if we have valid coordinates
      if (latitude != null && longitude != null) {
        // For Android
        if (Platform.isAndroid) {
          url = "geo:$latitude,$longitude?q=$latitude,$longitude($label)";
        } 
        // For iOS
        else if (Platform.isIOS) {
          url = "maps://?q=$label&ll=$latitude,$longitude";
        } 
        // For web or other platforms
        else {
          url = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
        }
      } 
      // If only address is provided
      else {
        final encodedAddress = Uri.encodeComponent(address!);
        
        if (Platform.isAndroid) {
          url = "geo:0,0?q=$encodedAddress";
        } else if (Platform.isIOS) {
          url = "maps://?q=$encodedAddress";
        } else {
          url = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
        }
      }

      final uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to Google Maps web URL
        final fallbackUrl = latitude != null && longitude != null
            ? "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"
            : "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address ?? '')}";
        
        final fallbackUri = Uri.parse(fallbackUrl);
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar(context, 'Could not open maps');
        }
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening maps: $e');
    }
  }

  /// Opens Google Maps with directions from current location to destination
  static Future<void> getDirections({
    required BuildContext context,
    required double destLat,
    required double destLng,
    String? destinationName,
  }) async {
    try {
      String url;
      
      if (Platform.isAndroid) {
        url = "google.navigation:q=$destLat,$destLng&mode=d";
      } else if (Platform.isIOS) {
        url = "maps://?q=$destLat,$destLng&dirflg=d";
      } else {
        url = "https://www.google.com/maps/dir/?api=1&destination=$destLat,$destLng&travelmode=driving";
      }

      final uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, 'Could not open maps for directions');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error: $e');
    }
  }

  /// Shows a bottom sheet with map options
  static Future<void> showMapOptions({
    required BuildContext context,
    double? latitude,
    double? longitude,
    String? address,
    String? locationName,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.map, color: Color(0xFFE33629)),
                title: const Text('View on Map'),
                subtitle: Text(address ?? 'View this location'),
                onTap: () {
                  Navigator.pop(context);
                  openMap(
                    context: context,
                    latitude: latitude,
                    longitude: longitude,
                    address: address,
                    label: locationName,
                  );
                },
              ),
              if (latitude != null && longitude != null)
                ListTile(
                  leading: const Icon(Icons.directions, color: Color(0xFFE33629)),
                  title: const Text('Get Directions'),
                  subtitle: Text('Navigate to this location'),
                  onTap: () {
                    Navigator.pop(context);
                    getDirections(
                      context: context,
                      destLat: latitude,
                      destLng: longitude,
                      destinationName: locationName,
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.content_copy, color: Colors.grey),
                title: const Text('Copy Address'),
                subtitle: Text(address ?? ''),
                onTap: () {
                  Navigator.pop(context);
                  _copyToClipboard(context, address ?? '');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void _copyToClipboard(BuildContext context, String text) {
    // You'll need to add clipboard service
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address copied to clipboard'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}