import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'AboutQuranityStrings.dart';


class AboutQuranityScreen extends StatelessWidget {
  const AboutQuranityScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                      // Last Updated
                      _buildLastUpdated(),

                      SizedBox(height: 24.h),

                      // Section 1: Information We Collect
                      _buildSection(
                        title: AboutQuranityStrings.section1Title,
                        content: AboutQuranityStrings.section1Content,
                      ),

                      SizedBox(height: 20.h),

                      // Section 2: How We Use Information
                      _buildSection(
                        title: AboutQuranityStrings.section2Title,
                        content: AboutQuranityStrings.section2Content,
                      ),

                      SizedBox(height: 20.h),

                      // Section 3: Data Security
                      _buildSection(
                        title: AboutQuranityStrings.section3Title,
                        content: AboutQuranityStrings.section3Content,
                      ),

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
                AboutQuranityStrings.screenTitle,
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
  /// LAST UPDATED
  /// ============================================================================
  Widget _buildLastUpdated() {
    return Text(
      AboutQuranityStrings.lastUpdated,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary.withOpacity(0.5),
        letterSpacing: 1.2,
        fontFamily: 'SF Pro',
      ),
    );
  }

  /// ============================================================================
  /// SECTION
  /// ============================================================================
  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            fontFamily: 'SF Pro',
          ),
        ),

        SizedBox(height: 12.h),

        // Section Content
        Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary.withOpacity(0.8),
            height: 1.6,
            fontFamily: 'SF Pro',
          ),
        ),
      ],
    );
  }
}