import 'package:flutter/material.dart';

class StoryModel {
  final String id;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final String mediaUrl;
  final String? thumbnailUrl;
  final String mediaType;
  final String? caption;
  final List<String> likes;
  final List<Comment> comments;
  final List<Viewer> viewers;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;

  StoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.mediaUrl,
    this.thumbnailUrl,
    required this.mediaType,
    this.caption,
    required this.likes,
    required this.comments,
    required this.viewers,
    required this.createdAt,
    required this.expiresAt,
    required this.isActive,
  });

  bool isLikedByUser(String currentUserId) {
    return likes.contains(currentUserId);
  }

  bool isViewedByUser(String currentUserId) {
    if (currentUserId.isEmpty) return false;
    return viewers.any((viewer) => viewer.userId == currentUserId);
  }

  int get likesCount => likes.length;
  int get commentsCount => comments.length;
  int get viewersCount => viewers.length;

  // ✅ copyWith for immutable optimistic updates
  StoryModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userProfileImage,
    String? mediaUrl,
    String? thumbnailUrl,
    String? mediaType,
    String? caption,
    List<String>? likes,
    List<Comment>? comments,
    List<Viewer>? viewers,
    DateTime? createdAt,
    DateTime? expiresAt,
    bool? isActive,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      mediaType: mediaType ?? this.mediaType,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      viewers: viewers ?? this.viewers,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
    );
  }

  factory StoryModel.fromJson(Map<String, dynamic> json,
      {String? currentUserId}) {
    List<String> likesList = [];
    if (json['likes'] != null) {
      if (json['likes'] is List) {
        likesList =
            (json['likes'] as List).map((like) => like.toString()).toList();
      }
    }

    List<Comment> commentsList = [];
    if (json['comments'] != null && json['comments'] is List) {
      commentsList = (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
          .toList();
    }

    List<Viewer> viewersList = [];
    if (json['viewers'] != null && json['viewers'] is List) {
      viewersList = (json['viewers'] as List)
          .map((viewer) => Viewer.fromJson(viewer as Map<String, dynamic>))
          .toList();
    }

    final user = json['user'];
    Map<String, dynamic> userMap = {};
    if (user is Map<String, dynamic>) {
      userMap = user;
    }

    return StoryModel(
      id: json['_id']?.toString() ?? '',
      userId: userMap['_id']?.toString() ?? '',
      userName: userMap['name']?.toString() ?? 'User',
      userProfileImage: userMap['profileImage']?.toString(),
      mediaUrl: json['media']?.toString() ?? '',
      thumbnailUrl: json['thumbnail']?.toString(),
      mediaType: json['mediaType']?.toString() ?? 'image',
      caption: json['caption']?.toString(),
      likes: likesList,
      comments: commentsList,
      viewers: viewersList,
      createdAt: _parseDate(json['createdAt']),
      expiresAt: _parseDate(json['expiresAt']),
      isActive: json['isActive'] ?? true,
    );
  }

  static DateTime _parseDate(dynamic dateValue) {
    if (dateValue == null) return DateTime.now();
    if (dateValue is DateTime) return dateValue;
    if (dateValue is String) {
      return DateTime.tryParse(dateValue) ?? DateTime.now();
    }
    return DateTime.now();
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final String text;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.text,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    Map<String, dynamic> userMap = {};
    if (user is Map<String, dynamic>) {
      userMap = user;
    }

    return Comment(
      id: json['_id']?.toString() ?? '',
      userId: userMap['_id']?.toString() ?? json['userId']?.toString() ?? '',
      userName: userMap['name']?.toString() ?? 'User',
      userProfileImage: userMap['profileImage']?.toString(),
      text: json['text']?.toString() ?? '',
      createdAt: StoryModel._parseDate(json['createdAt']),
    );
  }
}

class Viewer {
  final String userId;
  final String userName;
  final String? userProfileImage;
  final DateTime viewedAt;

  Viewer({
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.viewedAt,
  });

  factory Viewer.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    Map<String, dynamic> userMap = {};
    if (user is Map<String, dynamic>) {
      userMap = user;
    }

    return Viewer(
      userId: userMap['_id']?.toString() ?? '',
      userName: userMap['name']?.toString() ?? 'User',
      userProfileImage: userMap['profileImage']?.toString(),
      viewedAt: StoryModel._parseDate(json['viewedAt']),
    );
  }
}

class StoryGroup {
  final String userId;
  final String userName;
  final String? userProfileImage;
  final List<StoryModel> stories;

  StoryGroup({
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.stories,
  });

  // ✅ copyWith for immutable optimistic updates
  StoryGroup copyWith({
    String? userId,
    String? userName,
    String? userProfileImage,
    List<StoryModel>? stories,
  }) {
    return StoryGroup(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      stories: stories ?? this.stories,
    );
  }

  factory StoryGroup.fromJson(Map<String, dynamic> json,
      {String? currentUserId}) {
    final user = json['user'];
    Map<String, dynamic> userMap = {};
    if (user is Map<String, dynamic>) {
      userMap = user;
    }

    List<StoryModel> storiesList = [];
    final storiesData = json['stories'];
    if (storiesData is List) {
      storiesList = storiesData
          .where((story) => story is Map<String, dynamic>)
          .map((story) => StoryModel.fromJson(story as Map<String, dynamic>,
              currentUserId: currentUserId))
          .toList();
    }

    return StoryGroup(
      userId: userMap['_id']?.toString() ?? '',
      userName: userMap['name']?.toString() ?? 'User',
      userProfileImage: userMap['profileImage']?.toString(),
      stories: storiesList,
    );
  }
}
