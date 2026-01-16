import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayingVideosController extends GetxController {
  VideoPlayerController? videoController;
  final RxBool isInitialized = false.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isBuffering = false.obs;
  final RxBool showControls = true.obs;
  final RxDouble currentPosition = 0.0.obs;
  final RxDouble duration = 0.0.obs;
  final RxBool isFullScreen = false.obs;
  final RxBool isMuted = false.obs;
  final RxBool hasVideoStarted = false.obs;
  final RxBool isVideoLoading = false.obs;

  Timer? _controlsTimer;

  final Rx<VideoModel> currentVideo = VideoModel(
    id: '',
    title: '',
    channelName: '',
    channelLogo: 'assets/images/quranitypng.png',
    description: '',
    videoUrl: '',
    thumbnailUrl: '',
  ).obs;

  final RxList<VideoModel> continueWatching = <VideoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadVideoDataFromArguments();
  }

  @override
  void onClose() {
    _disposeVideoController();
    // ওরিয়েন্টেশন রিসেট
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _controlsTimer?.cancel();
    super.onClose();
  }

  void _disposeVideoController() {
    if (videoController != null) {
      videoController!.removeListener(_videoListener);
      videoController!.dispose();
      videoController = null;
    }
    isInitialized.value = false;
  }

  void _loadVideoDataFromArguments() {
    final args = Get.arguments;
    if (args != null && args['video'] != null) {
      final videoData = args['video'];
      currentVideo.value = VideoModel(
        id: videoData['id'] ?? '1',
        title: videoData['title'] ?? 'Unknown Title',
        channelName: videoData['channelName'] ?? 'Quranity',
        channelLogo: videoData['channelLogo'] ?? 'assets/images/quranitypng.png',
        description: videoData['description'] ?? 'No description available',
        videoUrl: videoData['videoUrl'] ?? '',
        thumbnailUrl: videoData['thumbnailUrl'] ?? '',
      );
    } else {
      _loadDefaultVideoData();
    }
    _loadContinueWatchingList();
  }

  void _loadDefaultVideoData() {
    currentVideo.value = VideoModel(
      id: '1',
      title: 'The Architecture of Al-Andalus',
      channelName: 'Quranity',
      channelLogo: 'assets/images/quranitypng.png',
      description: 'Exploring the profound meanings behind the verses.',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800',
    );
  }

  void _loadContinueWatchingList() {
    continueWatching.value = [
      VideoModel(
          id: '2',
          title: 'The Architecture of Al-Andalus: Part 2',
          channelName: 'Quranity',
          channelLogo: 'assets/images/quranitypng.png',
          description: 'Continuation series',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          thumbnailUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800'
      ),
    ];
  }

  Future<void> startVideo() async {
    hasVideoStarted.value = true;
    await _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (currentVideo.value.videoUrl.isEmpty) return;

    isVideoLoading.value = true;
    _disposeVideoController();

    videoController = VideoPlayerController.networkUrl(Uri.parse(currentVideo.value.videoUrl));

    try {
      await videoController!.initialize();
      isInitialized.value = true;
      duration.value = videoController!.value.duration.inSeconds.toDouble();
      videoController!.addListener(_videoListener);
      videoController!.play();

      isVideoLoading.value = false;
      _hideControlsAfterDelay();
    } catch (e) {
      isVideoLoading.value = false;
      print("Video Initialization Error: $e");
    }
  }

  void _videoListener() {
    if (videoController != null && videoController!.value.isInitialized) {
      isPlaying.value = videoController!.value.isPlaying;
      // বাফারিং এবং সিকিং (টেনে দেওয়া) লজিক
      isBuffering.value = videoController!.value.isBuffering;
      currentPosition.value = videoController!.value.position.inSeconds.toDouble();
    }
  }

  void playPause() {
    if (videoController == null || !isInitialized.value) return;
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
      _hideControlsAfterDelay();
    }
  }

  void seekTo(double seconds) {
    if (videoController == null) return;
    videoController!.seekTo(Duration(seconds: seconds.toInt()));
  }

  void skipForward() => seekTo(currentPosition.value + 10);
  void skipBackward() => seekTo(currentPosition.value - 10);

  void toggleMute() {
    isMuted.value = !isMuted.value;
    videoController?.setVolume(isMuted.value ? 0.0 : 1.0);
  }

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
    if (isFullScreen.value) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }
  }

  void toggleControls() {
    showControls.value = !showControls.value;
    if (showControls.value) _hideControlsAfterDelay();
  }

  void _hideControlsAfterDelay() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (isPlaying.value) showControls.value = false;
    });
  }

  // নতুন ভিডিও প্লে করার জন্য এই ফাংশনটি আপডেট করা হয়েছে
  void changeVideo(VideoModel video) {
    currentVideo.value = video;
    isInitialized.value = false;
    hasVideoStarted.value = true; // সরাসরি ভিডিও মোডে নিয়ে যাবে
    _initializeVideo(); // নতুন ভিডিও লোড করবে
  }

  String formatDuration(double seconds) {
    final d = Duration(seconds: seconds.toInt());
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}

class VideoModel {
  final String id, title, channelName, channelLogo, description, videoUrl, thumbnailUrl;
  VideoModel({
    required this.id,
    required this.title,
    required this.channelName,
    required this.channelLogo,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl
  });
}