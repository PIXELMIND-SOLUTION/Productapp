import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../model/story_model.dart';
import '../constant/api_constant.dart';

class StoryService {
  static const String baseUrl = ApiConstants.baseUrl;

  // Create story with image or video
  Future<Map<String, dynamic>> createStory({
    required String userId,
    required File mediaFile,
    String? caption,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/api/stories/create');
      final request = http.MultipartRequest('POST', uri);

      request.fields['userId'] = userId;
      if (caption != null && caption.isNotEmpty) {
        request.fields['caption'] = caption;
      }

      final extension = mediaFile.path.split('.').last.toLowerCase();
      final isVideo = ['mp4', 'mov', 'avi', 'mkv'].contains(extension);
      final contentType = isVideo ? 'video/mp4' : 'image/jpeg';

      final fileStream = http.MultipartFile.fromBytes(
        'media',
        await mediaFile.readAsBytes(),
        filename: 'story_${DateTime.now().millisecondsSinceEpoch}.$extension',
        contentType: MediaType.parse(contentType),
      );
      request.files.add(await fileStream);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to create story'
        };
      }
    } catch (e) {
      print('Error creating story: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get all active stories
  Future<Map<String, dynamic>> getAllStories({String? userId}) async {
    try {
      String url = '$baseUrl/api/stories/all';
      if (userId != null && userId.isNotEmpty) {
        url += '?userId=$userId';
      }

      print('Fetching stories from: $url'); // Debug

      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}'); // Debug
      print(
          'Response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}'); // Debug

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          List<StoryGroup> storyGroups = [];

          // ✅ FIX: Safely handle the storiesByUser array
          final storiesByUser = data['storiesByUser'];

          if (storiesByUser is List) {
            for (var group in storiesByUser) {
              if (group is Map<String, dynamic>) {
                storyGroups
                    .add(StoryGroup.fromJson(group, currentUserId: userId));
              }
            }
          }

          return {
            'success': true,
            'storyGroups': storyGroups,
          };
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to fetch stories'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e, stackTrace) {
      print('Error fetching stories: $e');
      print('Stack trace: $stackTrace');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Delete comment
  Future<Map<String, dynamic>> deleteComment(
      String storyId, String commentId, String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/stories/$storyId/comment/$commentId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'message': data['message']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete comment'
        };
      }
    } catch (e) {
      print('Error deleting comment: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get user stories
  Future<Map<String, dynamic>> getUserStories(String userId,
      {String? viewerId}) async {
    try {
      String url = '$baseUrl/api/stories/user/$userId';
      if (viewerId != null && viewerId.isNotEmpty) {
        url += '?viewerId=$viewerId';
      }

      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        List<StoryModel> stories = [];
        final storiesList = data['stories'] as List? ?? [];

        for (var story in storiesList) {
          stories.add(StoryModel.fromJson(story, currentUserId: viewerId));
        }

        return {'success': true, 'stories': stories};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch user stories'
        };
      }
    } catch (e) {
      print('Error fetching user stories: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // View story (mark as viewed)
  Future<Map<String, dynamic>> viewStory(String storyId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/stories/$storyId/view'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'viewersCount': data['viewersCount']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to view story'
        };
      }
    } catch (e) {
      print('Error viewing story: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Like/Unlike story
  Future<Map<String, dynamic>> toggleLike(String storyId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/stories/$storyId/like'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      final data = json.decode(response.body);

      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response.body}");

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'liked': data['liked'],
          'likesCount': data['likesCount'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to like/unlike story'
        };
      }
    } catch (e) {
      print('Error toggling like: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Add comment to story
  Future<Map<String, dynamic>> addComment(
      String storyId, String userId, String text) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/stories/$storyId/comment'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'text': text,
        }),
      );

      final data = json.decode(response.body);

      print("ccccccccccccccccccccccccccccccccccc${response.body}");

      if (response.statusCode == 201 && data['success'] == true) {
        return {
          'success': true,
          'comment': data['comment'],
          'commentsCount': data['commentsCount'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add comment'
        };
      }
    } catch (e) {
      print('Error adding comment: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Delete story
  Future<Map<String, dynamic>> deleteStory(
      String storyId, String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/stories/$storyId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'message': data['message']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete story'
        };
      }
    } catch (e) {
      print('Error deleting story: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get my stories
  Future<Map<String, dynamic>> getMyStories(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/stories/my-stories/$userId'));
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        List<StoryModel> activeStories = [];
        List<StoryModel> expiredStories = [];

        for (var story in data['activeStories'] as List? ?? []) {
          activeStories.add(StoryModel.fromJson(story, currentUserId: userId));
        }

        for (var story in data['expiredStories'] as List? ?? []) {
          expiredStories.add(StoryModel.fromJson(story, currentUserId: userId));
        }

        return {
          'success': true,
          'activeStories': activeStories,
          'expiredStories': expiredStories,
          'activeCount': data['activeCount'] ?? 0,
          'totalCount': data['totalCount'] ?? 0,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch my stories'
        };
      }
    } catch (e) {
      print('Error fetching my stories: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
