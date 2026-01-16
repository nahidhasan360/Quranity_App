import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'playing_videos_controller.dart';

class PlayingVideos extends GetView<PlayingVideosController> {
  const PlayingVideos({super.key});

  @override
  Widget build(BuildContext context) {
    final double playerHeight = MediaQuery.of(context).size.width * 9 / 16;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // ১. ভিডিও প্লেয়ার বা থাম্বনেইল সেকশন
          Obx(() {
            return Container(
              height: playerHeight,
              width: double.infinity,
              color: Colors.black,
              child: !controller.hasVideoStarted.value
                  ? _buildThumbnailWithPlayButton(playerHeight, context)
                  : _buildVideoPlayerWidget(playerHeight, context),
            );
          }),

          // ২. স্ক্রলযোগ্য ডিটেইলস সেকশন
          Expanded(
            child: Container(
              color: const Color(0xFF0C0C0C),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildVideoInfo(),
                    const SizedBox(height: 16),
                    _buildDescription(),
                    const SizedBox(height: 24),
                    _buildContinueWatching(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== থাম্বনেইল মোড (ভিডিও শুরুর আগে) ==========
  Widget _buildThumbnailWithPlayButton(double height, BuildContext context) {
    return GestureDetector(
      onTap: controller.startVideo,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: controller.currentVideo.value.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: height,
          ),
          Container(height: height, color: Colors.black38),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: _buildBackButton(),
          ),
          // সেন্টারে প্লে বাটন
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.primaryGold,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.black,
              size: 40,
            ),
          ),
          // থাম্বনেইল অবস্থায় লোডিং হলে
          if (controller.isVideoLoading.value)
            const CircularProgressIndicator(color: AppColors.primaryGold),
        ],
      ),
    );
  }


  Widget _buildVideoPlayerWidget(double height, BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: controller.toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [

          if (controller.isInitialized.value)
            Center(
              child: AspectRatio(
                aspectRatio: controller.videoController!.value.aspectRatio,
                child: VideoPlayer(controller.videoController!),
              ),
            ),

          if (controller.isBuffering.value || !controller.isInitialized.value)
            const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGold),
            ),

          if (controller.showControls.value)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: Stack(
                  children: [

                    Positioned(
                      top: MediaQuery.of(context).padding.top + 5,
                      left: 16,
                      child: _buildBackButton(),
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: controller.playPause,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            controller.isPlaying.value ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 55,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildBottomControls(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ));
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SliderTheme(

            data: SliderThemeData(
              padding: EdgeInsets.only(left: 0,right: 0,bottom: 5,),
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              activeTrackColor: AppColors.primaryGold,
              inactiveTrackColor: Colors.white30,
              thumbColor: Colors.white,
            ),
            child: Slider(
              value: controller.currentPosition.value.clamp(
                0.0,
                controller.duration.value,
              ),
              max: controller.duration.value > 0
                  ? controller.duration.value
                  : 1.0,
              onChanged: (v) => controller.seekTo(v),
            ),
          ),
          Row(
            children: [

              _controlIcon(
                controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                controller.playPause,
              ),
              const SizedBox(width: 15),
              _controlIcon(Icons.skip_previous, controller.skipBackward),
              const SizedBox(width: 15),
              _controlIcon(Icons.skip_next, controller.skipForward),
              const SizedBox(width: 15),
              _controlIcon(
                controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                controller.toggleMute,
              ),
              const Spacer(),
              _buildTimeText(),
              const SizedBox(width: 15),
              _controlIcon(Icons.fullscreen, controller.toggleFullScreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${controller.formatDuration(controller.currentPosition.value)} / ${controller.formatDuration(controller.duration.value)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _controlIcon(IconData icon, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  // --- Video Info, Description, Continue Watching (Unchanged) ---
  Widget _buildVideoInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.currentVideo.value.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: controller.currentVideo.value.channelLogo,
                  width: 32,
                  height: 32,
                  errorWidget: (c, u, e) =>
                      Icon(Icons.account_circle, color: AppColors.primaryGold),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                controller.currentVideo.value.channelName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12, thickness: 1),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          controller.currentVideo.value.description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueWatching() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Continue Watching",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.continueWatching.length,
            itemBuilder: (context, index) {
              final video = controller.continueWatching[index];
              return GestureDetector(
                onTap: () => controller.changeVideo(video),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: video.thumbnailUrl,
                          width: 110,
                          height: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
