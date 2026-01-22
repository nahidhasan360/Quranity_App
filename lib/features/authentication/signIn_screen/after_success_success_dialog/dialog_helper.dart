import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/customPrimaryButton.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onPressed, required bool showDisclaimer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3A352D),
              Color(0xFF1A1713),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.primaryGold.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryGold,
                    AppColors.primaryGold.withOpacity(0.7),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGold.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.black,
                size: 48.sp,
              ),
            ),

            SizedBox(height: 24.h),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textWhite,
                fontFamily: 'SF Pro',
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 12.h),

            // Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtitle,
                  fontFamily: 'SF Pro',
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Continue Button
            CustomPrimaryButton(
              text: buttonText ?? 'Conxcvctinue',
              isFilled: true,
              fontWeight: FontWeight.w700,
              height: 50.h,
              onPressed: onPressed ?? () => Get.back(),
              filledBackgroundColor: AppColors.primaryGold,
              filledTextColor: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}