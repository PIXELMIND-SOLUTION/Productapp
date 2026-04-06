// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/story_provider.dart';
// import 'package:product_app/model/story_model.dart';
// import 'package:video_player/video_player.dart';
// import 'package:provider/provider.dart';

// // Story Card Widget (Square/Rectangle instead of Circle)
// class StoryCard extends StatelessWidget {
//   final StoryGroup storyGroup;
//   final VoidCallback onTap;
//   final String currentUserId;
//   final bool isCurrentUser;

//   const StoryCard({
//     super.key,
//     required this.storyGroup,
//     required this.onTap,
//     required this.currentUserId,
//     this.isCurrentUser = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasUnviewedStories =
//         storyGroup.stories.any((story) => !story.isViewedByUser(currentUserId));

//     final latestStory =
//         storyGroup.stories.isNotEmpty ? storyGroup.stories.last : null;

//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         width: 100,
//         child: Column(
//           children: [
//             Container(
//               width: 90,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: hasUnviewedStories && !isCurrentUser
//                     ? const LinearGradient(
//                         colors: [
//                           Color(0xFFE33629),
//                           Colors.purple,
//                           Colors.orange
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       )
//                     : null,
//                 border: (!hasUnviewedStories || isCurrentUser)
//                     ? Border.all(color: Colors.grey.shade300, width: 2)
//                     : null,
//               ),
//               child: Container(
//                 margin: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       if (latestStory != null)
//                         latestStory.mediaType == 'video' &&
//                                 latestStory.thumbnailUrl != null
//                             ? Image.network(
//                                 latestStory.thumbnailUrl!,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) {
//                                   return _buildDefaultStoryImage(storyGroup);
//                                 },
//                               )
//                             : Image.network(
//                                 latestStory.mediaUrl,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) {
//                                   return _buildDefaultStoryImage(storyGroup);
//                                 },
//                               )
//                       else
//                         _buildDefaultStoryImage(storyGroup),
//                       if (isCurrentUser)
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   Colors.black.withOpacity(0.7),
//                                 ],
//                               ),
//                             ),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.add_circle,
//                                     color: Colors.white, size: 20),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   'Add Story',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       if (hasUnviewedStories && !isCurrentUser)
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: Container(
//                             width: 10,
//                             height: 10,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFE33629),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             SizedBox(
//               width: 90,
//               child: Text(
//                 isCurrentUser ? 'Your Story' : storyGroup.userName,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDefaultStoryImage(StoryGroup storyGroup) {
//     return Container(
//       color: Colors.grey.shade200,
//       child: Center(
//         child: storyGroup.userProfileImage != null &&
//                 storyGroup.userProfileImage!.isNotEmpty
//             ? Image.network(
//                 storyGroup.userProfileImage!,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) {
//                   return const Icon(Icons.person, size: 40, color: Colors.grey);
//                 },
//               )
//             : const Icon(Icons.person, size: 40, color: Colors.grey),
//       ),
//     );
//   }
// }

// // Add Story Card (for users with no stories)
// class AddStoryCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const AddStoryCard({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         width: 100,
//         child: Column(
//           children: [
//             Container(
//               width: 90,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300, width: 2),
//                 color: Colors.grey.shade100,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color(0xFFE33629),
//                     ),
//                     child: const Icon(Icons.add, size: 30, color: Colors.white),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Create Story',
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFFE33629),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               'Your Story',
//               style: TextStyle(fontSize: 11),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Stories List Widget (Horizontal Scroll)
// class StoriesListWidget extends StatelessWidget {
//   final List<StoryGroup> storyGroups;
//   final VoidCallback onAddStory;
//   final Function(StoryGroup) onStoryTap;
//   final String currentUserId;
//   final StoryGroup? currentUserStories;

//   const StoriesListWidget({
//     super.key,
//     required this.storyGroups,
//     required this.onAddStory,
//     required this.onStoryTap,
//     required this.currentUserId,
//     this.currentUserStories,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> storyWidgets = [];

