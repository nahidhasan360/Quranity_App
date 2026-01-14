import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/features/authentication/reset_password/reset_controller.dart';
import '../../../core/constants/ app_strings.dart';
import '../../../widgets/customPrimaryButton.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/reusable_gradient.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    // ✅ CRITICAL FIX: Prevent interaction during navigation
    return PopScope(
      canPop: false, // Disable back button
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !controller.isLoading.value) {
          Get.back();
        }
      },
      child: Obx(() => AbsorbPointer(
        // ✅ Disable all touches when loading
        absorbing: controller.isLoading.value,
        child: Scaffold(
          body: GradientBackground(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),

                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textWhite,
                          size: 20.sp,
                          weight: 600,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Reset Icon
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.sync_rounded,
                          size: 32.sp,
                          color: AppColors.black,
                          weight: 600,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      AppStrings.resetPasswordTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w700,
                        height: 1.54,
                        letterSpacing: -0.90,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Subtitle
                    Text(
                      AppStrings.resetPasswordSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        color: AppColors.subtitle,
                        height: 1.43,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // New Password Field
                    Obx(() => CustomTextField(
                      hintText: AppStrings.newPasswordHint,
                      controller: controller.newPasswordController,
                      prefixIconPath: 'lock',
                      obscureText: controller.isNewPasswordHidden.value,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      enabled: !controller.isLoading.value, // ✅ Disable when loading
                      suffixIcon: IconButton(
                        onPressed: controller.toggleNewPasswordVisibility,
                        icon: Icon(
                          controller.isNewPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.hintText,
                          size: 20.sp,
                        ),
                      ),
                    )),

                    SizedBox(height: 16.h),

                    // Confirm Password Field
                    Obx(() => CustomTextField(
                      hintText: AppStrings.confirmNewPasswordHint,
                      controller: controller.confirmPasswordController,
                      prefixIconPath: 'lock',
                      obscureText: controller.isConfirmPasswordHidden.value,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      enabled: !controller.isLoading.value, // ✅ Disable when loading
                      suffixIcon: IconButton(
                        onPressed: controller.toggleConfirmPasswordVisibility,
                        icon: Icon(
                          controller.isConfirmPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.hintText,
                          size: 20.sp,
                        ),
                      ),
                    )),

                    const Spacer(),

                    // Save & Sign In Button
                    Obx(() => CustomPrimaryButton(
                      text: controller.isLoading.value
                          ? AppStrings.savingButton
                          : AppStrings.saveAndSignInButton,
                      isFilled: true,
                      fontWeight: FontWeight.w700,
                      height: 56.h,
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.resetPassword,
                      filledBackgroundColor: AppColors.primaryGold,
                      filledTextColor: AppColors.black,
                    )),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}