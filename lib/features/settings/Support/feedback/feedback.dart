import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';

class FeedbackDialog {
  static void show() {
    final feedbackController = TextEditingController();
    final isLoading = false.obs;
    final characterCount = 0.obs;

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
              // Lightbulb Icon
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.primaryGold,
                  size: 30.sp,
                ),
              ),

              SizedBox(height: 16.h),

              // Title
              Text(
                'What Would You Like to See?',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'Your feedback helps us improve Quranity.',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.h),

              // Text Field
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: feedbackController,
                  maxLength: 500,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontFamily: 'SF Pro',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Share your thoughts, ideas, or any suggestions...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.4),
                      fontFamily: 'SF Pro',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(12.w),
                    counterText: '', // Hide default counter
                  ),
                  onChanged: (value) {
                    characterCount.value = value.length;
                  },
                ),
              ),

              // Character Count
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 8.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => Text(
                    '${characterCount.value}/500',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white.withOpacity(0.4),
                      fontFamily: 'SF Pro',
                    ),
                  )),
                ),
              ),

              SizedBox(height: 16.h),

              // Submit Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                    final feedback = feedbackController.text.trim();

                    if (feedback.isEmpty) {
                      Get.snackbar(
                        'Validation Error',
                        'Please enter your feedback',
                        backgroundColor: Colors.red.withOpacity(0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                      return;
                    }

                    isLoading.value = true;

                    // TODO: Call API to submit feedback
                    await Future.delayed(const Duration(seconds: 2));

                    isLoading.value = false;
                    Get.back();

                    Get.snackbar(
                      'Thank You!',
                      'Your feedback has been submitted successfully',
                      backgroundColor: Colors.green.withOpacity(0.9),
                      colorText: Colors.white,
                      icon: const Icon(Icons.check_circle,
                          color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    disabledBackgroundColor:
                    AppColors.primaryGold.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading.value
                      ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black),
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Submit Feedback',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              SizedBox(height: 12.h),

              // Maybe Later Button
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Maybe Later',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.6),
                    fontFamily: 'SF Pro',
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