import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/ app_strings.dart';

class ShortsController extends GetxController {
  VideoPlayerController? videoController;
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentVideoIndex = 0.obs;
  RxBool isPremiumUser = false.obs;
  RxInt videosWatched = 0.obs;
  final int freeVideoLimit = 3;
  RxList<String> savedVideos = <String>[].obs;
  RxBool hasReachedLimit = false.obs;

  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  RxBool isVideoInitialized = false.obs;

  final List<VideoModel> videos = [
    VideoModel(
      id: '1',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnail: 'https://picsum.photos/400/700?random=1',
      channelName: 'Quranity',
      description: 'The Patience of Prophet Ayub (AS)',
    ),
    VideoModel(
      id: '2',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnail: 'https://picsum.photos/400/700?random=2',
      channelName: 'Quranity',
      description: 'Understanding Islamic Architecture',
    ),
    VideoModel(
      id: '3',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      thumbnail: 'https://picsum.photos/400/700?random=3',
      channelName: 'Quranity',
      description: 'Daily Dhikr and Remembrance',
    ),
    VideoModel(
      id: '4',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      thumbnail: 'https://picsum.photos/400/700?random=4',
      channelName: 'Quranity',
      description: 'The Importance of Prayer',
    ),
    VideoModel(
      id: '5',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      thumbnail: 'https://picsum.photos/400/700?random=5',
      channelName: 'Quranity',
      description: 'Life of Prophet Muhammad (PBUH)',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    videosWatched.value = 1;
    _loadVideo(0);
  }

  @override
  void onClose() {
    _disposeController();
    super.onClose();
  }

  int get allowedVideoCount {
    return isPremiumUser.value ? videos.length : freeVideoLimit;
  }

  double get videoProgress {
    if (totalDuration.value.inMilliseconds == 0) return 0.0;
    return currentPosition.value.inMilliseconds / totalDuration.value.inMilliseconds;
  }

  void onPageChanged(int index) {
    if (!isPremiumUser.value && index >= freeVideoLimit) {
      _pauseVideo();
      if (!hasReachedLimit.value) {
        hasReachedLimit.value = true;
        _showLimitReachedDialog();
      }
      return;
    }

    currentVideoIndex.value = index;
    if (index + 1 > videosWatched.value) {
      videosWatched.value = index + 1;
    }
    _loadVideo(index);
  }

  Future<void> _disposeController() async {
    try {
      if (videoController != null) {
        videoController!.removeListener(_videoListener);
        await videoController!.pause();
        await videoController!.dispose();
        videoController = null;
        isVideoInitialized.value = false;
      }
    } catch (e) {
      debugPrint('❌ Error disposing controller: $e');
    }
  }

  Future<void> _loadVideo(int index) async {
    try {
      isLoading.value = true;
      isPlaying.value = false;
      isVideoInitialized.value = false;
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;

      await _disposeController();
      await Future.delayed(const Duration(milliseconds: 200));

      videoController = VideoPlayerController.networkUrl(
        Uri.parse(videos[index].videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false,
          allowBackgroundPlayback: false,
        ),
      );

      videoController!.addListener(() {
        if (videoController != null && videoController!.value.hasError) {
          debugPrint('❌ Video Error: ${videoController!.value.errorDescription}');
          _handleVideoError();
        }
      });

      await videoController!.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Video initialization timeout');
        },
      );

      if (videoController == null || !videoController!.value.isInitialized) {
        throw Exception('Controller disposed during initialization');
      }

      isVideoInitialized.value = true;
      totalDuration.value = videoController!.value.duration;
      videoController!.addListener(_videoListener);
      videoController!.setLooping(true);
      videoController!.setVolume(1.0);

      isLoading.value = false;

      await videoController!.play();
      isPlaying.value = true;

      debugPrint('✅ Video loaded: ${videos[index].description}');
    } catch (e) {
      isLoading.value = false;
      isPlaying.value = false;
      isVideoInitialized.value = false;
      debugPrint('❌ Error loading video: $e');

      Get.snackbar(
        'Video Error',
        'Unable to load video. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (currentVideoIndex.value + 1 < videos.length) {
          onPageChanged(currentVideoIndex.value + 1);
        }
      });
    }
  }

  void _handleVideoError() {
    isLoading.value = false;
    isPlaying.value = false;
    isVideoInitialized.value = false;

    Get.snackbar(
      'Playback Error',
      'Video playback failed. Trying next video...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (currentVideoIndex.value + 1 < videos.length) {
        onPageChanged(currentVideoIndex.value + 1);
      }
    });
  }

  void _videoListener() {
    if (videoController != null &&
        videoController!.value.isInitialized &&
        isVideoInitialized.value) {
      currentPosition.value = videoController!.value.position;
    }
  }

  void togglePlayPause() {
    if (videoController == null || !isVideoInitialized.value || isLoading.value) return;

    try {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
        isPlaying.value = false;
        debugPrint('⏸️ Video Paused');
      } else {
        videoController!.play();
        isPlaying.value = true;
        debugPrint('▶️ Video Playing');
      }
    } catch (e) {
      debugPrint('❌ Error toggling play/pause: $e');
    }
  }

  void _pauseVideo() {
    try {
      if (videoController != null && isVideoInitialized.value) {
        videoController!.pause();
        isPlaying.value = false;
        videoController!.setVolume(0.0);
        debugPrint('🔇 Video paused and muted for dialog');
      }
    } catch (e) {
      debugPrint('❌ Error pausing video: $e');
    }
  }

  void _resumeVideo() {
    try {
      if (videoController != null && isVideoInitialized.value) {
        videoController!.setVolume(1.0);
        videoController!.play();
        isPlaying.value = true;
        debugPrint('🔊 Video resumed with audio');
      }
    } catch (e) {
      debugPrint('❌ Error resuming video: $e');
    }
  }

  // ✅ PUBLIC METHOD: Pause video (called from UI)
  void pauseVideo() {
    try {
      if (videoController != null && isVideoInitialized.value) {
        videoController!.pause();
        videoController!.setVolume(0.0);
        isPlaying.value = false;
        debugPrint('⏸️ Video paused (navigated away)');
      }
    } catch (e) {
      debugPrint('❌ Error pausing video: $e');
    }
  }

  // ✅ PUBLIC METHOD: Resume video (called from UI)
  void resumeVideo() {
    try {
      if (videoController != null && isVideoInitialized.value) {
        videoController!.setVolume(1.0);
        videoController!.play();
        isPlaying.value = true;
        debugPrint('▶️ Video resumed');
      }
    } catch (e) {
      debugPrint('❌ Error resuming video: $e');
    }
  }

  // ✅ PUBLIC METHOD: Complete cleanup (called from dispose)
  void pauseAndCleanup() {
    try {
      if (videoController != null) {
        videoController!.pause();
        videoController!.setVolume(0.0);
        isPlaying.value = false;
        debugPrint('🛑 Video stopped and cleaned up');
      }
    } catch (e) {
      debugPrint('❌ Error in cleanup: $e');
    }
  }

  void seekTo(double progress) {
    if (videoController == null ||
        !isVideoInitialized.value ||
        totalDuration.value.inMilliseconds == 0) return;

    try {
      final position = Duration(
        milliseconds: (totalDuration.value.inMilliseconds * progress).toInt(),
      );

      videoController!.seekTo(position);
    } catch (e) {
      debugPrint('❌ Error seeking: $e');
    }
  }

  void toggleSave(String videoId) {
    if (savedVideos.contains(videoId)) {
      savedVideos.remove(videoId);
      Get.snackbar(
        AppStrings.removed,
        AppStrings.videoRemoved,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
      );
    } else {
      savedVideos.add(videoId);
      Get.snackbar(
        AppStrings.saved,
        AppStrings.videoSaved,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void _showLimitReachedDialog() {
    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
          hasReachedLimit.value = false;
          debugPrint('❌ Dialog dismissed by outside tap');
        },
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2A2A2A),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.workspace_premium,
                          color: AppColors.primaryGold,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        AppStrings.limitReached,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${AppStrings.freeUsersLimit} $freeVideoLimit ${AppStrings.shortsDaily}\n${AppStrings.upgradePremiumAccess}',
                        style: const TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      InkWell(
                        onTap: () {
                          Get.back();
                          isPremiumUser.value = true;
                          hasReachedLimit.value = false;
                          _resumeVideo();

                          Get.snackbar(
                            AppStrings.upgradeSuccess,
                            '${AppStrings.upgradeMessage}\nEnjoy unlimited shorts!',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                            backgroundColor: AppColors.primaryGold.withOpacity(0.9),
                            colorText: Colors.black,
                            margin: const EdgeInsets.all(16),
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.black,
                            ),
                          );

                          debugPrint('✅ Premium activated - Unlimited shorts!');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryGoldDark,
                                AppColors.primaryGoldLight,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            AppStrings.upgradeToPremium,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
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
      ),
      barrierDismissible: true,
    );
  }
}

class VideoModel {
  final String id;
  final String videoUrl;
  final String thumbnail;
  final String channelName;
  final String description;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.thumbnail,
    required this.channelName,
    required this.description,
  });
}