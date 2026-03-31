// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:product_app/Provider/VersionProvider/version_provider.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/Provider/auth/otp_provider.dart';
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/Provider/navbar_provider.dart';
import 'package:product_app/Provider/notification_provider.dart';
import 'package:product_app/Provider/product/product_provider.dart';
import 'package:product_app/Provider/profile/profile_provider.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/service/notification_service.dart';
import 'package:product_app/views/Version/global_watcher.dart';
import 'package:product_app/views/splash/logo_screen.dart';
import 'package:provider/provider.dart';

// ============================================
// BACKGROUND MESSAGE HANDLER (App in Background/Terminated)
// ============================================
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // 🔴🔴🔴 BACKGROUND NOTIFICATION TRIGGERED 🔴🔴🔴
  print('=' * 50);
  print('🔥 BACKGROUND NOTIFICATION RECEIVED!');
  print('=' * 50);
  print('📱 Message ID: ${message.messageId}');
  print('📱 Message Type: BACKGROUND/TERMINATED');
  print('📱 Sent Time: ${message.sentTime}');
  print('📱 From: ${message.from}');
  print('📱 Collapse Key: ${message.collapseKey}');
  print('-' * 50);

  // Get image from data payload (NOT from notification)
  String? imageUrl = message.data['image'];

  // Notification Data
  if (message.notification != null) {
    print('🔔 NOTIFICATION CONTENT:');
    print('   Title: ${message.notification!.title}');
    print('   Body: ${message.notification!.body}');
  } else {
    print('ℹ️ This is a data-only message (no notification)');
  }

  // Custom Data Payload (contains image URL)
  print('-' * 50);
  print('📦 CUSTOM DATA PAYLOAD:');
  if (message.data.isNotEmpty) {
    message.data.forEach((key, value) {
      print('   $key: $value');
    });
  } else {
    print('   No custom data');
  }

  print('=' * 50);

  // Show local notification with image from data
  String title = message.notification?.title ??
      message.data['title'] ??
      'New Notification';

  String body = message.notification?.body ?? message.data['body'] ?? '';

  await NotificationService.showNotification(
    title: title,
    body: body,
    payload: message.data.toString(),
    imageUrl: imageUrl, // Pass image URL from data
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 APP STARTING...');
  print('=' * 50);

  // Initialize Firebase
  await Firebase.initializeApp();
  print('✅ Firebase initialized');

  // Initialize Shared Preferences
  await SharedPrefHelper.init();
  print('✅ Shared Preferences initialized');

  // Set up Firebase Messaging background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('✅ Background message handler registered');

  // Request permissions
  await NotificationService.requestPermissions();
  print('✅ Notification permissions requested');

  // Initialize local notifications
  await NotificationService.initLocalNotifications();
  print('✅ Local notifications initialized');

  // ⭐ FOREGROUND MESSAGES (App is open)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // 🔴🔴🔴 FOREGROUND NOTIFICATION TRIGGERED 🔴🔴🔴
    print('=' * 50);
    print('🔥 FOREGROUND NOTIFICATION RECEIVED!');
    print('=' * 50);
    print('📱 Message ID: ${message.messageId}');
    print('📱 Message Type: FOREGROUND');
    print('📱 Sent Time: ${message.sentTime}');
    print('📱 From: ${message.from}');
    print('-' * 50);

    // Get image from data payload
    String? imageUrl = message.data['image'];

    // Notification Data
    if (message.notification != null) {
      print('🔔 NOTIFICATION CONTENT:');
      print('   Title: ${message.notification!.title}');
      print('   Body: ${message.notification!.body}');
    } else {
      print('ℹ️ This is a data-only message (no notification)');
    }

    // Custom Data Payload
    print('-' * 50);
    print('📦 CUSTOM DATA PAYLOAD:');
    if (message.data.isNotEmpty) {
      message.data.forEach((key, value) {
        print('   $key: $value');
      });
    } else {
      print('   No custom data');
    }

    print('=' * 50);

    // Show local notification with image
    String title = message.notification?.title ??
        message.data['title'] ??
        'New Notification';

    String body = message.notification?.body ?? message.data['body'] ?? '';

    NotificationService.showNotification(
      title: title,
      body: body,
      payload: message.data.toString(),
      imageUrl: imageUrl, // Pass image URL from data
    );
  });
  print('✅ Foreground message handler registered');

  // ⭐ BACKGROUND MESSAGES WHEN APP IS OPENED FROM BACKGROUND (User taps)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // 🔴🔴🔴 NOTIFICATION TAPPED - APP OPENED FROM BACKGROUND 🔴🔴🔴
    print('=' * 50);
    print('🔥 NOTIFICATION TAPPED - APP OPENED FROM BACKGROUND!');
    print('=' * 50);
    print('📱 Message ID: ${message.messageId}');
    print('📱 Action: USER TAPPED NOTIFICATION');
    print('📱 App State: Was in Background, now Foreground');
    print('📱 Sent Time: ${message.sentTime}');
    print('-' * 50);

    // Get image from data
    String? imageUrl = message.data['image'];
    print('📱 Image URL: $imageUrl');

    // Notification Data
    if (message.notification != null) {
      print('🔔 NOTIFICATION THAT WAS TAPPED:');
      print('   Title: ${message.notification!.title}');
      print('   Body: ${message.notification!.body}');
    }

    // Custom Data Payload
    print('-' * 50);
    print('📦 CUSTOM DATA PAYLOAD:');
    if (message.data.isNotEmpty) {
      message.data.forEach((key, value) {
        print('   $key: $value');
      });

      // Navigate based on type
      String? type = message.data['type'];
      print('📍 Navigation Target: $type');
      _handleNotificationNavigation(message);
    } else {
      print('   No custom data');
    }

    print('=' * 50);
  });
  print('✅ Message opened handler registered');

  // ⭐ INITIAL MESSAGE (App opened from terminated state by tapping notification)
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // 🔴🔴🔴 APP OPENED FROM TERMINATED STATE VIA NOTIFICATION 🔴🔴🔴
    print('=' * 50);
    print('🔥 APP OPENED FROM TERMINATED STATE VIA NOTIFICATION!');
    print('=' * 50);
    print('📱 Message ID: ${initialMessage.messageId}');
    print('📱 Action: APP LAUNCHED FROM NOTIFICATION');
    print('📱 App State: Was Terminated, now Foreground');
    print('📱 Sent Time: ${initialMessage.sentTime}');
    print('-' * 50);

    // Get image from data
    String? imageUrl = initialMessage.data['image'];
    print('📱 Image URL: $imageUrl');

    // Notification Data
    if (initialMessage.notification != null) {
      print('🔔 NOTIFICATION THAT LAUNCHED THE APP:');
      print('   Title: ${initialMessage.notification!.title}');
      print('   Body: ${initialMessage.notification!.body}');
    }

    // Custom Data Payload
    print('-' * 50);
    print('📦 CUSTOM DATA PAYLOAD:');
    if (initialMessage.data.isNotEmpty) {
      initialMessage.data.forEach((key, value) {
        print('   $key: $value');
      });

      // Navigate based on type
      String? type = initialMessage.data['type'];
      print('📍 Navigation Target: $type');
      _handleNotificationNavigation(initialMessage);
    } else {
      print('   No custom data');
    }

    print('=' * 50);
  }
  print('✅ Initial message checked');

  // Get FCM Token
  String? fcmToken = await NotificationService.getFCMToken();
  print('📱 FCM Token: $fcmToken');

  print('=' * 50);
  print('🚀 APP READY FOR NOTIFICATIONS!');
  print('=' * 50);

  runApp(const MyApp());
}

