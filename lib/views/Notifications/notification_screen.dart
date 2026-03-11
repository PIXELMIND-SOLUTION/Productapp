// import 'package:flutter/material.dart';

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Notifications',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 330,
//               height: 50,
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(6)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png',
//                           width: 40,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () {

//                         },
//                         child: const Text(
//                           'New Villa added',
//                           style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Text(
//                     '6 min ago',
//                     style: TextStyle(color: Colors.grey),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 330,
//               height: 50,
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(6)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png',
//                           width: 40,
//                           height: 52,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () {
//                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
//                         },
//                         child: const Text(
//                           'New Villa added',
//                           style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Text(
//                     '6 min ago',
//                     style: TextStyle(color: Colors.grey),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

      print(
          'Response status code for getall notifications ${response.statusCode}');
      print(
          'Response bodyyyyyyyyyyyy for getall notifications ${response.body}');

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
        Uri.parse(
            'http://31.97.206.144:9174/api/notifications/read/$notificationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
      );

      print(
          'Response status code for reaaaaaaaaaaadddddddddd notifications ${response.statusCode}');
      print(
          'Response bodyyyyyyyyyyyy for readddddddddddd notifications ${response.body}');

      if (response.statusCode == 200) {
        // Update local state
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

  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://31.97.206.144:9174/api/notifications/$notificationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
      );

      print(
          'Response status code for deeeeeeeeleeeeeteeeeee notifications ${response.statusCode}');
      print(
          'Response bodyyyyyyyyyyyy for deleteeee notifications ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          notifications.removeWhere((n) => n.id == notificationId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification deleted')),
        );
      } else {
        throw Exception('Failed to delete notification');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete: $e')),
      );
    }
  }

  // Show delete confirmation dialog
  Future<void> showDeleteConfirmation(String notificationId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content:
            const Text('Are you sure you want to delete this notification?'),
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
      await deleteNotification(notificationId);
    }
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
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              onPressed: fetchNotifications,
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
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
                          return Dismissible(
                            key: Key(notification.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            confirmDismiss: (direction) async {
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
                              deleteNotification(notification.id);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: notification.isRead
                                      ? Colors.white
                                      : Colors.blue.shade50,
                                  border: Border.all(
                                    color: notification.isRead
                                        ? Colors.grey.shade300
                                        : Colors.blue.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: notification.image != null
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
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!notification.isRead) {
                                            markAsRead(notification.id);
                                          }
                                        },
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
                                        const SizedBox(height: 4),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline,
                                              size: 20),
                                          color: Colors.grey,
                                          onPressed: () =>
                                              showDeleteConfirmation(
                                                  notification.id),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
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
