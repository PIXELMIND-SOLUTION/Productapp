

// lib/service/notification_service.dart
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Request permissions
  static Future<void> requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('User declined or has not granted permission');
    }
  }

  // Get FCM Token
  static Future<String?> getFCMToken() async {
    try {
      String? token = await _messaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // Initialize local notifications
  static Future<void> initLocalNotifications() async {
    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // iOS initialization settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    
    // Combined initialization settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notification tapped: ${response.payload}');
        // Handle navigation
      },
    );

    await createNotificationChannel();
  }

  // Create notification channel
  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Download image from URL
  static Future<Uint8List?> _downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }

  // Show notification with image
// Show notification with large image
static Future<void> showNotification({
  required String title,
  required String body,
  String? payload,
  String? imageUrl,
}) async {
  try {
    print('📱 Showing notification - Title: $title, Body: $body, Image: $imageUrl');
    
    // Download image if URL is provided
    Uint8List? imageBytes;
    
    if (imageUrl != null && imageUrl.isNotEmpty) {
      imageBytes = await _downloadImage(imageUrl);
    }

    // ⭐ FIXED: Proper Big Picture Style for large images
    AndroidNotificationDetails androidDetails;
    
    if (imageBytes != null) {
      // Create Big Picture Style for large image
      final BigPictureStyleInformation bigPictureStyle = 
          BigPictureStyleInformation(
        ByteArrayAndroidBitmap(imageBytes), // The big image
        largeIcon: ByteArrayAndroidBitmap(imageBytes), // Small icon (can be same or different)
        contentTitle: title,
        summaryText: body,
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
      );
      
      androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
        enableVibration: true,
        styleInformation: bigPictureStyle, // ← This creates the large image
        largeIcon: ByteArrayAndroidBitmap(imageBytes), // Fallback large icon
        visibility: NotificationVisibility.public,
        category: AndroidNotificationCategory.message,
        timeoutAfter: 5000,
        color: const Color(0xFFE33629),
        ledColor: const Color(0xFFE33629),
        ledOnMs: 1000,
        ledOffMs: 500,
      );
      print('✅ Created BIG PICTURE style with large image');
    } else {
      // Text-only notification (small icon only)
      androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
        enableVibration: true,
      );
    }

    // iOS notification details
    const DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    // Combined notification details
    NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Generate unique ID
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    // Show notification
    await _localNotifications.show(
      id: notificationId,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
    
    print('✅ Large image notification shown with ID: $notificationId');
    
  } catch (e) {
    print('❌ Error showing notification: $e');
    // Fallback to text-only notification
    await _showTextOnlyNotification(title, body, payload);
  }
}

  // Fallback text-only notification
  static Future<void> _showTextOnlyNotification(
    String title, 
    String body, 
    String? payload
  ) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  // Handle foreground messages
  static void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('=' * 50);
      print('🔥 FOREGROUND NOTIFICATION RECEIVED!');
      print('=' * 50);
      
      // Get title and body from notification or data
      String title = message.notification?.title ?? 
                     message.data['title'] ?? 
                     'New Notification';
      
      String body = message.notification?.body ?? 
                    message.data['body'] ?? 
                    '';
      
      // ⭐ IMPORTANT: Get image from data payload (sent by your backend)
      String? imageUrl = message.data['image'];  // ← This is where your image URL is
      
      print('📱 Title: $title');
      print('📱 Body: $body');
      print('📱 Image URL: $imageUrl');
      print('📱 Data: ${message.data}');

      // Show notification with image
      showNotification(
        title: title,
        body: body,
        payload: message.data.toString(),
        imageUrl: imageUrl,  // ← Pass image URL
      );
    });
  }

  // Handle background messages when app is opened
  static void handleBackgroundMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('=' * 50);
      print('🔥 NOTIFICATION TAPPED - APP OPENED FROM BACKGROUND!');
      print('=' * 50);
      
      String? imageUrl = message.data['image'];
      print('📱 Image URL from tapped notification: $imageUrl');
      
      _handleNotificationNavigation(message);
    });
  }

  // Handle initial message
  static Future<void> handleInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    
    if (initialMessage != null) {
      print('=' * 50);
      print('🔥 APP OPENED FROM TERMINATED STATE VIA NOTIFICATION!');
      print('=' * 50);
      
      String? imageUrl = initialMessage.data['image'];
      print('📱 Image URL from initial notification: $imageUrl');
      
      _handleNotificationNavigation(initialMessage);
    }
  }

  // Handle notification navigation
  static void _handleNotificationNavigation(RemoteMessage message) {
    final data = message.data;
    final type = data['type'];
    
    print('📍 Navigation Target: $type');
    
    switch (type) {
      case 'product_approved':
        print('   Product ID: ${data['productId']}');
        break;
      case 'offer':
        print('   Offer Code: ${data['offerCode']}');
        break;
      case 'broadcast':
        print('   Broadcast Message');
        break;
      default:
        print('   Home Screen');
        break;
    }
  }

  // Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }
}