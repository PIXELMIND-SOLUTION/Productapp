import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_app/Provider/story_provider.dart';
import 'package:product_app/model/story_model.dart';
import 'package:product_app/views/story/create_story_screen.dart';
import 'package:product_app/views/story/exo_video_player.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// Story Card Widget (Square/Rectangle instead of Circle)
class StoryCard extends StatelessWidget {
  final StoryGroup storyGroup;
  final VoidCallback onTap;
  final String currentUserId;
  final bool isCurrentUser;

  const StoryCard({
    super.key,
    required this.storyGroup,
    required this.onTap,
    required this.currentUserId,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnviewedStories =
        storyGroup.stories.any((story) => !story.isViewedByUser(currentUserId));

    final latestStory =
        storyGroup.stories.isNotEmpty ? storyGroup.stories.last : null;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: hasUnviewedStories && !isCurrentUser
                    ? const LinearGradient(
                        colors: [
                          Color(0xFFE33629),
                          Colors.purple,
                          Colors.orange
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: (!hasUnviewedStories || isCurrentUser)
                    ? Border.all(color: Colors.grey.shade300, width: 2)
                    : null,
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (latestStory != null)
                        latestStory.mediaType == 'video' &&
                                latestStory.thumbnailUrl != null
                            ? Image.network(
                                latestStory.thumbnailUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return _buildDefaultStoryImage(storyGroup);
                                },
                              )
                            : Image.network(
                                latestStory.mediaUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return _buildDefaultStoryImage(storyGroup);
                                },
                              )
                      else
                        _buildDefaultStoryImage(storyGroup),
                      if (isCurrentUser)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  'Add Story',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (hasUnviewedStories && !isCurrentUser)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE33629),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 90,
              child: Text(
                isCurrentUser ? 'Your Story' : storyGroup.userName,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultStoryImage(StoryGroup storyGroup) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: storyGroup.userProfileImage != null &&
                storyGroup.userProfileImage!.isNotEmpty
            ? Image.network(
                storyGroup.userProfileImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.person, size: 40, color: Colors.grey);
                },
              )
            : const Icon(Icons.person, size: 40, color: Colors.grey),
      ),
    );
  }
}

