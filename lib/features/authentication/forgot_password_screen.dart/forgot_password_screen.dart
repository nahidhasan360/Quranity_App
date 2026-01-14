import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/features/authentication/forgot_password_screen.dart/forgot_password_controller.dart';
import '../../../core/constants/ app_strings.dart';
import '../../../widgets/customPrimaryButton.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/reusable_gradient.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Use Get.put instead of Get.find
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
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
                    onTap: controller.navigateToSignIn,
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
                      Icons.refresh_rounded,
                      size: 32.sp,
                      color: AppColors.black,
                      weight: 600,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Title
                Text(
                  AppStrings.forgotPasswordTitle,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    AppStrings.forgotPasswordSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitle,
                      height: 1.43,
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Email Field
                CustomTextField(
                  hintText: AppStrings.emailAddressPlaceholder,
                  controller: controller.emailController,
                  prefixIconPath: 'email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),

                const Spacer(),

                // Send Button
                Obx(() => CustomPrimaryButton(
                  text: controller.isLoading.value
                      ? AppStrings.sendingLinkButton
                      : AppStrings.sendResetLinkButton,
                  isFilled: true,
                  fontWeight: FontWeight.w700,
                  height: 56.h,
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.sendResetLink,
                  filledBackgroundColor: AppColors.primaryGold,
                  filledTextColor: AppColors.black,
                )),

                SizedBox(height: 16.h),

                // Back to Sign In
                GestureDetector(
                  onTap: controller.navigateToSignIn,
                  child: Text(
                    AppStrings.backToSignInLink,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitle,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}