import 'package:get/get.dart';
import 'package:quranity/features/splash_screen/splash_screen.dart';
import 'package:quranity/features/splash_screen/onboarding_screen.dart';
import 'package:quranity/features/home/home_screen.dart';

import '../../features/splash_screen/onboarding_binding/onboarding_binding.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/SplashScreen';
  static const String onboarding = '/OnboardingScreen';
  static const String home = '/IslamicPrayerTimesPage';

  // All Routes with Bindings
  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding:
          OnboardingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => const IslamicPrayerTimesPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
