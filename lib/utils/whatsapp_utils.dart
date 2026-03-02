import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class WhatsAppUtils {
  
  /// Opens WhatsApp chat with a specific phone number
  /// If phone number is not provided, it will just open WhatsApp
  static Future<void> openWhatsApp({
    required BuildContext context,
    String? phoneNumber,
    String? message,
    String? propertyTitle,
    String? propertyLocation,
  }) async {
    
    try {
      String url;
      String defaultMessage = message ?? _generateDefaultMessage(propertyTitle, propertyLocation);
      String encodedMessage = Uri.encodeComponent(defaultMessage);
      
      // Format phone number (remove any non-digit characters)
      String formattedPhone = phoneNumber?.replaceAll(RegExp(r'[^\d+]'), '') ?? '';
      
      // Check if WhatsApp is installed
      bool isWhatsAppInstalled = await _isWhatsAppInstalled();
      
      if (!isWhatsAppInstalled) {
        _showErrorSnackBar(context, 'WhatsApp is not installed on your device');
        return;
      }
      
      // Different URL schemes for different platforms
      if (Platform.isAndroid) {
        // Android WhatsApp URL scheme
        if (formattedPhone.isNotEmpty) {
          url = "https://wa.me/$formattedPhone?text=$encodedMessage";
        } else {
          url = "https://wa.me/?text=$encodedMessage";
        }
      } else if (Platform.isIOS) {
        // iOS WhatsApp URL scheme
        if (formattedPhone.isNotEmpty) {
          url = "https://wa.me/$formattedPhone?text=$encodedMessage";
        } else {
          url = "https://wa.me/?text=$encodedMessage";
        }
      } else {
        // Web or other platforms
        if (formattedPhone.isNotEmpty) {
          url = "https://web.whatsapp.com/send?phone=$formattedPhone&text=$encodedMessage";
        } else {
          url = "https://web.whatsapp.com";
        }
      }
      
      final uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to WhatsApp web
        final fallbackUrl = formattedPhone.isNotEmpty
            ? "https://web.whatsapp.com/send?phone=$formattedPhone&text=$encodedMessage"
            : "https://web.whatsapp.com";
        
        final fallbackUri = Uri.parse(fallbackUrl);
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar(context, 'Could not open WhatsApp');
        }
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening WhatsApp: $e');
    }
  }

  /// Opens WhatsApp Business if available, otherwise regular WhatsApp
  static Future<void> openWhatsAppBusiness({
    required BuildContext context,
    String? phoneNumber,
    String? message,
  }) async {
    try {
      String formattedPhone = phoneNumber?.replaceAll(RegExp(r'[^\d+]'), '') ?? '';
      String encodedMessage = Uri.encodeComponent(message ?? '');
      
      // Try WhatsApp Business first
      String businessUrl;
      if (Platform.isAndroid) {
        businessUrl = "https://api.whatsapp.com/send?phone=$formattedPhone&text=$encodedMessage";
      } else {
        businessUrl = "https://wa.me/$formattedPhone?text=$encodedMessage";
      }
      
      final uri = Uri.parse(businessUrl);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to regular WhatsApp
        await openWhatsApp(
          context: context,
          phoneNumber: phoneNumber,
          message: message,
        );
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error: $e');
    }
  }

  /// Share text via WhatsApp
  static Future<void> shareViaWhatsApp({
    required BuildContext context,
    required String text,
  }) async {
    await openWhatsApp(
      context: context,
      message: text,
    );
  }

  /// Share property details via WhatsApp
  static Future<void> shareProperty({
    required BuildContext context,
    required String propertyTitle,
    required String propertyLocation,
    String? propertyPrice,
    String? propertyImageUrl,
    String? agentPhone,
  }) {
    String message = _generatePropertyMessage(
      propertyTitle,
      propertyLocation,
      propertyPrice,
      propertyImageUrl,
    );
    
    return openWhatsApp(
      context: context,
      phoneNumber: agentPhone,
      message: message,
      propertyTitle: propertyTitle,
      propertyLocation: propertyLocation,
    );
  }

  /// Check if WhatsApp is installed
  static Future<bool> _isWhatsAppInstalled() async {
    try {
      String testUrl;
      if (Platform.isAndroid) {
        testUrl = "https://wa.me/";
      } else if (Platform.isIOS) {
        testUrl = "https://wa.me/";
      } else {
        testUrl = "https://web.whatsapp.com";
      }
      
      final uri = Uri.parse(testUrl);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  /// Show WhatsApp options bottom sheet
  static Future<void> showWhatsAppOptions({
    required BuildContext context,
    String? phoneNumber,
    String? propertyTitle,
    String? propertyLocation,
    String? propertyPrice,
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
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/whatsapp.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.chat, color: Colors.green, size: 24);
                    },
                  ),
                ),
                title: const Text('Chat on WhatsApp'),
                subtitle: Text(phoneNumber != null 
                    ? 'Chat with property agent' 
                    : 'Share property details'),
                onTap: () {
                  Navigator.pop(context);
                  if (propertyTitle != null && propertyLocation != null) {
                    shareProperty(
                      context: context,
                      propertyTitle: propertyTitle,
                      propertyLocation: propertyLocation,
                      propertyPrice: propertyPrice,
                      agentPhone: phoneNumber,
                    );
                  } else {
                    openWhatsApp(
                      context: context,
                      phoneNumber: phoneNumber,
                    );
                  }
                },
              ),
              if (phoneNumber != null)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.call, color: Colors.blue, size: 24),
                  ),
                  title: const Text('Call Agent'),
                  subtitle: Text(phoneNumber),
                  onTap: () {
                    Navigator.pop(context);
                    _makePhoneCall(context, phoneNumber);
                  },
                ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.grey, size: 24),
                ),
                title: const Text('Share via WhatsApp'),
                subtitle: const Text('Share with your contacts'),
                onTap: () {
                  Navigator.pop(context);
                  if (propertyTitle != null && propertyLocation != null) {
                    shareProperty(
                      context: context,
                      propertyTitle: propertyTitle,
                      propertyLocation: propertyLocation,
                      propertyPrice: propertyPrice,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Generate default message for property inquiry
  static String _generateDefaultMessage(String? title, String? location) {
    if (title != null && location != null) {
      return 'Hi, I am interested in the property: $title located at $location. Could you please provide more details?';
    } else if (title != null) {
      return 'Hi, I am interested in your property: $title. Could you please provide more details?';
    } else {
      return 'Hi, I am interested in this property. Could you please provide more details?';
    }
  }

  /// Generate complete property message
  static String _generatePropertyMessage(
    String title,
    String location,
    String? price,
    String? imageUrl,
  ) {
    String message = '*Property Details*\n\n';
    message += '🏠 *Title:* $title\n';
    message += '📍 *Location:* $location\n';
    if (price != null && price.isNotEmpty) {
      message += '💰 *Price:* $price\n';
    }
    message += '\nI am interested in this property. Please provide more information.';
    return message;
  }

  /// Make phone call (helper method)
  static Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final telUrl = Uri.parse('tel:$phoneNumber');
    try {
      if (await canLaunchUrl(telUrl)) {
        await launchUrl(telUrl);
      } else {
        _showErrorSnackBar(context, 'Could not make phone call');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error: $e');
    }
  }

  /// Show error snackbar
  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success snackbar
  static void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}