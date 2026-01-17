import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'subscription_controller.dart';
import 'subscription_strings.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

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

                      // Basic Plan (Free)
                      Obx(() => _buildPlanCard(
                        controller: controller,
                        planType: PlanType.basic,
                        planName: SubscriptionStrings.basicPlan,
                        price: SubscriptionStrings.freePlanPrice,
                        features: const [
                          SubscriptionStrings.standardAccess,
                          SubscriptionStrings.dailyVerses,
                        ],
                        showBadge: false,
                        isCurrentPlan: controller.isCurrentPlan(PlanType.basic),
                      )),

                      SizedBox(height: 16.h),

                      // Premium Plan
                      Obx(() => _buildPlanCard(
                        controller: controller,
                        planType: PlanType.premium,
                        planName: SubscriptionStrings.premiumPlan,
                        price: SubscriptionStrings.premiumPlanPrice,
                        features: const [
                          SubscriptionStrings.unlimitedAIAccess,
                          SubscriptionStrings.videoResolutions4K,
                          SubscriptionStrings.offlineMode,
                          SubscriptionStrings.prioritySupport,
                        ],
                        showBadge: true,
                        isCurrentPlan: controller.isCurrentPlan(PlanType.premium),
                      )),

                      SizedBox(height: 16.h),

                      // Ramadan Special Plan
                      Obx(() => _buildPlanCard(
                        controller: controller,
                        planType: PlanType.ramadanSpecial,
                        planName: SubscriptionStrings.ramadanSpecialPlan,
                        price: SubscriptionStrings.ramadanSpecialPrice,
                        features: const [
                          SubscriptionStrings.unlimitedAIAccess,
                          SubscriptionStrings.videoResolutions4K,
                          SubscriptionStrings.offlineMode,
                          SubscriptionStrings.prioritySupport,
                        ],
                        showBadge: true,
                        isCurrentPlan: controller.isCurrentPlan(PlanType.ramadanSpecial),
                      )),

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
                SubscriptionStrings.screenTitle,
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
  /// PLAN CARD
  /// ============================================================================
  Widget _buildPlanCard({
    required SubscriptionController controller,
    required PlanType planType,
    required String planName,
    required String price,
    required List<String> features,
    required bool showBadge,
    required bool isCurrentPlan,
  }) {
    final isPremiumPlan = planType != PlanType.basic;

    return Container(
      decoration: BoxDecoration(
        color: isPremiumPlan
            ? const Color(0xFF2A2A2A)
            : const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(16.r),
        border: isPremiumPlan && !isCurrentPlan
            ? Border.all(
          color: AppColors.primaryGold,
          width: 2,
        )
            : null,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan Name & Icon
                Row(
                  children: [
                    // Star Icon (for Premium plans)
                    if (isPremiumPlan) ...[
                      Icon(
                        Icons.star,
                        color: AppColors.primaryGold,
                        size: 14.sp,
                      ),
                      SizedBox(width: 8.w),
                    ],
                    // Plan Name
                    Text(
                      planName,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isPremiumPlan
                            ? AppColors.primaryGold
                            : AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 1.2,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    const Spacer(),
                    // Person Icon (for Basic plan only)
                    if (!isPremiumPlan)
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: AppColors.textPrimary.withOpacity(0.6),
                          size: 18.sp,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: isPremiumPlan ? 36.sp : 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    if (isPremiumPlan) ...[
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          SubscriptionStrings.perMonth,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary.withOpacity(0.6),
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 16.h),

                // Features
                ...features.asMap().entries.map((entry) =>
                    _buildFeatureItem(entry.value, isPremiumPlan)
                ),

                SizedBox(height: 16.h),

                // Action Button
                _buildActionButton(
                  controller: controller,
                  planType: planType,
                  isCurrentPlan: isCurrentPlan,
                  isPremiumPlan: isPremiumPlan,
                ),
              ],
            ),
          ),

          // Most Popular Badge
          if (showBadge && !isCurrentPlan)
            Positioned(
              top: 16.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  SubscriptionStrings.mostPopularBadge,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0.8,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Feature Item
  Widget _buildFeatureItem(String feature, bool isPremiumPlan) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: isPremiumPlan
                ? AppColors.primaryGold
                : AppColors.textPrimary.withOpacity(0.7),
            size: 16.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary.withOpacity(0.9),
                fontFamily: 'SF Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Action Button
  Widget _buildActionButton({
    required SubscriptionController controller,
    required PlanType planType,
    required bool isCurrentPlan,
    required bool isPremiumPlan,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        onPressed: isCurrentPlan
            ? null
            : () {
          if (planType == PlanType.premium) {
            controller.upgradeToPremium();
          } else if (planType == PlanType.ramadanSpecial) {
            controller.upgradeToRamadanSpecial();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isCurrentPlan
              ? AppColors.textPrimary.withOpacity(0.15)
              : AppColors.primaryGold,
          disabledBackgroundColor: AppColors.textPrimary.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          isCurrentPlan
              ? SubscriptionStrings.currentPlanButton
              : SubscriptionStrings.upgradeToPremiumButton,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isCurrentPlan
                ? AppColors.textPrimary.withOpacity(0.7)
                : Colors.black,
            fontFamily: 'SF Pro',
          ),
        ),
      ),
    );
  }
}