//     if (currentUserStories != null && currentUserStories!.stories.isNotEmpty) {
//       storyWidgets.add(
//         Padding(
//           padding: const EdgeInsets.only(right: 12),
//           child: StoryCard(
//             storyGroup: currentUserStories!,
//             currentUserId: currentUserId,
//             isCurrentUser: true,
//             onTap: () => onStoryTap(currentUserStories!),
//           ),
//         ),
//       );
//     } else {
//       storyWidgets.add(
//         Padding(
//           padding: const EdgeInsets.only(right: 12),
//           child: AddStoryCard(onTap: onAddStory),
//         ),
//       );
//     }

//     for (var group in storyGroups) {
//       if (group.userId != currentUserId) {
//         storyWidgets.add(
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: StoryCard(
//               storyGroup: group,
//               currentUserId: currentUserId,
//               isCurrentUser: false,
//               onTap: () => onStoryTap(group),
//             ),
//           ),
//         );
//       }
//     }

//     if (storyWidgets.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return SizedBox(
//       height: 150,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         children: storyWidgets,
//       ),
//     );
//   }
// }

// // Story Viewer Screen with Like, Comment, Delete
// class StoryViewerScreen extends StatefulWidget {
//   final List<StoryGroup> allStories;
//   final int initialIndex;
//   final String currentUserId;

//   const StoryViewerScreen({
//     super.key,
//     required this.allStories,
//     required this.initialIndex,
//     required this.currentUserId,
//   });

//   @override
//   State<StoryViewerScreen> createState() => _StoryViewerScreenState();
// }

// class _StoryViewerScreenState extends State<StoryViewerScreen> {
//   late PageController _pageController;
//   int _currentUserIndex = 0;
//   int _currentStoryIndex = 0;
//   VideoPlayerController? _videoController;
//   Timer? _progressTimer;
//   double _progress = 0.0;
//   bool _isLoading = true;

//   // Comment input
//   final TextEditingController _commentController = TextEditingController();
//   final FocusNode _commentFocusNode = FocusNode();
//   bool _showCommentInput = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: _currentUserIndex);
//     _loadCurrentStory();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _progressTimer?.cancel();
//     _videoController?.dispose();
//     _commentController.dispose();
//     _commentFocusNode.dispose();
//     super.dispose();
//   }

//   StoryModel get currentStory =>
//       widget.allStories[_currentUserIndex].stories[_currentStoryIndex];

//   bool get isCurrentUserStory => currentStory.userId == widget.currentUserId;

//   Future<void> _loadCurrentStory() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final stories = widget.allStories[_currentUserIndex].stories;
//     if (_currentStoryIndex < stories.length) {
//       final story = stories[_currentStoryIndex];

//       if (story.userId != widget.currentUserId) {
//         await Provider.of<StoryProvider>(context, listen: false)
//             .viewStory(story.id, widget.currentUserId);
//       }

//       if (story.mediaType == 'video') {
//         _videoController?.dispose();
//         _videoController =
//             VideoPlayerController.networkUrl(Uri.parse(story.mediaUrl));
//         await _videoController!.initialize();
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//           _videoController!.play();
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//       }

//       _startProgressTimer();
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _startProgressTimer() {
//     _progressTimer?.cancel();
//     _progress = 0.0;
//     const duration = Duration(seconds: 10);

//     _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       if (mounted) {
//         setState(() {
//           _progress += 0.01;
//           if (_progress >= 1.0) {
//             _nextStory();
//           }
//         });
//       }
//     });
//   }

//   void _nextStory() {
//     final currentUserStories = widget.allStories[_currentUserIndex].stories;

//     if (_currentStoryIndex + 1 < currentUserStories.length) {
//       setState(() {
//         _currentStoryIndex++;
//         _progress = 0.0;
//       });
//       _loadCurrentStory();
//     } else if (_currentUserIndex + 1 < widget.allStories.length) {
//       setState(() {
//         _currentUserIndex++;
//         _currentStoryIndex = 0;
//         _progress = 0.0;
//       });
//       _pageController.animateToPage(
//         _currentUserIndex,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       _loadCurrentStory();
//     } else {
//       if (mounted) {
//         Navigator.pop(context);
//       }
//     }
//   }

//   void _previousStory() {
//     if (_currentStoryIndex > 0) {
//       setState(() {
//         _currentStoryIndex--;
//         _progress = 0.0;
//       });
//       _loadCurrentStory();
//     } else if (_currentUserIndex > 0) {
//       setState(() {
//         _currentUserIndex--;
//         _currentStoryIndex =
//             widget.allStories[_currentUserIndex].stories.length - 1;
//         _progress = 0.0;
//       });
//       _pageController.animateToPage(
//         _currentUserIndex,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       _loadCurrentStory();
//     }
//   }

//   Future<void> _toggleLike() async {
//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//     final isLiked = currentStory.isLikedByUser(widget.currentUserId);

//     final success = await storyProvider.toggleLike(
//       currentStory.id,
//       widget.currentUserId,
//       isLiked,
//     );

//     if (success && mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> _addComment() async {
//     if (_commentController.text.trim().isEmpty) return;

//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//     final success = await storyProvider.addComment(
//       currentStory.id,
//       widget.currentUserId,
//       _commentController.text.trim(),
//     );

//     if (success && mounted) {
//       _commentController.clear();
//       setState(() {
//         _showCommentInput = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Comment added!')),
//       );
//     }
//   }

//   Future<void> _deleteStory() async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Story'),
//         content: const Text('Are you sure you want to delete this story?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               final storyProvider =
//                   Provider.of<StoryProvider>(context, listen: false);
//               final success = await storyProvider.deleteStory(
//                 currentStory.id,
//                 widget.currentUserId,
//               );
//               if (success && mounted) {
//                 Navigator.pop(context); // Close viewer
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Story deleted')),
//                 );
//               }
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTapDown: (details) {
//           final width = MediaQuery.of(context).size.width;
//           if (details.localPosition.dx < width / 3) {
//             _previousStory();
//           } else if (details.localPosition.dx > width * 2 / 3) {
//             _nextStory();
//           }
//         },
//         child: Stack(
//           children: [
//             // Media Display
//             Positioned.fill(
//               child: _isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(color: Colors.white))
//                   : currentStory.mediaType == 'video' &&
//                           _videoController != null &&
//                           _videoController!.value.isInitialized
//                       ? VideoPlayer(_videoController!)
//                       : Image.network(
//                           currentStory.mediaUrl,
//                           fit: BoxFit.contain,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                   color: Colors.white),
//                             );
//                           },
//                           errorBuilder: (_, __, ___) {
//                             return const Center(
//                               child: Icon(Icons.error,
//                                   color: Colors.white, size: 50),
//                             );
//                           },
//                         ),
//             ),

//             // Progress Bars
//             Positioned(
//               top: 40,
//               left: 16,
//               right: 16,
//               child: Row(
//                 children: List.generate(
//                   widget.allStories[_currentUserIndex].stories.length,
//                   (index) => Expanded(
//                     child: Container(
//                       height: 2,
//                       margin: const EdgeInsets.symmetric(horizontal: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                       child: Stack(
//                         children: [
//                           if (index < _currentStoryIndex)
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                           if (index == _currentStoryIndex)
//                             AnimatedContainer(
//                               duration: const Duration(milliseconds: 100),
//                               width: MediaQuery.of(context).size.width *
//                                   _progress /
//                                   widget.allStories[_currentUserIndex].stories
//                                       .length,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // User Info
//             Positioned(
//               top: 50,
//               left: 16,
//               child: Row(
//                 children: [
//                   ClipOval(
//                     child:
//                         widget.allStories[_currentUserIndex].userProfileImage !=
//                                 null
//                             ? Image.network(
//                                 widget.allStories[_currentUserIndex]
//                                     .userProfileImage!,
//                                 width: 40,
//                                 height: 40,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) {
//                                   return Container(
//                                     width: 40,
//                                     height: 40,
//                                     color: Colors.grey,
//                                     child: const Icon(Icons.person),
//                                   );
//                                 },
//                               )
//                             : Container(
//                                 width: 40,
//                                 height: 40,
//                                 color: Colors.grey,
//                                 child: const Icon(Icons.person),
//                               ),
//                   ),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         isCurrentUserStory
//                             ? 'Your Story'
//                             : widget.allStories[_currentUserIndex].userName,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _formatTime(currentStory.createdAt),
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Close Button
//             Positioned(
//               top: 50,
//               right: 16,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.white),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),

//             // Delete Button (for own stories)
//             if (isCurrentUserStory)
//               Positioned(
//                 top: 50,
//                 right: 70,
//                 child: IconButton(
//                   icon: const Icon(Icons.delete_outline, color: Colors.white),
//                   onPressed: _deleteStory,
//                 ),
//               ),

//             // Like, Comment, Share Buttons at bottom
//             if (!isCurrentUserStory)
//               Positioned(
//                 bottom: 30,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Like Button
//                       GestureDetector(
//                         onTap: _toggleLike,
//                         child: Column(
//                           children: [
//                             Icon(
//                               currentStory.isLikedByUser(widget.currentUserId)
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: currentStory
//                                       .isLikedByUser(widget.currentUserId)
//                                   ? Colors.red
//                                   : Colors.white,
//                               size: 28,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '${currentStory.likesCount}',
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 11),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 40),

//                       // Comment Button
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _showCommentInput = !_showCommentInput;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             const Icon(Icons.comment_outlined,
//                                 color: Colors.white, size: 28),
//                             const SizedBox(height: 4),
//                             Text(
//                               '${currentStory.commentsCount}',
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 11),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 40),