// Add Story Card (for users with no stories)
class AddStoryCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoryCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                color: Colors.grey.shade100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE33629),
                    ),
                    child: const Icon(Icons.add, size: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create Story',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE33629),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your Story',
              style: TextStyle(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Stories List Widget (Horizontal Scroll)
class StoriesListWidget extends StatelessWidget {
  final List<StoryGroup> storyGroups;
  final VoidCallback onAddStory;
  final Function(StoryGroup) onStoryTap;
  final String currentUserId;
  final StoryGroup? currentUserStories;

  const StoriesListWidget({
    super.key,
    required this.storyGroups,
    required this.onAddStory,
    required this.onStoryTap,
    required this.currentUserId,
    this.currentUserStories,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> storyWidgets = [];

    if (currentUserStories != null && currentUserStories!.stories.isNotEmpty) {
      storyWidgets.add(
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: StoryCard(
            storyGroup: currentUserStories!,
            currentUserId: currentUserId,
            isCurrentUser: true,
            onTap: () => onStoryTap(currentUserStories!),
          ),
        ),
      );
    } else {
      storyWidgets.add(
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: AddStoryCard(onTap: onAddStory),
        ),
      );
    }

    for (var group in storyGroups) {
      if (group.userId != currentUserId) {
        storyWidgets.add(
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: StoryCard(
              storyGroup: group,
              currentUserId: currentUserId,
              isCurrentUser: false,
              onTap: () => onStoryTap(group),
            ),
          ),
        );
      }
    }

    if (storyWidgets.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: storyWidgets,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Story Viewer Screen — reads live from Provider
// ─────────────────────────────────────────────
class StoryViewerScreen extends StatefulWidget {
  final List<StoryGroup> allStories;
  final int initialIndex;
  final String currentUserId;

  const StoryViewerScreen({
    super.key,
    required this.allStories,
    required this.initialIndex,
    required this.currentUserId,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  late PageController _pageController;
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;
  Timer? _progressTimer;
  double _progress = 0.0;
  bool _isLoading = true;
  bool _isPaused = false;

  // Comment input
  final TextEditingController _commentController = TextEditingController();
  bool _showCommentInput = false;
  bool _isPostingComment = false;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentUserIndex);
    _loadCurrentStory();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressTimer?.cancel();
    _commentController.dispose();
    super.dispose();
  }

  // Always read live story from provider, fall back to widget snapshot
  StoryModel get currentStory {
    final provider = Provider.of<StoryProvider>(context, listen: false);
    final liveGroups = provider.storyGroups;

    final originalGroup = widget.allStories[_currentUserIndex];
    try {
      final liveGroup =
          liveGroups.firstWhere((g) => g.userId == originalGroup.userId);
      if (_currentStoryIndex < liveGroup.stories.length) {
        return liveGroup.stories[_currentStoryIndex];
      }
    } catch (_) {}

    if (_currentStoryIndex < originalGroup.stories.length) {
      return originalGroup.stories[_currentStoryIndex];
    }
    return originalGroup.stories.first;
  }

  // Get live story group
  StoryGroup get currentGroup {
    final provider = Provider.of<StoryProvider>(context, listen: false);
    final originalGroup = widget.allStories[_currentUserIndex];
    try {
      return provider.storyGroups
          .firstWhere((g) => g.userId == originalGroup.userId);
    } catch (_) {
      return originalGroup;
    }
  }

  int get _currentGroupStoriesCount => currentGroup.stories.length;

  bool get isCurrentUserStory => currentStory.userId == widget.currentUserId;

  Future<void> _loadCurrentStory() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _isPaused = false;
    });
    _progressTimer?.cancel();

    final story = currentStory;

    if (story.userId != widget.currentUserId) {
      Provider.of<StoryProvider>(context, listen: false)
          .viewStory(story.id, widget.currentUserId);
    }

    if (story.mediaType == 'video') {
      if (mounted) {
        setState(() => _isLoading = false);
        _startProgressTimer(duration: 15.0);
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
        _startProgressTimer(duration: 10.0);
      }
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

  void _pauseTimer() {
    setState(() => _isPaused = true);
  }

  void _resumeTimer() {
    setState(() => _isPaused = false);
  }

  void _nextStory() {
    _progressTimer?.cancel();

    if (_currentStoryIndex + 1 < _currentGroupStoriesCount) {
      setState(() {
        _currentStoryIndex++;
        _progress = 0.0;
      });
      _loadCurrentStory();
    } else if (_currentUserIndex + 1 < widget.allStories.length) {
      setState(() {
        _currentUserIndex++;
        _currentStoryIndex = 0;
        _progress = 0.0;
      });
      _pageController.animateToPage(
        _currentUserIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadCurrentStory();
    } else {
      if (mounted) Navigator.pop(context);
    }
  }

  void _previousStory() {
    _progressTimer?.cancel();

    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _progress = 0.0;
      });
      _loadCurrentStory();
    } else if (_currentUserIndex > 0) {
      setState(() {
        _currentUserIndex--;
        _currentStoryIndex =
            widget.allStories[_currentUserIndex].stories.length - 1;
        _progress = 0.0;
      });
      _pageController.animateToPage(
        _currentUserIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadCurrentStory();
    }
  }

  Future<void> _toggleLike() async {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final story = currentStory;
    final isLiked = story.isLikedByUser(widget.currentUserId);

    await storyProvider.toggleLike(
      story.id,
      widget.currentUserId,
      isLiked,
    );
  }

  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isPostingComment = true);
    _resumeTimer();

    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final success = await storyProvider.addComment(
      currentStory.id,
      widget.currentUserId,
      text,
    );

    if (!mounted) return;
    setState(() {
      _isPostingComment = false;
      if (success) {
        _commentController.clear();
        _showCommentInput = false;
      }
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment added!'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add comment')),
      );
    }
  }

  Future<void> _deleteStory() async {
    _pauseTimer();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Story'),
        content: const Text('Are you sure you want to delete this story?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      _resumeTimer();
      return;
    }

    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final success = await storyProvider.deleteStory(
      currentStory.id,
      widget.currentUserId,
    );
    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story deleted')),
      );
    }
  }

  /// Shows a modern bottom modal sheet for comments with SafeArea and input at bottom
  Future<void> _showCommentsModal(StoryModel story) async {
    _pauseTimer();
    final commentTextController = TextEditingController();
    bool isPosting = false;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return Consumer<StoryProvider>(
              builder: (context, provider, _) {
                // Get live story data
                StoryModel liveStory = story;
                try {
                  final liveGroup = provider.storyGroups
                      .firstWhere((g) => g.userId == story.userId);
                  liveStory =
                      liveGroup.stories.firstWhere((s) => s.id == story.id);
                } catch (_) {}

                return SafeArea(
                  child: Container(
                    height: MediaQuery.of(modalContext).size.height * 0.8,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(modalContext).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Comments',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: Colors.grey, height: 32),
                        // Comments list
                        Expanded(
                          child: liveStory.comments.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.chat_bubble_outline,
                                          color: Colors.grey, size: 48),
                                      SizedBox(height: 12),
                                      Text(
                                        'No comments yet',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Be the first to comment!',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  itemCount: liveStory.comments.length,
                                  itemBuilder: (context, index) {
                                    final comment = liveStory.comments[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: comment
                                                        .userProfileImage !=
                                                    null
                                                ? NetworkImage(
                                                    comment.userProfileImage!)
                                                : null,
                                            child:
                                                comment.userProfileImage == null
                                                    ? const Icon(Icons.person,
                                                        size: 20)
                                                    : null,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      comment.userName,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      _formatTime(
                                                          comment.createdAt),
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  comment.text,
                                                  style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (comment.userId ==
                                              widget.currentUserId)
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.grey,
                                                  size: 20),
                                              onPressed: () async {
                                                Navigator.pop(modalContext);
                                                await _deleteComment(
                                                    liveStory.id, comment.id);
                                                _resumeTimer();
                                                _showCommentsModal(liveStory);
                                              },
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        // Comment input at bottom
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            border: Border(
                              top: BorderSide(color: Colors.grey[800]!),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2C2C2C),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: TextField(
                                    controller: commentTextController,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    decoration: const InputDecoration(
                                      hintText: 'Add a comment...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                    onSubmitted: (_) async {
                                      final text =
                                          commentTextController.text.trim();
                                      if (text.isEmpty) return;
                                      setModalState(() => isPosting = true);
                                      final storyProvider =
                                          Provider.of<StoryProvider>(context,
                                              listen: false);
                                      final success =
                                          await storyProvider.addComment(
                                        liveStory.id,
                                        widget.currentUserId,
                                        text,
                                      );
                                      if (success && mounted) {
                                        commentTextController.clear();
                                        setModalState(() => isPosting = false);
                                      } else {
                                        setModalState(() => isPosting = false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Failed to add comment')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              isPosting
                                  ? const SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xFFE33629),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        final text =
                                            commentTextController.text.trim();
                                        if (text.isEmpty) return;
                                        setModalState(() => isPosting = true);
                                        final storyProvider =
                                            Provider.of<StoryProvider>(context,
                                                listen: false);
                                        final success =
                                            await storyProvider.addComment(
                                          liveStory.id,
                                          widget.currentUserId,
                                          text,
                                        );
                                        if (success) {
                                          commentTextController.clear();
                                          setModalState(
                                              () => isPosting = false);
                                        } else {
                                          setModalState(
                                              () => isPosting = false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Failed to add comment')),
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE33629),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: const Text(
                                          'Post',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      _resumeTimer();
    });
  }

  Future<void> _deleteComment(String storyId, String commentId) async {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final success = await storyProvider.deleteComment(
      storyId,
      commentId,
      widget.currentUserId,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment deleted'),
          duration: Duration(seconds: 1),
        ),
      );
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
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, _) {
        final story = currentStory;
        final group = currentGroup;

        return SafeArea(
          child: Scaffold(
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
                  // ── Media Display ──
                  Positioned.fill(
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : story.mediaType == 'video'
                            ? ExoVideoPlayer(
                                key: ValueKey('${story.id}_${_isPaused}'),
                                url: story.mediaUrl,
                                autoPlay: !_isPaused,
                              )
                            : Image.network(
                                story.mediaUrl,
                                fit: BoxFit.contain,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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

                  // ── Progress Bars ──
                  Positioned(
                    top: 40,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: List.generate(
                        _currentGroupStoriesCount,
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
                                if (index < _currentStoryIndex)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                if (index == _currentStoryIndex)
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

                  // ── User Info ──
                  Positioned(
                    top: 50,
                    left: 16,
                    child: Row(
                      children: [
                        ClipOval(
                          child: group.userProfileImage != null
                              ? Image.network(
                                  group.userProfileImage!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return _defaultAvatar();
                                  },
                                )
                              : _defaultAvatar(),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCurrentUserStory
                                  ? 'Your Story'
                                  : group.userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatTime(story.createdAt),
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

                  // ── Close Button ──
                  Positioned(
                    top: 50,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // ── Add Story Button (own stories) ──
                  if (isCurrentUserStory)
                    Positioned(
                      top: 50,
                      right: 70,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateStoryScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE33629),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 18),
                              SizedBox(width: 4),
                              Text(
                                'Add Story',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // ── Delete Button (own stories) ──
                  if (isCurrentUserStory)
                    Positioned(
                      top: 50,
                      right: 180,
                      child: IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.white),
                        onPressed: _deleteStory,
                      ),
                    ),

                  // ── Caption ──
                  // right: 72 leaves room for the vertical action column
                  if (story.caption != null &&
                      story.caption!.isNotEmpty &&
                      !_showCommentInput)
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 72,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          story.caption!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                  // ── Bottom-Right Vertical Action Bar (Like, Comment, Share) ──
                  if (!isCurrentUserStory)
                    Positioned(
                      right: 16,
                      bottom: 110,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Like Button
                          GestureDetector(
                            onTap: _toggleLike,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                  child: Icon(
                                    story.isLikedByUser(widget.currentUserId)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: story
                                            .isLikedByUser(widget.currentUserId)
                                        ? Colors.red
                                        : Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCount(story.likesCount),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Comment Button
                          GestureDetector(
                            onTap: () => _showCommentsModal(story),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                  child: const Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCount(story.commentsCount),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Share Button
                          GestureDetector(
                            onTap: () async {
                              _pauseTimer();
                              await Share.share(
                                story.mediaUrl,
                                subject:
                                    story.caption ?? 'Check out this story!',
                              );
                              _resumeTimer();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                  child: const Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Share',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── View Comments quick-action pill ──
                  // if (!isCurrentUserStory &&
                  //     story.commentsCount > 0 &&
                  //     !_showCommentInput)
                  //   Positioned(
                  //     bottom: 100,
                  //     left: 16,
                  //     child: GestureDetector(
                  //       onTap: () => _showCommentsModal(story),
                  //       child: Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 12, vertical: 6),
                  //         decoration: BoxDecoration(
                  //           color: Colors.black.withOpacity(0.5),
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         child: Text(
                  //           'View all ${_formatCount(story.commentsCount)} comments',
                  //           style: const TextStyle(
                  //               color: Colors.white, fontSize: 12),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
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

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
