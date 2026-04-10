// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:product_app/Provider/story_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class CreateStoryScreen extends StatefulWidget {
//   const CreateStoryScreen({super.key});

//   @override
//   State<CreateStoryScreen> createState() => _CreateStoryScreenState();
// }

// class _CreateStoryScreenState extends State<CreateStoryScreen> {
//   File? _selectedMedia;
//   String? _caption;
//   bool _isUploading = false;
//   String? _mediaType;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickMedia() async {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Choose Image from Gallery'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final XFile? media =
//                     await _picker.pickImage(source: ImageSource.gallery);
//                 if (media != null) {
//                   setState(() {
//                     _selectedMedia = File(media.path);
//                     _mediaType = 'image';
//                   });
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.video_library), // Changed icon
//               title: const Text('Choose Video from Gallery'), // NEW OPTION
//               onTap: () async {
//                 Navigator.pop(context);
//                 final XFile? media =
//                     await _picker.pickVideo(source: ImageSource.gallery);
//                 if (media != null) {
//                   setState(() {
//                     _selectedMedia = File(media.path);
//                     _mediaType = 'video';
//                   });
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Take a Photo'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final XFile? media =
//                     await _picker.pickImage(source: ImageSource.camera);
//                 if (media != null) {
//                   setState(() {
//                     _selectedMedia = File(media.path);
//                     _mediaType = 'image';
//                   });
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.videocam),
//               title: const Text('Record Video'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final XFile? media =
//                     await _picker.pickVideo(source: ImageSource.camera);
//                 if (media != null) {
//                   setState(() {
//                     _selectedMedia = File(media.path);
//                     _mediaType = 'video';
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _uploadStory() async {
//     if (_selectedMedia == null) return;

//     setState(() {
//       _isUploading = true;
//     });

//     final userId = await SharedPrefHelper.getUserId();
//     if (userId == null || userId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please login first')),
//       );
//       setState(() {
//         _isUploading = false;
//       });
//       return;
//     }

//     final success =
//         await Provider.of<StoryProvider>(context, listen: false).createStory(
//       userId: userId,
//       mediaFile: _selectedMedia!,
//       caption: _caption,
//     );

//     setState(() {
//       _isUploading = false;
//     });

//     if (success) {
//       Navigator.pop(context, true);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Story posted successfully!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to post story')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Story'),
//         actions: [
//           if (_selectedMedia != null)
//             TextButton(
//               onPressed: _isUploading ? null : _uploadStory,
//               child: _isUploading
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                   : const Text('Post'),
//             ),
//         ],
//       ),
//       body: _selectedMedia == null
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.add_photo_alternate,
//                       size: 80, color: Colors.grey),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickMedia,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE33629),
//                     ),
//                     child: const Text('Select Media'),
//                   ),
//                 ],
//               ),
//             )
//           : Column(
//               children: [
//                 Expanded(
//                   child: _mediaType == 'video'
//                       ? VideoPlayerWidget(file: _selectedMedia!)
//                       : Image.file(
//                           _selectedMedia!,
//                           width: double.infinity,
//                           fit: BoxFit.contain,
//                         ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: TextField(
//                     maxLength: 500,
//                     maxLines: 3,
//                     decoration: const InputDecoration(
//                       hintText: 'Add a caption...',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       _caption = value;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//       floatingActionButton: _selectedMedia == null
//           ? FloatingActionButton(
//               onPressed: _pickMedia,
//               backgroundColor: const Color(0xFFE33629),
//               child: const Icon(Icons.add),
//             )
//           : null,
//     );
//   }
// }

// // Simple video player widget
// class VideoPlayerWidget extends StatefulWidget {
//   final File file;

//   const VideoPlayerWidget({super.key, required this.file});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.file);
//     _controller.initialize().then((_) {
//       setState(() {});
//       _controller.play();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//         : const Center(child: CircularProgressIndicator());
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/Provider/story_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:provider/provider.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen>
    with SingleTickerProviderStateMixin {
  File? _selectedMedia;
  String? _caption;
  bool _isUploading = false;
  String? _mediaType;
  String? _fileName;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _captionController = TextEditingController();
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _triggerEntryAnim() {
    _animController.reset();
    _animController.forward();
  }

  Future<void> _pickMedia() async {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _MediaPickerSheet(
        onImageGallery: () async {
          Navigator.pop(context);
          final XFile? media =
              await _picker.pickImage(source: ImageSource.gallery);
          if (media != null) {
            setState(() {
              _selectedMedia = File(media.path);
              _mediaType = 'image';
              _fileName = media.name;
            });
            _triggerEntryAnim();
          }
        },
        onVideoGallery: () async {
          Navigator.pop(context);
          final XFile? media =
              await _picker.pickVideo(source: ImageSource.gallery);
          if (media != null) {
            setState(() {
              _selectedMedia = File(media.path);
              _mediaType = 'video';
              _fileName = media.name;
            });
            _triggerEntryAnim();
          }
        },
        onCamera: () async {
          Navigator.pop(context);
          final XFile? media =
              await _picker.pickImage(source: ImageSource.camera);
          if (media != null) {
            setState(() {
              _selectedMedia = File(media.path);
              _mediaType = 'image';
              _fileName = media.name;
            });
            _triggerEntryAnim();
          }
        },
        onRecordVideo: () async {
          Navigator.pop(context);
          final XFile? media =
              await _picker.pickVideo(source: ImageSource.camera);
          if (media != null) {
            setState(() {
              _selectedMedia = File(media.path);
              _mediaType = 'video';
              _fileName = media.name;
            });
            _triggerEntryAnim();
          }
        },
      ),
    );
  }

  Future<void> _uploadStory() async {
    if (_selectedMedia == null) return;
    HapticFeedback.mediumImpact();

    setState(() => _isUploading = true);

    final userId = await SharedPrefHelper.getUserId();
    if (userId == null || userId.isEmpty) {
      _showSnack('Please login first', isError: true);
      setState(() => _isUploading = false);
      return;
    }

    final success =
        await Provider.of<StoryProvider>(context, listen: false).createStory(
      userId: userId,
      mediaFile: _selectedMedia!,
      caption: _caption,
    );

    setState(() => _isUploading = false);

    if (success) {
      Navigator.pop(context, true);
      _showSnack('Story posted!');
    } else {
      _showSnack('Failed to post story', isError: true);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg,
            style: const TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w500)),
        backgroundColor: isError ? const Color(0xFFED4956) : Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SafeArea(
        child:
            _selectedMedia == null ? _buildEmptyState() : _buildSelectedState(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 20),
        ),
      ),
      title: const Text(
        'New Story',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        if (_selectedMedia != null)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _isUploading
                ? const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: _uploadStory,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF833AB4), Color(0xFFF77737)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Share',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gradient ring
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF833AB4),
                  Color(0xFFF77737),
                  Color(0xFFFCAF45),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 44,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Create a Story',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share a photo or video\nwith your followers',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _pickMedia,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF833AB4), Color(0xFFF77737)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF77737).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_library_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Select Media',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedState() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Media info card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon badge
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _mediaType == 'video'
                                ? [
                                    const Color(0xFF4776E6),
                                    const Color(0xFF8E54E9)
                                  ]
                                : [
                                    const Color(0xFF833AB4),
                                    const Color(0xFFF77737)
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _mediaType == 'video'
                              ? Icons.videocam_rounded
                              : Icons.image_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fileName ?? 'Media selected',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _mediaType == 'video'
                                  ? 'Video · Ready to share'
                                  : 'Image · Ready to share',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Change button
                      GestureDetector(
                        onTap: _pickMedia,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Success indicator strip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline_rounded,
                          color: Color(0xFF4CD964), size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Media ready — add a caption below',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Caption field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: TextField(
                    controller: _captionController,
                    maxLength: 500,
                    maxLines: 4,
                    minLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write a caption…',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      counterStyle: TextStyle(
                        color: Colors.white.withOpacity(0.25),
                        fontSize: 11,
                      ),
                    ),
                    onChanged: (v) => _caption = v,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Audience row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _AudienceRow(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Media Picker Bottom Sheet
// ──────────────────────────────────────────────
class _MediaPickerSheet extends StatelessWidget {
  final VoidCallback onImageGallery;
  final VoidCallback onVideoGallery;
  final VoidCallback onCamera;
  final VoidCallback onRecordVideo;

  const _MediaPickerSheet({
    required this.onImageGallery,
    required this.onVideoGallery,
    required this.onCamera,
    required this.onRecordVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 6),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Add to Story',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
                letterSpacing: -0.3,
              ),
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          _SheetOption(
            icon: Icons.image_outlined,
            color: const Color(0xFF833AB4),
            label: 'Photo Library',
            subtitle: 'Choose from your gallery',
            onTap: onImageGallery,
          ),
          const Divider(color: Colors.white12, height: 1, indent: 70),
          _SheetOption(
            icon: Icons.video_library_outlined,
            color: const Color(0xFF4776E6),
            label: 'Video Library',
            subtitle: 'Choose a video from gallery',
            onTap: onVideoGallery,
          ),
          const Divider(color: Colors.white12, height: 1, indent: 70),
          _SheetOption(
            icon: Icons.camera_alt_outlined,
            color: const Color(0xFF34C759),
            label: 'Take Photo',
            subtitle: 'Use your camera',
            onTap: onCamera,
          ),
          const Divider(color: Colors.white12, height: 1, indent: 70),
          _SheetOption(
            icon: Icons.videocam_outlined,
            color: const Color(0xFFFF9500),
            label: 'Record Video',
            subtitle: 'Shoot a new video',
            onTap: onRecordVideo,
            isLast: true,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  const _SheetOption({
    required this.icon,
    required this.color,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.25), size: 22),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Audience Row widget
// ──────────────────────────────────────────────
class _AudienceRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Icon(Icons.public_rounded,
              color: Colors.white.withOpacity(0.55), size: 20),
          const SizedBox(width: 10),
          Text(
            'Your story · Visible to everyone',
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            '24h',
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
