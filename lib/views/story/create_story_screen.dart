import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/Provider/story_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  File? _selectedMedia;
  String? _caption;
  bool _isUploading = false;
  String? _mediaType;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose Image from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? media =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (media != null) {
                  setState(() {
                    _selectedMedia = File(media.path);
                    _mediaType = 'image';
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library), // Changed icon
              title: const Text('Choose Video from Gallery'), // NEW OPTION
              onTap: () async {
                Navigator.pop(context);
                final XFile? media =
                    await _picker.pickVideo(source: ImageSource.gallery);
                if (media != null) {
                  setState(() {
                    _selectedMedia = File(media.path);
                    _mediaType = 'video';
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? media =
                    await _picker.pickImage(source: ImageSource.camera);
                if (media != null) {
                  setState(() {
                    _selectedMedia = File(media.path);
                    _mediaType = 'image';
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Record Video'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? media =
                    await _picker.pickVideo(source: ImageSource.camera);
                if (media != null) {
                  setState(() {
                    _selectedMedia = File(media.path);
                    _mediaType = 'video';
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadStory() async {
    if (_selectedMedia == null) return;

    setState(() {
      _isUploading = true;
    });

    final userId = await SharedPrefHelper.getUserId();
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      setState(() {
        _isUploading = false;
      });
      return;
    }

    final success =
        await Provider.of<StoryProvider>(context, listen: false).createStory(
      userId: userId,
      mediaFile: _selectedMedia!,
      caption: _caption,
    );

    setState(() {
      _isUploading = false;
    });

    if (success) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story posted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to post story')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Story'),
        actions: [
          if (_selectedMedia != null)
            TextButton(
              onPressed: _isUploading ? null : _uploadStory,
              child: _isUploading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Post'),
            ),
        ],
      ),
      body: _selectedMedia == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_photo_alternate,
                      size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickMedia,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE33629),
                    ),
                    child: const Text('Select Media'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: _mediaType == 'video'
                      ? VideoPlayerWidget(file: _selectedMedia!)
                      : Image.file(
                          _selectedMedia!,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    maxLength: 500,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Add a caption...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _caption = value;
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: _selectedMedia == null
          ? FloatingActionButton(
              onPressed: _pickMedia,
              backgroundColor: const Color(0xFFE33629),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

// Simple video player widget
class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
