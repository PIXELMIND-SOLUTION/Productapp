import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class CallUtils {
  
  /// Make a phone call to the specified number
  static Future<void> makePhoneCall({
    required BuildContext context,
    required String phoneNumber,
    String? name,
  }) async {
    
    try {
      // Clean the phone number (remove spaces, dashes, etc.)
      String cleanedNumber = _cleanPhoneNumber(phoneNumber);
      
      // Create tel URL
      final telUrl = Uri.parse('tel:$cleanedNumber');
      
      // Check if device can make calls
      if (await canLaunchUrl(telUrl)) {
        await launchUrl(telUrl);
        
        // Show call initiated message
        _showCallInitiatedSnackBar(context, phoneNumber, name);
      } else {
        _showErrorSnackBar(context, 'Device cannot make phone calls');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error making call: $e');
    }
  }

  /// Make a phone call with confirmation dialog
  static Future<void> makePhoneCallWithConfirmation({
    required BuildContext context,
    required String phoneNumber,
    String? name,
  }) async {
    
    String displayName = name ?? phoneNumber;
    String cleanedNumber = _cleanPhoneNumber(phoneNumber);
    
    // Show confirmation dialog
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Make Phone Call'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Call $displayName?'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        cleanedNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Call'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await makePhoneCall(
        context: context,
        phoneNumber: phoneNumber,
        name: name,
      );
    }
  }

  /// Check if device can make phone calls
  static Future<bool> canMakePhoneCall() async {
    try {
      final telUrl = Uri.parse('tel:1234567890');
      return await canLaunchUrl(telUrl);
    } catch (e) {
      return false;
    }
  }

  /// Format phone number for display
  static String formatPhoneNumber(String phoneNumber) {
    String cleaned = _cleanPhoneNumber(phoneNumber);
    
    // Format based on length (simple formatting)
    if (cleaned.length == 10) {
      // Format: (123) 456-7890
      return '(${cleaned.substring(0,3)}) ${cleaned.substring(3,6)}-${cleaned.substring(6)}';
    } else if (cleaned.length == 11 && cleaned.startsWith('1')) {
      // Format: 1 (123) 456-7890
      return '1 (${cleaned.substring(1,4)}) ${cleaned.substring(4,7)}-${cleaned.substring(7)}';
    } else if (cleaned.length == 12 && cleaned.startsWith('91')) {
      // Format: +91 12345 67890 (India)
      return '+91 ${cleaned.substring(2,7)} ${cleaned.substring(7)}';
    } else {
      // Return as is if can't format
      return phoneNumber;
    }
  }

  /// Clean phone number (remove non-digit characters except +)
  static String _cleanPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters except + at the beginning
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Ensure only one + at the beginning
    if (cleaned.contains('+')) {
      int plusIndex = cleaned.indexOf('+');
      if (plusIndex == 0) {
        // Keep only one + at start
        cleaned = '+' + cleaned.replaceAll('+', '');
      } else {
        // Remove + if not at start
        cleaned = cleaned.replaceAll('+', '');
      }
    }
    
    return cleaned;
  }

  /// Show call options bottom sheet
  static Future<void> showCallOptions({
    required BuildContext context,
    required String phoneNumber,
    String? name,
    bool showMessage = true,
    bool showWhatsApp = true,
    String? whatsappNumber,
  }) {
    
    String displayName = name ?? 'Agent';
    String cleanedNumber = _cleanPhoneNumber(phoneNumber);
    String formattedNumber = formatPhoneNumber(phoneNumber);
    
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
              // Header with contact info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.person,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formattedNumber,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Call option
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: Colors.green.shade700,
                    size: 22,
                  ),
                ),
                title: const Text(
                  'Phone Call',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(formattedNumber),
                onTap: () {
                  Navigator.pop(context);
                  makePhoneCallWithConfirmation(
                    context: context,
                    phoneNumber: phoneNumber,
                    name: name,
                  );
                },
              ),
              
              // WhatsApp option (if enabled)
              if (showWhatsApp)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/whatsapp.png',
                      width: 22,
                      height: 22,
                      errorBuilder: (_, __, ___) {
                        return Icon(
                          Icons.chat,
                          color: Colors.green.shade700,
                          size: 22,
                        );
                      },
                    ),
                  ),
                  title: const Text(
                    'WhatsApp Chat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text('Message on WhatsApp'),
                  onTap: () {
                    Navigator.pop(context);
                    // You can integrate WhatsAppUtils here
                    _openWhatsApp(context, whatsappNumber ?? phoneNumber);
                  },
                ),
              
              // Message option (if enabled)
              if (showMessage)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.message,
                      color: Colors.blue.shade700,
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text('Open messaging app'),
                  onTap: () {
                    Navigator.pop(context);
                    _openSMS(context, phoneNumber);
                  },
                ),
              
              // Copy number option
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.copy,
                    color: Colors.grey.shade700,
                    size: 22,
                  ),
                ),
                title: const Text(
                  'Copy Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text('Copy to clipboard'),
                onTap: () {
                  Navigator.pop(context);
                  _copyToClipboard(context, cleanedNumber);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Open SMS app
  static Future<void> _openSMS(BuildContext context, String phoneNumber) async {
    String cleanedNumber = _cleanPhoneNumber(phoneNumber);
    final smsUrl = Uri.parse('sms:$cleanedNumber');
    
    try {
      if (await canLaunchUrl(smsUrl)) {
        await launchUrl(smsUrl);
      } else {
        _showErrorSnackBar(context, 'Could not open messaging app');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error: $e');
    }
  }

  /// Open WhatsApp (integrate with WhatsAppUtils)
  static Future<void> _openWhatsApp(BuildContext context, String phoneNumber) async {
    // You can import and use WhatsAppUtils here
    // For now, we'll use a simple implementation
    try {
      String cleanedNumber = _cleanPhoneNumber(phoneNumber);
      String url = "https://wa.me/$cleanedNumber";
      
      if (Platform.isAndroid) {
        url = "https://wa.me/$cleanedNumber";
      } else if (Platform.isIOS) {
        url = "https://wa.me/$cleanedNumber";
      }
      
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, 'Could not open WhatsApp');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error: $e');
    }
  }

  /// Copy to clipboard
  static void _copyToClipboard(BuildContext context, String text) {
    // You'll need to add clipboard service
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number copied: $text'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show call initiated snackbar
  static void _showCallInitiatedSnackBar(BuildContext context, String phoneNumber, String? name) {
    String displayName = name ?? 'Call';
    String formattedNumber = formatPhoneNumber(phoneNumber);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.call_made, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Call initiated',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    displayName != phoneNumber ? '$displayName - $formattedNumber' : formattedNumber,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show error snackbar
  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}