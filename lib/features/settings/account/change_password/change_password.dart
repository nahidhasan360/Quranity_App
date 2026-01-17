import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'change_password_controller.dart';
import 'change_password_strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

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
                      SizedBox(height: 32.h),
                      _buildPasswordFields(controller),
                      SizedBox(height: 32.h),
                      _buildChangeButton(controller),
                      SizedBox(height: 16.h),
                      _buildForgotPasswordButton(controller),
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
                ChangePasswordStrings.screenTitle,
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
  /// PASSWORD FIELDS
  /// ============================================================================
  Widget _buildPasswordFields(ChangePasswordController controller) {
    return Column(
      children: [
        // Current Password
        Obx(() => _buildPasswordField(
          controller: controller.currentPasswordController,
          label: ChangePasswordStrings.currentPasswordLabel,
          isVisible: controller.isCurrentPasswordVisible.value,
          onToggleVisibility: controller.toggleCurrentPasswordVisibility,
        )),

        SizedBox(height: 16.h),

        // New Password
        Obx(() => _buildPasswordField(
          controller: controller.newPasswordController,
          label: ChangePasswordStrings.newPasswordLabel,
          isVisible: controller.isNewPasswordVisible.value,
          onToggleVisibility: controller.toggleNewPasswordVisibility,
        )),

        SizedBox(height: 16.h),

        // Confirm New Password
        Obx(() => _buildPasswordField(
          controller: controller.confirmPasswordController,
          label: ChangePasswordStrings.confirmNewPasswordLabel,
          isVisible: controller.isConfirmPasswordVisible.value,
          onToggleVisibility: controller.toggleConfirmPasswordVisibility,
        )),
      ],
    );
  }

  /// Password Field
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          fontFamily: 'SF Pro',
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary.withOpacity(0.6),
            fontFamily: 'SF Pro',
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: AppColors.primaryGold,
            size: 20.sp,
          ),
          suffixIcon: GestureDetector(
            onTap: onToggleVisibility,
            child: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.textPrimary.withOpacity(0.6),
              size: 20.sp,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  /// ============================================================================
  /// CHANGE BUTTON
  /// ============================================================================
  Widget _buildChangeButton(ChangePasswordController controller) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.changePassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGold,
            disabledBackgroundColor: AppColors.primaryGold.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? SizedBox(
            width: 24.w,
            height: 24.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.textBlack,
              ),
            ),
          )
              : Text(
            ChangePasswordStrings.changeAndSaveButton,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlack,
              fontFamily: 'SF Pro',
            ),
          ),
        ),
      );
    });
  }

  /// ============================================================================
  /// FORGOT PASSWORD BUTTON
  /// ============================================================================
  Widget _buildForgotPasswordButton(ChangePasswordController controller) {
    return GestureDetector(
      onTap: controller.forgotPassword,
      child: Text(
        ChangePasswordStrings.forgotPasswordButton,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryGold,
          fontFamily: 'SF Pro',
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryGold,
        ),
      ),
    );
  }
}