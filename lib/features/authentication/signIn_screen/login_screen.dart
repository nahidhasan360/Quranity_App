import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../../../core/constants/ app_strings.dart';
import '../../../widgets/customPrimaryButton.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/reusable_gradient.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),

                    // ============================================================
                    // BACK BUTTON
                    // ============================================================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textWhite,
                          size: 20.sp,
                          weight: 600,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // ============================================================
                    // USER ICON
                    // ============================================================
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 32.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // ============================================================
                    // TITLE - "Welcome Back"
                    // ============================================================
                    Text(
                      AppStrings.loginTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w700,
                        height: 1.54,
                        letterSpacing: -0.90,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // ============================================================
                    // SUBTITLE
                    // ============================================================
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        AppStrings.loginSubtitle,
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

                    // ============================================================
                    // EMAIL FIELD
                    // ============================================================
                    CustomTextField(
                      hintText: AppStrings.emailAddressHint,
                      controller: controller.emailController,
                      prefixIconPath: 'email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),

                    SizedBox(height: 16.h),

                    // ============================================================
                    // PASSWORD FIELD
                    // ============================================================
                    Obx(
                      () => CustomTextField(
                        hintText: AppStrings.passwordHint,
                        controller: controller.passwordController,
                        prefixIconPath: 'lock',
                        obscureText: controller.isPasswordHidden.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
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

                    SizedBox(height: 10.h),

                    // ============================================================
                    // REMEMBER ME & FORGOT PASSWORD ROW
                    // ============================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me Checkbox
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: controller.toggleRememberMe,
                                child: Container(
                                  width: 15.w,
                                  height: 15.h,
                                  decoration: BoxDecoration(
                                    color: controller.isRememberMe.value
                                        ? AppColors.primaryGold
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: controller.isRememberMe.value
                                          ? AppColors.primaryGold
                                          : AppColors.hintText,
                                      width: 1,
                                    ),
                                  ),
                                  child: controller.isRememberMe.value
                                      ? Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 12.sp,
                                            color: AppColors.black,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.rememberMeLabel,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textWhite,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ],
                        ),

                        // Forgot Password Link
                        GestureDetector(
                          onTap: controller.navigateToForgotPassword,
                          child: Text(
                            AppStrings.forgotPasswordLink,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGold,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // ============================================================
                    // SIGN IN BUTTON
                    // ============================================================
                    Obx(
                      () => CustomPrimaryButton(
                        text: controller.isLoading.value
                            ? AppStrings.signingIn
                            : AppStrings.signInButton,
                        isFilled: true,
                        fontWeight: FontWeight.w700,
                        height: 56.h,
                        onPressed: controller.isLoading.value
                            ? () {}
                            : controller.signIn,
                        filledBackgroundColor: AppColors.primaryGold,
                        filledTextColor: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 100.h),

                    // ============================================================
                    // DON'T HAVE ACCOUNT - SIGN UP LINK
                    // ============================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.dontHaveAccountText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitle,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.navigateToSignUp,
                          child: Text(
                            AppStrings.signUpLink,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGold,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
