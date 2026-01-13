import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import '../../core/constants/ app_strings.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;

  // Onboarding Data
  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/giftoonbord1.gif',
      'title': AppStrings.onboarding1Title,
      'description': AppStrings.onboarding1Description,
    },
    {
      'image': 'assets/images/onboarding2.gif',
      'title': AppStrings.onboarding2Title,
      'description': AppStrings.onboarding2Description,
    },
    {
      'image': 'assets/images/onboarding3.gif',
      'title': AppStrings.onboarding3Title,
      'description': AppStrings.onboarding3Description,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    print('❌ OnboardingController: Disposed');
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    print('📄 Page changed to: $index');
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void skipToEnd() {
    Get.offAllNamed(AppRoutes.home);
  }

  bool get isLastPage => currentPage.value == pages.length - 1;
  bool get showSkipButton => !isLastPage;
}