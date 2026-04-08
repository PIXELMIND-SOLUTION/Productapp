import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_app/Provider/story_provider.dart';
import 'package:product_app/model/story_model.dart';
import 'package:product_app/views/story/exo_video_player.dart';
import 'package:provider/provider.dart';

import 'package:share_plus/share_plus.dart';

class UserStoriesScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String? userProfileImage;

  const UserStoriesScreen({
    Key? key,
    required this.userId,
    required this.userName,
    this.userProfileImage,
  }) : super(key: key);

  @override
  State<UserStoriesScreen> createState() => _UserStoriesScreenState();
}

class _UserStoriesScreenState extends State<UserStoriesScreen> {
  List<StoryModel> _allStories = [];
  List<StoryModel> _activeStories = [];
  List<StoryModel> _expiredStories = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Story viewer state
  int _currentStoryIndex = 0;
  bool _isViewerOpen = false;

  @override
  void initState() {
    super.initState();
    _loadAllStories();
  }

  Future<void> _loadAllStories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final storyProvider = Provider.of<StoryProvider>(context, listen: false);

    // You need to add this method to your StoryService and StoryProvider
    // For now, we'll fetch using existing methods and combine
    try {
      // Fetch user stories (this only gives active ones normally)
      // You'll need to add a new API endpoint or modify existing one
      // For now, let's assume you added getAllUserStories to provider

      // Temporary: Use fetchUserStories and also get expired from somewhere
      final success = await storyProvider.fetchUserStories(widget.userId);

      if (success) {
        // This only gives active stories, you need to modify your backend
        // to return all stories for profile view
        setState(() {
          _allStories = storyProvider.userStories;
          _separateStories();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              storyProvider.errorMessage ?? 'Failed to load stories';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _separateStories() {
    _activeStories = _allStories.where((story) {
      final now = DateTime.now();
      final difference = now.difference(story.createdAt);
      return story.isActive && difference.inHours < 24;
    }).toList();

    _expiredStories = _allStories.where((story) {
      final now = DateTime.now();
      final difference = now.difference(story.createdAt);
      return !story.isActive || difference.inHours >= 24;
    }).toList();
  }

  void _openStoryViewer(int index) {
    setState(() {
      _currentStoryIndex = index;
      _isViewerOpen = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserStoryViewerScreen(
          stories: _allStories,
          initialIndex: index,
          currentUserId: widget.userId,
          userName: widget.userName,
          userProfileImage: widget.userProfileImage,
        ),
      ),
    ).then((_) {
      setState(() {
        _isViewerOpen = false;
      });
      _loadAllStories(); // Refresh after returning
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadAllStories,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white54, size: 64),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadAllStories,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE33629),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_allStories.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, color: Colors.white54, size: 64),
            SizedBox(height: 16),
            Text(
              'No stories yet',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        // Stats header
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  _allStories.length.toString(),
                  'Total Stories',
                  Icons.person,
                ),
                _buildStatItem(
                  _activeStories.length.toString(),
                  'Active',
                  Icons.circle,
                  color: Colors.green,
                ),
                _buildStatItem(
                  _expiredStories.length.toString(),
                  'Expired',
                  Icons.timer_off,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),

        // Active Stories Section
        if (_activeStories.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader(
                'Active Stories', Icons.circle, Colors.green),
          ),
        if (_activeStories.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildStoryCard(
                    _activeStories[index], index,
                    isActive: true),
                childCount: _activeStories.length,
              ),
            ),
          ),

        // Expired Stories Section
        if (_expiredStories.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader(
                'Expired Stories', Icons.timer_off, Colors.grey),
          ),
        if (_expiredStories.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildStoryCard(
                    _expiredStories[index], _activeStories.length + index,
                    isActive: false),
                childCount: _expiredStories.length,
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon,
      {Color? color}) {
    return Column(
      children: [
        Icon(icon, color: color ?? const Color(0xFFE33629), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            title == 'Active Stories'
                ? '${_activeStories.length}'
                : '${_expiredStories.length}',
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard(StoryModel story, int index,
      {required bool isActive}) {
    return GestureDetector(
      onTap: () => _openStoryViewer(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              !isActive ? Border.all(color: Colors.grey[800]!, width: 1) : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: story.mediaType == 'video' && story.thumbnailUrl != null
                  ? Image.network(
                      story.thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _buildDefaultThumbnail(story),
                    )
                  : Image.network(
                      story.mediaUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _buildDefaultThumbnail(story),
                    ),
            ),

            // Media type indicator
            if (story.mediaType == 'video')
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.videocam,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),

            // Expired overlay
            if (!isActive)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.timer_off,
                    color: Colors.white70,
                    size: 32,
                  ),
                ),
              ),

            // Duration indicator
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(story.createdAt),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultThumbnail(StoryModel story) {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Icon(Icons.image, color: Colors.grey, size: 40),
      ),
    );
  }

  String _formatDuration(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// User Story Viewer Screen (similar to your existing but for profile viewing)
class UserStoryViewerScreen extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;
  final String currentUserId;
  final String userName;
  final String? userProfileImage;

  const UserStoryViewerScreen({
    Key? key,
    required this.stories,
    required this.initialIndex,
    required this.currentUserId,
    required this.userName,
    this.userProfileImage,
  }) : super(key: key);

  @override
  State<UserStoryViewerScreen> createState() => _UserStoryViewerScreenState();
}

class _UserStoryViewerScreenState extends State<UserStoryViewerScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _progressTimer;
  double _progress = 0.0;
  bool _isLoading = true;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _loadCurrentStory();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  StoryModel get currentStory => widget.stories[_currentIndex];

  void _loadCurrentStory() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _isPaused = false;
    });
    _progressTimer?.cancel();

