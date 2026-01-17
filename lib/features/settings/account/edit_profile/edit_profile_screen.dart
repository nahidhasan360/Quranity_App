import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'edit_profile_controller.dart';
import 'edit_profile_strings.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

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
                      _buildProfilePhoto(controller),
                      SizedBox(height: 40.h),
                      _buildFormFields(controller),
                      SizedBox(height: 32.h),
                      _buildSaveButton(controller),
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
                EditProfileStrings.screenTitle,
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
  /// PROFILE PHOTO SECTION
  /// ============================================================================
  Widget _buildProfilePhoto(EditProfileController controller) {
    return Column(
      children: [
        // Profile Photo
        Obx(() {
          return GestureDetector(
            onTap: controller.changePhoto,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColors.primaryGold,
                shape: BoxShape.circle,
              ),
              child: controller.selectedImagePath.value.isEmpty
                  ? Icon(
                Icons.person,
                size: 60.sp,
                color: AppColors.textBlack,
              )
                  : ClipOval(
                child: Image.file(
                  File(controller.selectedImagePath.value),
                  fit: BoxFit.cover,
                  width: 120.w,
                  height: 120.h,
                ),
              ),
            ),
          );
        }),

        SizedBox(height: 16.h),

        // Change Photo Button
        GestureDetector(
          onTap: controller.changePhoto,
          child: Text(
            EditProfileStrings.changePhoto,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGold,
              letterSpacing: 1.2,
              fontFamily: 'SF Pro',
            ),
          ),
        ),
      ],
    );
  }

  /// ============================================================================
  /// FORM FIELDS
  /// ============================================================================
  Widget _buildFormFields(EditProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name Field
        _buildFieldLabel(EditProfileStrings.fullNameLabel),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: controller.fullNameController,
          icon: Icons.person_outline,
          hint: EditProfileStrings.fullNameHint,
        ),

        SizedBox(height: 24.h),

        // Email Field
        _buildFieldLabel(EditProfileStrings.emailAddressLabel),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: controller.emailController,
          icon: Icons.email_outlined,
          hint: EditProfileStrings.emailHint,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  /// Field Label
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary.withOpacity(0.6),
        letterSpacing: 1.2,
        fontFamily: 'SF Pro',
      ),
    );
  }

  /// Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          fontFamily: 'SF Pro',
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary.withOpacity(0.5),
            fontFamily: 'SF Pro',
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryGold,
            size: 20.sp,
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
  /// SAVE BUTTON
  /// ============================================================================
  Widget _buildSaveButton(EditProfileController controller) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.saveChanges,
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
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                color: AppColors.textBlack,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                EditProfileStrings.saveChangesButton,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack,
                  fontFamily: 'SF Pro',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}