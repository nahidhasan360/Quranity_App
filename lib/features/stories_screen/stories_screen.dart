import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../../core/constants/ app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/reusable_gradient.dart';
import '../home/home_strings.dart';
import 'stories_controller.dart';

class StoriesScreen extends GetView<StoriesController> {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // ✅ KEEP IT
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Top Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildTopBar(),
              ),

              // Stories Content
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGold,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildSectionTitle(),
                        SizedBox(height: 20.h),
                        _buildStoryList(),
                        SizedBox(height: 120.h), // ✅ CHANGED: 80.h → 120.h (navbar 110.h + 10.h extra)
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavbar(), // ✅ ADDED: const
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.medGrey,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: const Icon(Icons.menu, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.medGrey,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textWhite, size: 20),
                SizedBox(width: 8.w),
                Text(
                  HomeStrings.searchHint,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.hintText),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Stack(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.medGrey,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.notification,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
            Positioned(
              top: 9,
              right: 14,
              child: Container(
                width: 6.w,
                height: 6.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ========== SECTION TITLE ==========
  Widget _buildSectionTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Discover text with underline
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.discover,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Gold underline
                  Container(
                    width: 40.w,
                    height: 2.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // Category/Subtitle
              Obx(() => Text(
                controller.selectedCategory.value == 'All'
                    ? AppStrings.quranStory
                    : controller.selectedCategory.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              )),
            ],
          ),

          // Categories Dropdown
          GestureDetector(
            onTap: controller.showCategoriesBottomSheet,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryGold,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGold.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.categories,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== STORY LIST ==========
  Widget _buildStoryList() {
    return Obx(() => Column(
      children: controller.stories.map((story) => _buildStoryCard(story)).toList(),
    ));
  }

  // ========== STORY CARD (ONLY THUMBNAIL + PLAY ICON) ==========
  Widget _buildStoryCard(StoryModel story) {
    return GestureDetector(
      onTap: () => controller.openStory(story),
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Thumbnail Image Only (No loading, no video player)
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: story.thumbnailUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ // Top
                          Color(0xFF3F3C38),
                          Color(0xFF33302C),
                          Color(0xFF272420),
                          Color(0xFF1C1916),
                          Color(0xFF11100E),
                          Color(0xFF000000),
                        ],
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF1A3A52),
                          const Color(0xFF0D1F2D),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),

              // Dark Overlay from Bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // Static Play Icon (Center)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 90.h,
                child: Center(
                  child: Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primaryGold,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),

              // Duration Badge (Top Right)
              Positioned(
                top: 16.h,
                right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    story.duration,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // Bottom Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(13.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        story.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 10.h),

                      // Category
                      Text(
                        story.category,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Watch Now Button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.videoPlayer, arguments: {
                            'video': {
                              'id': story.id,
                              'title': story.title,
                              'channelName': story.channelName,
                              'channelLogo': story.channelLogo,
                              'description': story.description,
                              'videoUrl': story.videoUrl,
                              'thumbnailUrl': story.thumbnailUrl,
                            }
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGold.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                AppStrings.watchNow,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}