//                       // Share Button
//                       GestureDetector(
//                         onTap: () {
//                           // Share story
//                         },
//                         child: const Column(
//                           children: [
//                             Icon(Icons.share_outlined,
//                                 color: Colors.white, size: 28),
//                             SizedBox(height: 4),
//                             Text('Share',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 11)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             // Comment Input
//             if (_showCommentInput && !isCurrentUserStory)
//               Positioned(
//                 bottom: 100,
//                 left: 16,
//                 right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _commentController,
//                           focusNode: _commentFocusNode,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: const InputDecoration(
//                             hintText: 'Add a comment...',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: InputBorder.none,
//                           ),
//                           autofocus: true,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: _addComment,
//                         child: const Text('Post',
//                             style: TextStyle(color: Color(0xFFE33629))),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             // View Comments Button
//             if (!isCurrentUserStory &&
//                 currentStory.commentsCount > 0 &&
//                 !_showCommentInput)
//               Positioned(
//                 bottom: 100,
//                 left: 16,
//                 child: GestureDetector(
//                   onTap: () {
//                     _showCommentsDialog();
//                   },
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       'View all ${currentStory.commentsCount} comments',
//                       style: const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ),

//             // Add Story Button for current user's own stories
//             if (isCurrentUserStory)
//               Positioned(
//                 bottom: 40,
//                 left: 16,
//                 right: 16,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     // Navigate to create story - this should be handled by parent
//                   },
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   label: const Text('Add New Story'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFE33629),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),

