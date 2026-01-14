import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/core/constants/app_assets.dart';
import 'package:quranity/features/authentication/signup_screen/signup_controller.dart';
import '../../../widgets/customPrimaryButton.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/reusable_gradient.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),

                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textWhite,
                      size: 20.sp,
                      weight: 600, // ✅ Fixed: Changed from fontWeight to weight
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Profile Icon
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.userProfileIcon,
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.contain, // ✅ Added fit
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Title
                Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 1.54,
                    letterSpacing: -0.90,
                  ),
                ),

                SizedBox(height: 5.h),

                // Subtitle
                Text(
                  'Join our community and start your spiritual journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitle,
                    fontSize: 14,
                    fontFamily: 'SF Pro',
                    height: 2.09,
                  ),
                ),

                SizedBox(height: 40.h),

                // Full Name Field
                CustomTextField(
                  hintText: 'Full Name',
                  controller: controller.fullNameController,
                  prefixIconPath: AppAssets.userIcon,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16.h),

                // Email Field
                CustomTextField(
                  hintText: 'Email Address',
                  controller: controller.emailController,
                  prefixIconPath: AppAssets.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16.h),

                // Password Field
                Obx(
                  () => CustomTextField(
                    hintText: 'New Password',
                    controller: controller.passwordController,
                    prefixIconPath: AppAssets.lockIcon,
                    obscureText: controller.isPasswordHidden.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePasswordVisibility,
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.hintText,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Confirm Password Field
                Obx(
                  () => CustomTextField(
                    hintText: 'Confirm New Password',
                    controller: controller.confirmPasswordController,
                    prefixIconPath: AppAssets.lockIcon,
                    obscureText: controller.isConfirmPasswordHidden.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
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
                  ),
                ),

                SizedBox(height: 10.h),

                // Terms and Conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: controller.toggleTermsAccepted,
                        child: Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            color: controller.isTermsAccepted.value
                                ? AppColors.primaryGold
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3.r),
                            border: Border.all(
                              color: controller.isTermsAccepted.value
                                  ? AppColors.primaryGold
                                  : AppColors.hintText,
                              width: 1.5,
                            ),
                          ),
                          child: controller.isTermsAccepted.value
                              ? Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 10.sp,
                                    color: AppColors.black,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Agree with ',
                          style: TextStyle(
                            color: AppColors.hintText,
                            fontSize: 12.sp,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: AppColors.hintText,
                                fontSize: 12.sp,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.hintText,
                                height: 1.43,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                // Sign Up Button
                CustomPrimaryButton(
                  text: 'Sign Up',
                  isFilled: true,
                  fontWeight: FontWeight.w700,
                  height: 56.h,
                  onPressed: controller.signUp,
                  // onPressed:
                  // () => Get.toNamed(AppRoutes.verifyEmail),

                ),

                SizedBox(height: 100.h),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subtitle,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToSignIn,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGold,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
