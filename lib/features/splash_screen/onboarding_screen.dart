import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/custom_button.dart';
import 'package:quranity/features/splash_screen/onboarding_controller.dart';
import '../../core/constants/ app_strings.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              return _buildPage(controller.pages[index]);
            },
          ),

          // Skip Button
          Obx(
            () => controller.showSkipButton
                ? SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16),
                        child: InkWell(
                          onTap: controller.skipToEnd,
                          child: const Text(
                            AppStrings.skip,
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> data) {
    return Stack(
      children: [
        // Full Screen GIF
        Positioned.fill(child: Image.asset(data['image']!, fit: BoxFit.cover)),

        // Bottom Blur Section
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        data['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.54,
                          letterSpacing: -0.90,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        data['description']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFBFBFBF),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),

                      // Animated Indicator
                      SmoothPageIndicator(
                        controller: controller.pageController,
                        count: controller.pages.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: AppColors.indicatorActiveColor,
                          dotColor: AppColors.indicatorInactiveColor,
                          dotHeight: 6,
                          dotWidth: 22,
                          expansionFactor: 2.18,
                          spacing: 8,
                          radius: 10,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Continue Button
                      Obx(
                        () => CustomButton(
                          text: controller.isLastPage
                              ? AppStrings.getStarted
                              : AppStrings.continueText,
                          color: AppColors.buttonColor,
                          onPressed: controller.nextPage,
                          suffixIcon: Icons.arrow_forward,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