//             // Caption
//             if (currentStory.caption != null &&
//                 currentStory.caption!.isNotEmpty &&
//                 !isCurrentUserStory)
//               Positioned(
//                 bottom: 100,
//                 left: 16,
//                 right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     currentStory.caption!,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCommentsDialog() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.black,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Container(
//               width: 50,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Comments',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             const Divider(color: Colors.grey),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: currentStory.comments.length,
//                 itemBuilder: (context, index) {
//                   final comment = currentStory.comments[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 16,
//                           backgroundImage: comment.userProfileImage != null
//                               ? NetworkImage(comment.userProfileImage!)
//                               : null,
//                           child: comment.userProfileImage == null
//                               ? const Icon(Icons.person, size: 16)
//                               : null,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 comment.userName,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 comment.text,
//                                 style: const TextStyle(
//                                     color: Colors.white70, fontSize: 12),
//                               ),
//                               Text(
//                                 _formatTime(comment.createdAt),
//                                 style: const TextStyle(
//                                     color: Colors.grey, fontSize: 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (comment.userId == widget.currentUserId)
//                           IconButton(
//                             icon: const Icon(Icons.delete_outline,
//                                 color: Colors.grey, size: 18),
//                             onPressed: () {
//                               // Delete comment
//                               Navigator.pop(context);
//                               _deleteComment(comment.id);
//                             },
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteComment(String commentId) async {
//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//     final success = await storyProvider.deleteComment(
//       currentStory.id,
//       commentId,
//       widget.currentUserId,
//     );

//     if (success && mounted) {
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Comment deleted')),
//       );
//     }
//   }

//   String _formatTime(DateTime time) {
//     final now = DateTime.now();
//     final diff = now.difference(time);

//     if (diff.inMinutes < 1) return 'Just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     return '${diff.inDays}d ago';
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_app/Provider/story_provider.dart';
import 'package:product_app/model/story_model.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

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
  VideoPlayerController? _videoController;
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
    _videoController?.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // ✅ Always read live story from provider, fall back to widget snapshot
  StoryModel get currentStory {
    final provider = Provider.of<StoryProvider>(context, listen: false);
    final liveGroups = provider.storyGroups;

    // Try to find the group by userId from the original snapshot
    final originalGroup = widget.allStories[_currentUserIndex];
    try {
      final liveGroup =
          liveGroups.firstWhere((g) => g.userId == originalGroup.userId);
      if (_currentStoryIndex < liveGroup.stories.length) {
        return liveGroup.stories[_currentStoryIndex];
      }
    } catch (_) {}

    // Fallback to snapshot
    if (_currentStoryIndex < originalGroup.stories.length) {
      return originalGroup.stories[_currentStoryIndex];
    }
    return originalGroup.stories.first;
  }

  // ✅ Get live story group
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

  // ✅ Get total stories count from live data
  int get _currentGroupStoriesCount {
    return currentGroup.stories.length;
  }

  bool get isCurrentUserStory => currentStory.userId == widget.currentUserId;

  Future<void> _loadCurrentStory() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _isPaused = false;
    });
    _progressTimer?.cancel();

    final story = currentStory;

    // Mark as viewed
    if (story.userId != widget.currentUserId) {
      Provider.of<StoryProvider>(context, listen: false)
          .viewStory(story.id, widget.currentUserId);
    }

    if (story.mediaType == 'video') {
      _videoController?.dispose();
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(story.mediaUrl));
      try {
        await _videoController!.initialize();
        if (mounted) {
          setState(() => _isLoading = false);
          _videoController!.play();
          _startProgressTimer(
              duration: _videoController!.value.duration.inSeconds
                  .clamp(5, 30)
                  .toDouble());
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          _startProgressTimer();
        }
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
        _startProgressTimer();
      }
    }
  }

  void _startProgressTimer({double duration = 10.0}) {
    _progressTimer?.cancel();
    _progress = 0.0;
    final increment = 0.1 / duration; // 100ms tick

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
    _videoController?.pause();
  }

  void _resumeTimer() {
    setState(() => _isPaused = false);
    if (currentStory.mediaType == 'video') {
      _videoController?.play();
    }
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
    // Read current liked state from live story
    final story = currentStory;
    final isLiked = story.isLikedByUser(widget.currentUserId);

    // Optimistic update happens inside provider — UI rebuilds via Consumer
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
    _resumeTimer(); // resume before async

    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final success = await storyProvider.addComment(
      currentStory.id,
      widget.currentUserId, // ✅ FIX: was missing userId
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

  @override
  Widget build(BuildContext context) {
    // ✅ Consumer so UI rebuilds on any provider change (likes, comments, etc.)
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, _) {
        final story = currentStory;
        final group = currentGroup;

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
                // ── Media Display ──
                Positioned.fill(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : story.mediaType == 'video' &&
                              _videoController != null &&
                              _videoController!.value.isInitialized
                          ? VideoPlayer(_videoController!)
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
                            isCurrentUserStory ? 'Your Story' : group.userName,
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

                // ── Delete Button (own stories) ──
                if (isCurrentUserStory)
                  Positioned(
                    top: 50,
                    right: 70,
                    child: IconButton(
                      icon:
                          const Icon(Icons.delete_outline, color: Colors.white),
                      onPressed: _deleteStory,
                    ),
                  ),

                // ── Caption ──
                if (story.caption != null &&
                    story.caption!.isNotEmpty &&
                    !_showCommentInput)
                  Positioned(
                    bottom: isCurrentUserStory ? 100 : 150,
                    left: 16,
                    right: 16,
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

                // ── Like / Comment / Share (other users' stories) ──
                if (!isCurrentUserStory)
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Like
                          GestureDetector(
                            onTap: _toggleLike,
                            child: Column(
                              children: [
                                Icon(
                                  story.isLikedByUser(widget.currentUserId)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      story.isLikedByUser(widget.currentUserId)
                                          ? Colors.red
                                          : Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${story.likesCount}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),

                          // Comment
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showCommentInput = !_showCommentInput;
                              });
                              if (_showCommentInput) {
                                _pauseTimer();
                              } else {
                                _resumeTimer();
                              }
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.comment_outlined,
                                    color: Colors.white, size: 28),
                                const SizedBox(height: 4),
                                Text(
                                  '${story.commentsCount}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),

                          // Share
                          GestureDetector(
                            onTap: () {},
                            child: const Column(
                              children: [
                                Icon(Icons.share_outlined,
                                    color: Colors.white, size: 28),
                                SizedBox(height: 4),
                                Text('Share',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── View Comments Button ──
                if (!isCurrentUserStory &&
                    story.commentsCount > 0 &&
                    !_showCommentInput)
                  Positioned(
                    bottom: 100,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        _pauseTimer();
                        _showCommentsDialog(story).then((_) => _resumeTimer());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'View all ${story.commentsCount} comments',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),

                // ── Comment Input ──
                if (_showCommentInput && !isCurrentUserStory)
                  Positioned(
                    bottom: 100,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Add a comment...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              autofocus: true,
                              onSubmitted: (_) => _addComment(),
                            ),
                          ),
                          _isPostingComment
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFE33629),
                                  ),
                                )
                              : TextButton(
                                  onPressed: _addComment,
                                  child: const Text('Post',
                                      style:
                                          TextStyle(color: Color(0xFFE33629))),
                                ),
                        ],
                      ),
                    ),
                  ),

                // ── Add New Story Button (own stories) ──
                if (isCurrentUserStory)
                  Positioned(
                    bottom: 40,
                    left: 16,
                    right: 16,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Add New Story'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE33629),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
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

  Future<void> _showCommentsDialog(StoryModel story) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Consumer<StoryProvider>(
        builder: (context, provider, _) {
          // ✅ Always show live comment list
          StoryModel liveStory = story;
          try {
            final liveGroup = provider.storyGroups
                .firstWhere((g) => g.userId == story.userId);
            liveStory = liveGroup.stories.firstWhere((s) => s.id == story.id);
          } catch (_) {}

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Comments',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.grey),
                  Expanded(
                    child: liveStory.comments.isEmpty
                        ? const Center(
                            child: Text('No comments yet',
                                style: TextStyle(color: Colors.grey)),
                          )
                        : ListView.builder(
                            itemCount: liveStory.comments.length,
                            itemBuilder: (context, index) {
                              final comment = liveStory.comments[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage:
                                          comment.userProfileImage != null
                                              ? NetworkImage(
                                                  comment.userProfileImage!)
                                              : null,
                                      child: comment.userProfileImage == null
                                          ? const Icon(Icons.person, size: 16)
                                          : null,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.userName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            comment.text,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            _formatTime(comment.createdAt),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (comment.userId == widget.currentUserId)
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline,
                                            color: Colors.grey, size: 18),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await _deleteComment(
                                              liveStory.id, comment.id);
                                        },
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
}
