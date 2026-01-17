import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/custom_navigation_bar.dart';
import 'package:video_player/video_player.dart';
import '../../core/constants/ app_strings.dart';
import 'shorts_controller.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> with WidgetsBindingObserver {
  late ShortsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ShortsController());
    WidgetsBinding.instance.addObserver(this); // ✅ Add lifecycle observer
  }

  @override
  void dispose() {
    // ✅ Pause and cleanup when leaving screen
    controller.pauseAndCleanup();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ✅ Handle app lifecycle changes
    if (state == AppLifecycleState.paused) {
      // App goes to background
      controller.pauseVideo();
    } else if (state == AppLifecycleState.resumed) {
      // App comes back to foreground
      if (mounted) {
        controller.resumeVideo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Transparent status bar for full screen video
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ✅ Video PageView (Full Screen)
          PageView.builder(
            scrollDirection: Axis.vertical,
            onPageChanged: (index) => controller.onPageChanged(index),
            itemCount: controller.allowedVideoCount,
            itemBuilder: (context, index) {
              return _buildVideoItem(controller, index);
            },
          ),

          // ✅ Top Bar
          _buildTopBar(),

          // ✅ Progress Bar
          _buildBottomProgressBar(controller),
        ],
      ),
      bottomNavigationBar: const CustomNavbar(),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.4),
              Colors.black.withValues(alpha: 0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 48.h,
            alignment: Alignment.center,
            child: Text(
              AppStrings.forYou,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomProgressBar(ShortsController controller) {
    return Positioned(
      bottom: 86.h,
      left: 0,
      right: 0,
      child: Obx(() {
        final isLoading = controller.isLoading.value;
        final isInitialized = controller.isVideoInitialized.value;

        if (isLoading || !isInitialized) return const SizedBox.shrink();

        final videoProgress = controller.videoProgress;

        return Container(
          height: 24.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onTapDown: (details) {
                  final progress = details.localPosition.dx / constraints.maxWidth;
                  controller.seekTo(progress.clamp(0.0, 1.0));
                },
                onHorizontalDragUpdate: (details) {
                  final progress = details.localPosition.dx / constraints.maxWidth;
                  controller.seekTo(progress.clamp(0.0, 1.0));
                },
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: videoProgress.clamp(0.0, 1.0),
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Positioned(
                      left: ((constraints.maxWidth * videoProgress.clamp(0.0, 1.0)) - 9.w)
                          .clamp(0.0, constraints.maxWidth - 18.w),
                      child: Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildVideoItem(ShortsController controller, int index) {
    final video = controller.videos[index];

    return Obx(() {
      final currentIndex = controller.currentVideoIndex.value;
      final isCurrentVideo = currentIndex == index;
      final isLoading = controller.isLoading.value;
      final isPlaying = controller.isPlaying.value;
      final isInitialized = controller.isVideoInitialized.value;

      return Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () => controller.togglePlayPause(),
            child: Container(
              color: Colors.black,
              child: isCurrentVideo &&
                  controller.videoController != null &&
                  isInitialized &&
                  controller.videoController!.value.isInitialized
                  ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.videoController!.value.size.width,
                  height: controller.videoController!.value.size.height,
                  child: VideoPlayer(controller.videoController!),
                ),
              )
                  : Image.network(
                video.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black,
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (isCurrentVideo && !isLoading && !isPlaying)
            Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.primaryGold,
                  size: 48.sp,
                ),
              ),
            ),
          if (isCurrentVideo && isLoading)
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryGold,
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.85),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 110.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _buildVideoInfo(video)),
                  SizedBox(width: 12.w),
                  _buildActionButtons(controller, video),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildVideoInfo(VideoModel video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(6.r),
              child: Image.asset(
                'assets/images/quranitypng.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.mosque,
                    color: AppColors.primaryGold,
                    size: 24.sp,
                  );
                },
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                video.channelName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          video.description,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: 0.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildActionButtons(ShortsController controller, VideoModel video) {
    return Obx(() {
      final isSaved = controller.savedVideos.contains(video.id);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            icon: isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
            label: AppStrings.save,
            onTap: () => controller.toggleSave(video.id),
            isActive: isSaved,
          ),
        ],
      );
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}