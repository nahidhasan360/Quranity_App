import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'notifications_controller.dart';
import 'notifications_strings.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: GradientBackground(
        useRadialGradient: true,
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

                      // Section Header
                      _buildSectionHeader(),

                      SizedBox(height: 16.h),

                      // Prayer Times
                      Obx(() => _buildNotificationItem(
                        title: NotificationsStrings.prayerTimesTitle,
                        description: NotificationsStrings.prayerTimesDescription,
                        value: controller.prayerTimesEnabled.value,
                        onChanged: controller.togglePrayerTimes,
                      )),

                      SizedBox(height: 12.h),

                      // Daily Verse
                      Obx(() => _buildNotificationItem(
                        title: NotificationsStrings.dailyVerseTitle,
                        description: NotificationsStrings.dailyVerseDescription,
                        value: controller.dailyVerseEnabled.value,
                        onChanged: controller.toggleDailyVerse,
                      )),

                      SizedBox(height: 12.h),

                      // Reading Reminders
                      Obx(() => _buildNotificationItem(
                        title: NotificationsStrings.readingRemindersTitle,
                        description: NotificationsStrings.readingRemindersDescription,
                        value: controller.readingRemindersEnabled.value,
                        onChanged: controller.toggleReadingReminders,
                      )),

                      SizedBox(height: 12.h),

                      // New Video Releases
                      Obx(() => _buildNotificationItem(
                        title: NotificationsStrings.newVideoReleasesTitle,
                        description: NotificationsStrings.newVideoReleasesDescription,
                        value: controller.newVideoReleasesEnabled.value,
                        onChanged: controller.toggleNewVideoReleases,
                      )),

                      SizedBox(height: 32.h),
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

  /// ============================================================================
  /// APP BAR
  /// ============================================================================
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.iconWhite,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                NotificationsStrings.screenTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ),
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  /// ============================================================================
  /// SECTION HEADER
  /// ============================================================================
  Widget _buildSectionHeader() {
    return Text(
      NotificationsStrings.appNotificationsHeader,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary.withOpacity(0.5),
        letterSpacing: 1.2,
        fontFamily: 'SF Pro',
      ),
    );
  }

  /// ============================================================================
  /// NOTIFICATION ITEM
  /// ============================================================================
  Widget _buildNotificationItem({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'SF Pro',
                  ),
                ),

                SizedBox(height: 4.h),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary.withOpacity(0.6),
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          // Toggle Switch
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: AppColors.primaryGold,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.medGrey,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}