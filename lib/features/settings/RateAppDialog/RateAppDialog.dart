import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class RateAppDialog {
  static void show() {
    final selectedRating = 0.obs;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Star Icon
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.star,
                  color: AppColors.primaryGold,
                  size: 30.sp,
                ),
              ),

              SizedBox(height: 16.h),

              // Title
              Text(
                'Rate Quranity',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGold,
                  fontFamily: 'SF Pro',
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'How are you enjoying the app so far?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8),
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              // Star Rating
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      selectedRating.value = index + 1;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        selectedRating.value > index
                            ? Icons.star
                            : Icons.star_outline,
                        color: selectedRating.value > index
                            ? AppColors.primaryGold
                            : Colors.white.withOpacity(0.5),
                        size: 40.sp,
                      ),
                    ),
                  );
                }),
              )),

              SizedBox(height: 24.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedRating.value == 0) {
                      Get.snackbar(
                        'Rating Required',
                        'Please select a rating before submitting',
                        backgroundColor: Colors.red.withOpacity(0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                      return;
                    }

                    Get.back(); // Close dialog

                    // Show thank you message
                    Get.snackbar(
                      'Thank You!',
                      'Thanks for rating Quranity!',
                      backgroundColor: Colors.green.withOpacity(0.9),
                      colorText: Colors.white,
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                      duration: const Duration(seconds: 2),
                    );

                    // Open app store
                    await Future.delayed(const Duration(milliseconds: 500));
                    _openAppStore();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _openAppStore() async {
    const androidUrl =
        'https://play.google.com/store/apps/details?id=com.your.app';
    const iosUrl = 'https://apps.apple.com/app/idYOUR_APP_ID';

    try {
      if (GetPlatform.isAndroid) {
        await launchUrl(Uri.parse(androidUrl), mode: LaunchMode.externalApplication);
      } else if (GetPlatform.isIOS) {
        await launchUrl(Uri.parse(iosUrl), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch app store: $e');
      Get.snackbar(
        'Error',
        'Could not open app store',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }
}