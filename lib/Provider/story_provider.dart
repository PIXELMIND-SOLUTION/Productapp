// import 'package:flutter/material.dart';
// import '../model/story_model.dart';
// import 'dart:io';
// import '../service/story_service.dart';

// class StoryProvider extends ChangeNotifier {
//   final StoryService _storyService = StoryService();

//   List<StoryGroup> _storyGroups = [];
//   List<StoryModel> _userStories = [];
//   List<StoryModel> _myActiveStories = [];
//   List<StoryModel> _myExpiredStories = [];

//   bool _isLoading = false;
//   bool _isLoadingUserStories = false;
//   String? _errorMessage;

//   // Getters
//   List<StoryGroup> get storyGroups => _storyGroups;
//   List<StoryModel> get userStories => _userStories;
//   List<StoryModel> get myActiveStories => _myActiveStories;
//   List<StoryModel> get myExpiredStories => _myExpiredStories;
//   bool get isLoading => _isLoading;
//   bool get isLoadingUserStories => _isLoadingUserStories;
//   String? get errorMessage => _errorMessage;

//   // Fetch all stories
//   Future<bool> fetchAllStories({String? userId}) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     final result = await _storyService.getAllStories(userId: userId);

//     if (result['success'] == true) {
//       _storyGroups = result['storyGroups'];
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = result['message'];
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Delete comment
//   Future<bool> deleteComment(
//       String storyId, String commentId, String userId) async {
//     final result =
//         await _storyService.deleteComment(storyId, commentId, userId);

//     if (result['success'] == true) {
//       await fetchAllStories(userId: userId);
//       return true;
//     }
//     return false;
//   }

//   // Fetch user stories
//   Future<bool> fetchUserStories(String userId, {String? viewerId}) async {
//     _isLoadingUserStories = true;
//     notifyListeners();

//     final result =
//         await _storyService.getUserStories(userId, viewerId: viewerId);

//     if (result['success'] == true) {
//       _userStories = result['stories'];
//       _isLoadingUserStories = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = result['message'];
//       _isLoadingUserStories = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Create story
//   Future<bool> createStory({
//     required String userId,
//     required File mediaFile,
//     String? caption,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     final result = await _storyService.createStory(
//       userId: userId,
//       mediaFile: mediaFile,
//       caption: caption,
//     );

//     if (result['success'] == true) {
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = result['message'];
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // View story
//   Future<bool> viewStory(String storyId, String userId) async {
//     final result = await _storyService.viewStory(storyId, userId);

//     if (result['success'] == true) {
//       // Refresh stories to get updated viewers list
//       await fetchAllStories(userId: userId);
//       return true;
//     }
//     return false;
//   }

//   // Toggle like
//   Future<bool> toggleLike(
//       String storyId, String userId, bool currentlyLiked) async {
//     final result = await _storyService.toggleLike(storyId, userId);

//     if (result['success'] == true) {
//       // Refresh stories to get updated likes
//       await fetchAllStories(userId: userId);
//       return true;
//     }
//     return false;
//   }

//   // Add comment
//   Future<bool> addComment(String storyId, String userId, String text) async {
//     final result = await _storyService.addComment(storyId, userId, text);

//     if (result['success'] == true) {
//       // Refresh stories to get updated comments
//       await fetchAllStories(userId: userId);
//       return true;
//     }
//     return false;
//   }

//   // Fetch my stories
//   Future<bool> fetchMyStories(String userId) async {
//     _isLoading = true;
//     notifyListeners();

//     final result = await _storyService.getMyStories(userId);

//     if (result['success'] == true) {
//       _myActiveStories = result['activeStories'];
//       _myExpiredStories = result['expiredStories'];
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = result['message'];
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Delete story
//   Future<bool> deleteStory(String storyId, String userId) async {
//     final result = await _storyService.deleteStory(storyId, userId);

//     if (result['success'] == true) {
//       await fetchAllStories(userId: userId);
//       await fetchMyStories(userId);
//       return true;
//     }
//     return false;
//   }

//   // Clear error
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Refresh stories
//   Future<void> refreshStories({String? userId}) async {
//     await fetchAllStories(userId: userId);
//   }
// }