// Navigation handler
void _handleNotificationNavigation(RemoteMessage message) {
  final data = message.data;
  final type = data['type'];

  print('📍 NAVIGATING TO: $type');

  // You can use a navigation service or pass to your provider
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
            create: (_) => VersionProvider()), // Add version provider
      ],
      child: const _AppBootstrapper(), // Use bootstrapper pattern
    );
  }
}

/// ---------------------------------------------------------------------------
/// BOOTSTRAPPER (runs once, NO UI, NO rebuild loops)
/// ---------------------------------------------------------------------------
class _AppBootstrapper extends StatefulWidget {
  const _AppBootstrapper();

  @override
  State<_AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<_AppBootstrapper> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    // Run AFTER first frame (no UI blocking)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check version on app start
      context.read<VersionProvider>().checkVersion();
    });

    // Optional: Check version when app resumes
    // You can add app lifecycle handling here if needed
  }

  @override
  Widget build(BuildContext context) {
    return const _AppView();
  }
}

/// ---------------------------------------------------------------------------
/// APP VIEW (UI ONLY)
/// ---------------------------------------------------------------------------
class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final versionProvider = context.watch<VersionProvider>();

    return MaterialApp(
      title: 'Product App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE33629),
          primary: const Color(0xFFE33629),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE33629),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const LogoScreen(),
      builder: (context, child) {
        Widget screen = child ?? const SizedBox.shrink();

        // Always wrap with version checker if needed
        return UpgradeWatcher(
          child: screen,
        );
      },
    );
  }
}
