import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'contact_controller.dart';
import 'contact_strings.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactSupportController());

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

                      // Subject Field
                      _buildFieldLabel(ContactSupportStrings.subjectLabel),
                      SizedBox(height: 8.h),
                      _buildSubjectField(controller),

                      SizedBox(height: 24.h),

                      // Message Field
                      _buildFieldLabel(ContactSupportStrings.messageLabel),
                      SizedBox(height: 8.h),
                      _buildMessageField(controller),

                      SizedBox(height: 32.h),

                      // Send Button
                      _buildSendButton(controller),

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
                ContactSupportStrings.screenTitle,
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
  /// FIELD LABEL
  /// ============================================================================
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

  /// ============================================================================
  /// SUBJECT FIELD (Now Editable!)
  /// ============================================================================
  Widget _buildSubjectField(ContactSupportController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller.subjectController,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          fontFamily: 'SF Pro',
        ),
        decoration: InputDecoration(
          hintText: ContactSupportStrings.subjectHint,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary.withOpacity(0.4),
            fontFamily: 'SF Pro',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }

  /// ============================================================================
  /// MESSAGE FIELD
  /// ============================================================================
  Widget _buildMessageField(ContactSupportController controller) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller.messageController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          fontFamily: 'SF Pro',
        ),
        decoration: InputDecoration(
          hintText: ContactSupportStrings.messageHint,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary.withOpacity(0.4),
            fontFamily: 'SF Pro',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  /// ============================================================================
  /// SEND BUTTON
  /// ============================================================================
  Widget _buildSendButton(ContactSupportController controller) {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: controller.isLoading.value
            ? null
            : controller.sendMessage,
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
              Icons.send,
              color: AppColors.textBlack,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              ContactSupportStrings.sendMessageButton,
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
    ));
  }
}