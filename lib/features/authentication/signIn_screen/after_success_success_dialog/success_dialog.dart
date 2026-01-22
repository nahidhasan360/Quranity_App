import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/customPrimaryButton.dart';

import '../../../../core/constants/ app_strings.dart';


class SuccessDialog extends StatelessWidget {
  final VoidCallback? onPressed;

  const SuccessDialog({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2520),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primaryGold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Alert Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Alert Icon - No Circle
                    Icon(
                      Icons.warning_amber_outlined,
                      color: AppColors.primaryGold,
                      size: 23.sp,
                    ),

                    SizedBox(width: 10.w),
                    Text(
                      AppStrings.importantDisclaimer,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGold,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Disclaimer Text
                Text(
                  AppStrings.disclaimerText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textWhite.withOpacity(0.8),
                    fontFamily: 'SF Pro',
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 24.h),

                // Continue Button
                CustomPrimaryButton(
                  text: AppStrings.iUnderStand,
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
        ),
      ),
    );
  }
}