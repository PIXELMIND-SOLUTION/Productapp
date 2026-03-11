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
    String? propertyPrice,
  }) async {
    
    try {
      String url;
      String defaultMessage = message ?? _generateDefaultMessage(
        propertyTitle, 
        propertyLocation,
        propertyPrice,
      );
      String encodedMessage = Uri.encodeComponent(defaultMessage);
      
      // Format phone number (remove any non-digit characters and ensure it has country code)
      String formattedPhone = _formatPhoneNumber(phoneNumber);
      
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
      print('Opening WhatsApp URL: $url'); // Debug print
      
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
      print('Error opening WhatsApp: $e'); // Debug print
      _showErrorSnackBar(context, 'Error opening WhatsApp: $e');
    }
  }

  /// Format phone number for WhatsApp
  static String _formatPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return '';
    
    // Remove all non-digit characters except +
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If number doesn't have +, add it (assuming Indian numbers if no country code)
    if (!cleaned.startsWith('+')) {
      // If number starts with 91 (India) or has 10 digits, add +
      if (cleaned.startsWith('91') && cleaned.length == 12) {
        cleaned = '+$cleaned';
      } else if (cleaned.length == 10) {
        // Add India country code for 10-digit numbers
        cleaned = '+91$cleaned';
      } else {
        cleaned = '+$cleaned';
      }
    }
    
    // Remove any spaces or special characters
    return cleaned.replaceAll(RegExp(r'[\s-]'), '');
  }

  /// Opens WhatsApp Business if available, otherwise regular WhatsApp
  static Future<void> openWhatsAppBusiness({
    required BuildContext context,
    String? phoneNumber,
    String? message,
    String? propertyTitle,
    String? propertyLocation,
    String? propertyPrice,
  }) async {
    try {
      String formattedPhone = _formatPhoneNumber(phoneNumber);
      String defaultMessage = message ?? _generateDefaultMessage(
        propertyTitle, 
        propertyLocation,
        propertyPrice,
      );
      String encodedMessage = Uri.encodeComponent(defaultMessage);
      
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
          propertyTitle: propertyTitle,
          propertyLocation: propertyLocation,
          propertyPrice: propertyPrice,
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

  /// Share property/business details via WhatsApp
  static Future<void> shareProperty({
    required BuildContext context,
    required String propertyTitle,
    required String propertyLocation,
    String? propertyPrice,
    String? propertyImageUrl,
    String? agentPhone,
    String? customMessage,
  }) {
    String message = customMessage ?? _generatePropertyMessage(
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
      propertyPrice: propertyPrice,
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
    String? agentName,
  }) {
    String displayPhone = phoneNumber ?? '';
    // Format phone number for display
    if (displayPhone.length == 12 && displayPhone.startsWith('91')) {
      displayPhone = '+${displayPhone.substring(0, 2)} ${displayPhone.substring(2)}';
    } else if (displayPhone.length == 10) {
      displayPhone = '+91 $displayPhone';
    }
    
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
              if (agentName != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    agentName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                subtitle: Text(phoneNumber != null && phoneNumber.isNotEmpty
                    ? 'Chat with ${agentName ?? 'agent'}' 
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
              if (phoneNumber != null && phoneNumber.isNotEmpty)
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
                  subtitle: Text(displayPhone),
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

  /// Generate default message for property/business inquiry
  static String _generateDefaultMessage(String? title, String? location, String? price) {
    String message = 'Hi,';
    
    if (title != null && title.isNotEmpty) {
      message += ' I am interested in "$title"';
    } else {
      message += ' I am interested in your listing';
    }
    
    if (location != null && location.isNotEmpty && location != "Unknown") {
      message += ' located at $location';
    }
    
    if (price != null && price.isNotEmpty && !price.contains('N/A')) {
      message += ' with price $price';
    }
    
    message += '. Could you please provide more details?';
    
    return message;
  }

  /// Generate complete property/business message
  static String _generatePropertyMessage(
    String title,
    String location,
    String? price,
    String? imageUrl,
  ) {
    String message = '*Listing Details*\n\n';
    message += '🏠 *Title:* $title\n';
    message += '📍 *Location:* $location\n';
    if (price != null && price.isNotEmpty && !price.contains('N/A')) {
      message += '💰 *Price:* $price\n';
    }
    message += '\nI am interested in this listing. Please provide more information.';
    return message;
  }

  /// Make phone call (helper method)
  static Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    // Clean phone number for dialing
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final telUrl = Uri.parse('tel:$cleanNumber');
    
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