    if (currentStory.mediaType == 'video') {
      setState(() => _isLoading = false);
      _startProgressTimer(duration: 15.0);
    } else {
      setState(() => _isLoading = false);
      _startProgressTimer(duration: 10.0);
    }
  }

  void _startProgressTimer({double duration = 10.0}) {
    _progressTimer?.cancel();
    _progress = 0.0;
    final increment = 0.1 / duration;

    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted || _isPaused) return;
      setState(() {
        _progress += increment;
        if (_progress >= 1.0) {
          _nextStory();
        }
      });
    });
  }

  void _pauseTimer() => setState(() => _isPaused = true);
  void _resumeTimer() => setState(() => _isPaused = false);

  void _nextStory() {
    _progressTimer?.cancel();
    if (_currentIndex + 1 < widget.stories.length) {
      setState(() {
        _currentIndex++;
        _progress = 0.0;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadCurrentStory();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    _progressTimer?.cancel();
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _progress = 0.0;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadCurrentStory();
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.localPosition.dx < width / 3) {
            _previousStory();
          } else if (details.localPosition.dx > width * 2 / 3) {
            _nextStory();
          }
        },
        onLongPressStart: (_) => _pauseTimer(),
        onLongPressEnd: (_) => _resumeTimer(),
        child: Stack(
          children: [
            // Media Display
            Positioned.fill(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : currentStory.mediaType == 'video'
                      ? ExoVideoPlayer(
                          key: ValueKey('${currentStory.id}_$_isPaused'),
                          url: currentStory.mediaUrl,
                          autoPlay: !_isPaused,
                        )
                      : Image.network(
                          currentStory.mediaUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            );
                          },
                          errorBuilder: (_, __, ___) {
                            return const Center(
                              child: Icon(Icons.error,
                                  color: Colors.white, size: 50),
                            );
                          },
                        ),
            ),

            // Progress Bars
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(
                  widget.stories.length,
                  (index) => Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Stack(
                        children: [
                          if (index < _currentIndex)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          if (index == _currentIndex)
                            FractionallySizedBox(
                              widthFactor: _progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // User Info
            Positioned(
              top: 50,
              left: 16,
              child: Row(
                children: [
                  ClipOval(
                    child: widget.userProfileImage != null
                        ? Image.network(
                            widget.userProfileImage!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _defaultAvatar(),
                          )
                        : _defaultAvatar(),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatTime(currentStory.createdAt),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Close Button
            Positioned(
              top: 50,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Caption
            if (currentStory.caption != null &&
                currentStory.caption!.isNotEmpty)
              Positioned(
                bottom: 40,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    currentStory.caption!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: 40,
      height: 40,
      color: Colors.grey,
      child: const Icon(Icons.person, color: Colors.white),
    );
  }
}
