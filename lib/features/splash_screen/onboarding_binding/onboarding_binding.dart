import 'package:get/get.dart';
import 'package:quranity/features/splash_screen/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(
      OnboardingController(),
      permanent: true, // Will be removed when page is closed
    );
    print(' OnboardingBinding: OnboardingController initialized');
  }
}