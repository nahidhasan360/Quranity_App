import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/features/settings/legal_screen/privacy_policy/privacy_policy_screen.dart';
import 'package:quranity/features/settings/legal_screen/terms%20&%20conditions/terms_and_condition.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'acknowledgements_screen/acknowledgements_screen.dart';
import 'legal_strings.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

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
                    children: [
                      SizedBox(height: 24.h),

                      // Privacy Policy
                      _buildLegalItem(
                        icon: Icons.lock_outline,
                        title: LegalStrings.privacyPolicy,
                        onTap: () => Get.to(() => const PrivacyPolicyScreen()),
                      ),

                      SizedBox(height: 12.h),

                      // Terms & Conditions
                      _buildLegalItem(
                        icon: Icons.description_outlined,
                        title: LegalStrings.termsAndConditions,
                        onTap: () => Get.to(() => const TermsConditionsScreen()),
                      ),

                      SizedBox(height: 12.h),

                      // Acknowledgements
                      _buildLegalItem(
                        icon: Icons.thumb_up_outlined,
                        title: LegalStrings.acknowledgements,
                        onTap: () => Get.to(() => const AcknowledgementsScreen()),
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
                LegalStrings.screenTitle,
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
  /// LEGAL ITEM
  /// ============================================================================
  Widget _buildLegalItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryGold,
                size: 20.sp,
              ),
            ),

            SizedBox(width: 16.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: AppColors.iconWhite.withOpacity(0.6),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
