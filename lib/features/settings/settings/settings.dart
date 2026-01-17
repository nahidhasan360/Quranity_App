import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'Notifications/notification_screen.dart';
import 'settings_controller.dart';
import 'settings_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

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
                    children: [
                      SizedBox(height: 24.h),

                      // Language
                      Obx(() => _buildSettingItem(
                        icon: Icons.language_outlined,
                        title: SettingsStrings.language,
                        value: controller.selectedLanguage.value,
                        onTap: controller.openLanguageSettings,
                      )),

                      SizedBox(height: 12.h),

                      // Theme
                      Obx(() => _buildSettingItem(
                        icon: Icons.dark_mode_outlined,
                        title: SettingsStrings.theme,
                        value: controller.selectedTheme.value,
                        onTap: controller.openThemeSettings,
                      )),

                      SizedBox(height: 12.h),

                      // Video Quality (Coming Soon - Non-clickable)
                      _buildSettingItem(
                        icon: Icons.video_settings_outlined,
                        title: SettingsStrings.videoQuality,
                        value: SettingsStrings.comingSoon,
                        onTap: () {}, // No action
                      ),

                      SizedBox(height: 12.h),

                      // settings_screen.dart
                      Obx(() => _buildSettingItem(
                        icon: Icons.notifications_outlined,
                        title: SettingsStrings.notifications,
                        value: controller.notificationStatus,
                        onTap: () => Get.to(() => const NotificationsScreen()),
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
                SettingsStrings.screenTitle,
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
  /// SETTING ITEM
  /// ============================================================================
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Icon
            Icon(
              icon,
              color: AppColors.primaryGold,
              size: 22.sp,
            ),

            SizedBox(width: 16.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Value
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary.withOpacity(0.6),
                fontFamily: 'SF Pro',
              ),
            ),

            SizedBox(width: 8.w),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: AppColors.iconWhite.withOpacity(0.6),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}