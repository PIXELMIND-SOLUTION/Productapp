import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:product_app/helper/helper_function.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];
  bool isLoading = true;
  bool isSelectionMode = false;
  Set<String> selectedNotifications = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  // Fetch notifications from API
  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      isSelectionMode = false;
      selectedNotifications.clear();
    });

    try {
      final userId = SharedPrefHelper.getUserId();
      if (userId == null) {
        throw Exception('User ID not found');
      }

      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/notifications/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
      );

      print('Response status code for notifications: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          notifications = (data['notifications'] as List)
              .map((item) => NotificationModel.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final response = await http.put(
        Uri.parse('http://31.97.206.144:9174/api/notifications/read/$notificationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
      );

      print('Mark as read response: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          final index = notifications.indexWhere((n) => n.id == notificationId);
          if (index != -1) {
            notifications[index].isRead = true;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark as read: $e')),
      );
    }
  }

  // BULK DELETE NOTIFICATIONS - Single or Multiple
  Future<void> deleteNotificationsBulk(List<String> notificationIds) async {
    if (notificationIds.isEmpty) return;

    try {
      print('Deleting notifications: $notificationIds');
      
      final response = await http.delete(
        Uri.parse('http://31.97.206.144:9174/api/notifications/bulk-delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
        body: json.encode({
          'notificationIds': notificationIds,
        }),
      );

      print('Delete bulk response status: ${response.statusCode}');
      print('Delete bulk response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        setState(() {
          // Remove deleted notifications from list
          notifications.removeWhere((n) => notificationIds.contains(n.id));
          selectedNotifications.clear();
          if (selectedNotifications.isEmpty) {
            isSelectionMode = false;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              notificationIds.length == 1
                  ? 'Notification deleted'
                  : '${notificationIds.length} notifications deleted',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to delete notifications');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Delete single notification
  Future<void> deleteSingleNotification(String notificationId) async {
    await deleteNotificationsBulk([notificationId]);
  }

  // Delete multiple selected notifications
  Future<void> deleteSelectedNotifications() async {
    if (selectedNotifications.isEmpty) return;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notifications'),
        content: Text(
          'Are you sure you want to delete ${selectedNotifications.length} notification${selectedNotifications.length > 1 ? 's' : ''}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await deleteNotificationsBulk(selectedNotifications.toList());
    }
  }

  // Toggle selection mode
  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        selectedNotifications.clear();
      }
    });
  }

  // Toggle notification selection
  void toggleNotificationSelection(String notificationId) {
    setState(() {
      if (selectedNotifications.contains(notificationId)) {
        selectedNotifications.remove(notificationId);
      } else {
        selectedNotifications.add(notificationId);
      }
      
      if (selectedNotifications.isEmpty) {
        isSelectionMode = false;
      }
    });
  }

  // Select/Deselect all notifications
  void toggleSelectAll() {
    setState(() {
      if (selectedNotifications.length == notifications.length) {
        selectedNotifications.clear();
      } else {
        selectedNotifications = notifications.map((n) => n.id).toSet();
      }
    });
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSelectionMode
            ? Text(
                '${selectedNotifications.length} selected',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            : const Text(
                'Notifications',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
        leading: IconButton(
          onPressed: isSelectionMode 
              ? toggleSelectionMode 
              : () => Navigator.of(context).pop(),
          icon: Icon(isSelectionMode ? Icons.close : Icons.arrow_back_ios),
        ),
        actions: [
          if (isSelectionMode)
            Row(
              children: [
                IconButton(
                  onPressed: toggleSelectAll,
                  icon: Icon(
                    selectedNotifications.length == notifications.length
                        ? Icons.deselect
                        : Icons.select_all,
                  ),
                  tooltip: selectedNotifications.length == notifications.length
                      ? 'Deselect all'
                      : 'Select all',
                ),
                if (selectedNotifications.isNotEmpty)
                  IconButton(
                    onPressed: deleteSelectedNotifications,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Delete selected',
                  ),
              ],
            )
          else if (notifications.isNotEmpty)
            Row(
              children: [
                IconButton(
                  onPressed: toggleSelectionMode,
                  icon: const Icon(Icons.checklist),
                  tooltip: 'Select multiple',
                ),
                IconButton(
                  onPressed: fetchNotifications,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                ),
              ],
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 60, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchNotifications,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : notifications.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_none,
                              size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No notifications yet',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: fetchNotifications,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          final isSelected = selectedNotifications.contains(notification.id);

                          return Dismissible(
                            key: Key(notification.id),
                            direction: isSelectionMode 
                                ? DismissDirection.none 
                                : DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            confirmDismiss: (direction) async {
                              if (isSelectionMode) return false;
                              
                              return await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Notification'),
                                  content: const Text('Are you sure?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Delete',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onDismissed: (direction) {
                              deleteSingleNotification(notification.id);
                            },
                            child: GestureDetector(
                              onTap: isSelectionMode
                                  ? () => toggleNotificationSelection(notification.id)
                                  : () {
                                      if (!notification.isRead) {
                                        markAsRead(notification.id);
                                      }
                                    },
                              onLongPress: () {
                                if (!isSelectionMode) {
                                  toggleSelectionMode();
                                  toggleNotificationSelection(notification.id);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.shade100
                                      : notification.isRead
                                          ? Colors.white
                                          : Colors.blue.shade50,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : notification.isRead
                                            ? Colors.grey.shade300
                                            : Colors.blue.shade200,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    if (isSelectionMode)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          isSelected
                                              ? Icons.check_circle
                                              : Icons.radio_button_unchecked,
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: notification.image != null &&
                                              notification.image!.isNotEmpty
                                          ? Image.network(
                                              notification.image!,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  width: 50,
                                                  height: 50,
                                                  color: Colors.grey.shade300,
                                                  child: const Icon(Icons
                                                      .image_not_supported),
                                                );
                                              },
                                            )
                                          : Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.blue.shade100,
                                              child: const Icon(
                                                  Icons.notifications,
                                                  color: Colors.blue),
                                            ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notification.title,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: notification.isRead
                                                  ? FontWeight.normal
                                                  : FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          if (notification.message !=
                                              null) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              notification.message!,
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 13,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          getTimeAgo(notification.createdAt),
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        if (!isSelectionMode) ...[
                                          const SizedBox(height: 4),
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline,
                                                size: 20),
                                            color: Colors.grey,
                                            onPressed: () => showDeleteConfirmation(
                                                notification.id),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }

  // Show delete confirmation for single notification
  Future<void> showDeleteConfirmation(String notificationId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await deleteSingleNotification(notificationId);
    }
  }
}

// Notification Model
class NotificationModel {
  final String id;
  final String title;
  final String? message;
  final String? image;
  bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    this.message,
    this.image,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? 'Notification',
      message: json['message'] ?? json['body'],
      image: json['image'] ?? json['imageUrl'],
      isRead: json['isRead'] ?? json['read'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}