import 'package:flutter/material.dart';
import '../model/story_model.dart';
import 'dart:io';
import '../service/story_service.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService _storyService = StoryService();

  List<StoryGroup> _storyGroups = [];
  List<StoryModel> _userStories = [];
  List<StoryModel> _myActiveStories = [];
  List<StoryModel> _myExpiredStories = [];

  bool _isLoading = false;
  bool _isLoadingUserStories = false;
  String? _errorMessage;

  // Getters
  List<StoryGroup> get storyGroups => _storyGroups;
  List<StoryModel> get userStories => _userStories;
  List<StoryModel> get myActiveStories => _myActiveStories;
  List<StoryModel> get myExpiredStories => _myExpiredStories;
  bool get isLoading => _isLoading;
  bool get isLoadingUserStories => _isLoadingUserStories;
  String? get errorMessage => _errorMessage;

  // Fetch all stories
  Future<bool> fetchAllStories({String? userId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _storyService.getAllStories(userId: userId);

    if (result['success'] == true) {
      _storyGroups = result['storyGroups'];
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete comment
  Future<bool> deleteComment(
      String storyId, String commentId, String userId) async {
    final result =
        await _storyService.deleteComment(storyId, commentId, userId);

    if (result['success'] == true) {
      // Optimistically remove comment from local state
      _removeCommentLocally(storyId, commentId);
      notifyListeners();
      // Refresh in background
      fetchAllStories(userId: userId);
      return true;
    }
    return false;
  }

  void _removeCommentLocally(String storyId, String commentId) {
    for (int i = 0; i < _storyGroups.length; i++) {
      final group = _storyGroups[i];
      for (int j = 0; j < group.stories.length; j++) {
        if (group.stories[j].id == storyId) {
          final story = group.stories[j];
          final updatedComments =
              story.comments.where((c) => c.id != commentId).toList();
          final updatedStory = story.copyWith(comments: updatedComments);
          final updatedStories = List<StoryModel>.from(group.stories);
          updatedStories[j] = updatedStory;
          _storyGroups[i] = group.copyWith(stories: updatedStories);
          return;
        }
      }
    }
  }

  // Fetch user stories
  Future<bool> fetchUserStories(String userId, {String? viewerId}) async {
    _isLoadingUserStories = true;
    notifyListeners();

    final result =
        await _storyService.getUserStories(userId, viewerId: viewerId);

    if (result['success'] == true) {
      _userStories = result['stories'];
      _isLoadingUserStories = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoadingUserStories = false;
      notifyListeners();
      return false;
    }
  }

  // Create story
  Future<bool> createStory({
    required String userId,
    required File mediaFile,
    String? caption,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _storyService.createStory(
      userId: userId,
      mediaFile: mediaFile,
      caption: caption,
    );

    if (result['success'] == true) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // View story
  Future<bool> viewStory(String storyId, String userId) async {
    final result = await _storyService.viewStory(storyId, userId);

    if (result['success'] == true) {
      // Optimistically mark story as viewed locally
      _markStoryViewedLocally(storyId, userId);
      notifyListeners();
      return true;
    }
    return false;
  }

  void _markStoryViewedLocally(String storyId, String userId) {
    for (int i = 0; i < _storyGroups.length; i++) {
      final group = _storyGroups[i];
      for (int j = 0; j < group.stories.length; j++) {
        if (group.stories[j].id == storyId) {
          final story = group.stories[j];
          if (!story.isViewedByUser(userId)) {
            final newViewer = Viewer(
              userId: userId,
              userName: '',
              viewedAt: DateTime.now(),
            );
            final updatedViewers = List<Viewer>.from(story.viewers)
              ..add(newViewer);
            final updatedStory = story.copyWith(viewers: updatedViewers);
            final updatedStories = List<StoryModel>.from(group.stories);
            updatedStories[j] = updatedStory;
            _storyGroups[i] = group.copyWith(stories: updatedStories);
          }
          return;
        }
      }
    }
  }

  // Toggle like — optimistic update
  Future<bool> toggleLike(
      String storyId, String userId, bool currentlyLiked) async {
    // Optimistically update local state immediately
    _toggleLikeLocally(storyId, userId, currentlyLiked);
    notifyListeners();

    final result = await _storyService.toggleLike(storyId, userId);

    if (result['success'] == true) {
      // Sync actual count from server
      _syncLikeCount(storyId, result['likesCount'] as int?,
          result['liked'] as bool?, userId);
      notifyListeners();
      return true;
    } else {
      // Revert on failure
      _toggleLikeLocally(storyId, userId, !currentlyLiked);
      notifyListeners();
      return false;
    }
  }

  void _toggleLikeLocally(String storyId, String userId, bool currentlyLiked) {
    for (int i = 0; i < _storyGroups.length; i++) {
      final group = _storyGroups[i];
      for (int j = 0; j < group.stories.length; j++) {
        if (group.stories[j].id == storyId) {
          final story = group.stories[j];
          List<String> updatedLikes = List<String>.from(story.likes);
          if (currentlyLiked) {
            updatedLikes.remove(userId);
          } else {
            if (!updatedLikes.contains(userId)) {
              updatedLikes.add(userId);
            }
          }
          final updatedStory = story.copyWith(likes: updatedLikes);
          final updatedStories = List<StoryModel>.from(group.stories);
          updatedStories[j] = updatedStory;
          _storyGroups[i] = group.copyWith(stories: updatedStories);
          return;
        }
      }
    }
  }

  void _syncLikeCount(
      String storyId, int? serverCount, bool? serverLiked, String userId) {
    if (serverCount == null) return;
    for (int i = 0; i < _storyGroups.length; i++) {
      final group = _storyGroups[i];
      for (int j = 0; j < group.stories.length; j++) {
        if (group.stories[j].id == storyId) {
          final story = group.stories[j];
          List<String> updatedLikes = List<String>.from(story.likes);
          // Ensure local liked state matches server
          if (serverLiked == true && !updatedLikes.contains(userId)) {
            updatedLikes.add(userId);
          } else if (serverLiked == false) {
            updatedLikes.remove(userId);
          }
          final updatedStory = story.copyWith(likes: updatedLikes);
          final updatedStories = List<StoryModel>.from(group.stories);
          updatedStories[j] = updatedStory;
          _storyGroups[i] = group.copyWith(stories: updatedStories);
          return;
        }
      }
    }
  }

  // Add comment — FIX: pass userId, optimistic update
  Future<bool> addComment(String storyId, String userId, String text) async {
    final result = await _storyService.addComment(storyId, userId, text);

    if (result['success'] == true) {
      // Optimistically add comment to local state
      if (result['comment'] != null) {
        _addCommentLocally(storyId, result['comment'] as Map<String, dynamic>);
      }
      notifyListeners();
      // Refresh in background to get full populated comment data
      fetchAllStories(userId: userId);
      return true;
    }
    return false;
  }

  void _addCommentLocally(String storyId, Map<String, dynamic> commentJson) {
    for (int i = 0; i < _storyGroups.length; i++) {
      final group = _storyGroups[i];
      for (int j = 0; j < group.stories.length; j++) {
        if (group.stories[j].id == storyId) {
          final story = group.stories[j];
          final newComment = Comment.fromJson(commentJson);
          final updatedComments = List<Comment>.from(story.comments)
            ..add(newComment);
          final updatedStory = story.copyWith(comments: updatedComments);
          final updatedStories = List<StoryModel>.from(group.stories);
          updatedStories[j] = updatedStory;
          _storyGroups[i] = group.copyWith(stories: updatedStories);
          return;
        }
      }
    }
  }

  // Fetch my stories
  Future<bool> fetchMyStories(String userId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _storyService.getMyStories(userId);

    if (result['success'] == true) {
      _myActiveStories = result['activeStories'];
      _myExpiredStories = result['expiredStories'];
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete story
  Future<bool> deleteStory(String storyId, String userId) async {
    final result = await _storyService.deleteStory(storyId, userId);

    if (result['success'] == true) {
      // Remove locally immediately
      _storyGroups = _storyGroups
          .map((group) => group.copyWith(
              stories: group.stories.where((s) => s.id != storyId).toList()))
          .where((group) => group.stories.isNotEmpty)
          .toList();
      notifyListeners();
      // Refresh in background
      fetchAllStories(userId: userId);
      fetchMyStories(userId);
      return true;
    }
    return false;
  }

  // Get a single story by ID from current groups
  StoryModel? getStoryById(String storyId) {
    for (final group in _storyGroups) {
      for (final story in group.stories) {
        if (story.id == storyId) return story;
      }
    }
    return null;
  }

  // Get story group by userId
  StoryGroup? getGroupByUserId(String userId) {
    try {
      return _storyGroups.firstWhere((g) => g.userId == userId);
    } catch (_) {
      return null;
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Refresh stories
  Future<void> refreshStories({String? userId}) async {
    await fetchAllStories(userId: userId);
  }
}
