// local_video_player.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LocalVideoPlayer extends StatefulWidget {
  final File file;
  final bool autoPlay;

  const LocalVideoPlayer({
    Key? key,
    required this.file,
    this.autoPlay = true,
  }) : super(key: key);

  @override
  State<LocalVideoPlayer> createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  // ANDROID
  MethodChannel? _channel;
  bool _isViewReady = false;

  // IOS
  VideoPlayerController? _iosController;
  bool _iosInitialized = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      _initIOSPlayer();
    }
  }

  // ================= IOS PLAYER =================
  Future<void> _initIOSPlayer() async {
    _iosController = VideoPlayerController.file(widget.file);

    try {
      await _iosController!.initialize();
      _iosInitialized = true;

      if (widget.autoPlay) {
        _iosController!.play();
      }

      setState(() {});
    } catch (e) {
      debugPrint("iOS local video error: $e");
    }
  }

  void _updateIOSPlayback() {
    if (_iosController == null) return;

    if (widget.autoPlay) {
      _iosController!.play();
    } else {
      _iosController!.pause();
    }
  }

  void _loadNewIOSVideo() async {
    await _iosController?.dispose();

    _iosInitialized = false;

    _iosController = VideoPlayerController.file(widget.file);

    await _iosController!.initialize();
    _iosInitialized = true;

    if (widget.autoPlay) {
      _iosController!.play();
    }

    setState(() {});
  }

  // ================= ANDROID PLAYER =================
  void _updatePlaybackState() {
    if (widget.autoPlay) {
      _channel?.invokeMethod('play');
    } else {
      _channel?.invokeMethod('pause');
    }
  }

  void _loadNewVideo() {
    if (_channel != null) {
      final Map<String, dynamic> params = {
        'filePath': widget.file.path,
        'autoPlay': widget.autoPlay,
      };
      _channel?.invokeMethod('loadLocalVideo', params);
    }
  }

  // ================= COMMON =================
  @override
  void didUpdateWidget(LocalVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (Platform.isAndroid) {
      if (_isViewReady) {
        if (oldWidget.autoPlay != widget.autoPlay) {
          _updatePlaybackState();
        }
        if (oldWidget.file.path != widget.file.path) {
          _loadNewVideo();
        }
      }
    } else if (Platform.isIOS) {
      if (oldWidget.autoPlay != widget.autoPlay) {
        _updateIOSPlayback();
      }
      if (oldWidget.file.path != widget.file.path) {
        _loadNewIOSVideo();
      }
    }
  }

  @override
  void dispose() {
    _channel = null;
    _iosController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ================= ANDROID =================
    if (Platform.isAndroid) {
      const String viewType = 'com.pixelmind/LocalExoPlayerView';

      final Map<String, dynamic> creationParams = {
        'filePath': widget.file.path,
        'autoPlay': widget.autoPlay,
      };

      return PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const {},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          _channel =
              MethodChannel('com.pixelmind/LocalExoPlayerView_${params.id}');

          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () => params.onFocusChanged(true),
          )
            ..addOnPlatformViewCreatedListener((id) {
              params.onPlatformViewCreated(id);
              setState(() => _isViewReady = true);

              if (widget.autoPlay) {
                _channel?.invokeMethod('play');
              } else {
                _channel?.invokeMethod('pause');
              }
            })
            ..create();
        },
      );
    }

    // ================= IOS =================
    if (Platform.isIOS) {
      if (_iosController == null || !_iosInitialized) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _iosController!.value.size.width,
          height: _iosController!.value.size.height,
          child: VideoPlayer(_iosController!),
        ),
      );
    }

    // ================= FALLBACK =================
    return const SizedBox();
  }
}
