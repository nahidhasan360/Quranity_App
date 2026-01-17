import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'faq_controller.dart';
import 'faq_strings.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpFaqController());

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

                      // Header Message
                      _buildHeaderMessage(),

                      SizedBox(height: 24.h),

                      // FAQ Items
                      Obx(() => _buildFaqItem(
                        question: HelpFaqStrings.question1,
                        answer: HelpFaqStrings.answer1,
                        isExpanded: controller.expanded1.value,
                        onTap: () => controller.toggleFaq(1),
                      )),

                      SizedBox(height: 12.h),

                      Obx(() => _buildFaqItem(
                        question: HelpFaqStrings.question2,
                        answer: HelpFaqStrings.answer2,
                        isExpanded: controller.expanded2.value,
                        onTap: () => controller.toggleFaq(2),
                      )),

                      SizedBox(height: 12.h),

                      Obx(() => _buildFaqItem(
                        question: HelpFaqStrings.question3,
                        answer: HelpFaqStrings.answer3,
                        isExpanded: controller.expanded3.value,
                        onTap: () => controller.toggleFaq(3),
                      )),

                      SizedBox(height: 12.h),

                      Obx(() => _buildFaqItem(
                        question: HelpFaqStrings.question4,
                        answer: HelpFaqStrings.answer4,
                        isExpanded: controller.expanded4.value,
                        onTap: () => controller.toggleFaq(4),
                      )),

                      SizedBox(height: 12.h),

                      Obx(() => _buildFaqItem(
                        question: HelpFaqStrings.question5,
                        answer: HelpFaqStrings.answer5,
                        isExpanded: controller.expanded5.value,
                        onTap: () => controller.toggleFaq(5),
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
                HelpFaqStrings.screenTitle,
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
  /// HEADER MESSAGE
  /// ============================================================================
  Widget _buildHeaderMessage() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        HelpFaqStrings.headerMessage,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryGold,
          height: 1.5,
          fontFamily: 'SF Pro',
        ),
      ),
    );
  }

  /// ============================================================================
  /// FAQ ITEM
  /// ============================================================================
  Widget _buildFaqItem({
    required String question,
    required String answer,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.iconWhite.withOpacity(0.6),
                    size: 24.sp,
                  ),
                ),
              ],
            ),

            // Answer (Expandable)
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary.withOpacity(0.7),
                    height: 1.5,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}