// lib/providers/notification_provider.dart
import 'package:flutter/material.dart';
import 'package:product_app/service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [];
  int _unreadCount = 0;
  String? _fcmToken;

  // Getters
  List<Map<String, dynamic>> get notifications => _notifications;
  int get unreadCount => _unreadCount;
  String? get fcmToken => _fcmToken;

  NotificationProvider() {
    initNotifications();
  }

  Future<void> initNotifications() async {
    await NotificationService.initLocalNotifications();
    await NotificationService.getFCMToken().then((token) {
      _fcmToken = token;
      notifyListeners();
    });
    
    NotificationService.handleForegroundMessages();
    NotificationService.handleBackgroundMessages();
    await NotificationService.handleInitialMessage();
  }

  void addNotification(Map<String, dynamic> notification) {
    _notifications.insert(0, notification);
    _unreadCount++;
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    // Mark as read logic
    notifyListeners();
  }

  void markAllAsRead() {
    _unreadCount = 0;
    notifyListeners();
  }
}