import 'package:get/get.dart';
import 'package:quranity/features/splash_screen/splash_screen.dart';
import 'package:quranity/features/splash_screen/onboarding_screen.dart';
import 'package:quranity/features/home/home_screen.dart';

import '../../features/MuslimAIScreen/Muslim_AI_Screen .dart';
import '../../features/MuslimAIScreen/chat_Screen/chat_binding.dart';
import '../../features/MuslimAIScreen/chat_Screen/chat_screen.dart';
import '../../features/ShortsScreen/Shorts_Screen.dart';
import '../../features/ShortsScreen/shorts_binding.dart';
import '../../features/authentication/forgot_password_screen.dart/forgot_password_binding.dart';
import '../../features/authentication/forgot_password_screen.dart/forgot_password_screen.dart';
import '../../features/authentication/registration_screen.dart';
import '../../features/authentication/reset_password/reset_binding.dart';
import '../../features/authentication/reset_password/reset_password.dart';
import '../../features/authentication/signIn_screen/login_binding.dart';
import '../../features/authentication/signIn_screen/login_screen.dart';
import '../../features/authentication/signup_screen/signup_binding.dart';
import '../../features/authentication/signup_screen/signup_screen.dart';
import '../../features/home/home_binding.dart';
import '../../features/quranScreen/quran_screen.dart';
import '../../features/splash_screen/onboarding_binding/onboarding_binding.dart';
import '../../features/stories_screen/stories_binding.dart';
import '../../features/stories_screen/stories_screen.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/SplashScreen';
  static const String onboarding = '/OnboardingScreen';
  static const String registrationScreen = '/RegistrationScreen';
  static const String home = '/IslamicPrayerTimesPage';
  static const String signup = '/SignupScreen';
  static const String verifyEmail = '/verify-email';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String login = '/login';

  // quran
  static const String quranScreen = '/QuranScreen';
  // quran
  static const String muslimAI = '/MuslimAIScreen';
  static const String chat = '/chat';
  static const String shorts = '/shorts';
  static const String stories = '/stories';


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
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: registrationScreen,
      page: () => const RegistrationScreen(),
      // binding: OnboardingBinding(),
      // transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    // Sign Up Screen
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(), // LazyPut binding
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //  Login Route
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: quranScreen,
      page: () => QuranScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //--------------------------------- Ai screen routes ------------------
    // Add to your routes
    GetPage(name: AppRoutes.muslimAI, page: () => const MuslimAIScreen()),

    GetPage(
      name: chat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // STORIES - INDEX 3
    GetPage(
      name: AppRoutes.shorts,
      page: () => const ShortsScreen(),
      binding: ShortsBinding(),
    ),



    //--------------------------------- stories screen routes ------------------
    GetPage(
      name: AppRoutes.stories,
      page: () => const StoriesScreen(),
      binding: StoriesBinding(),
    ),



    // --------------------------------- quran screen routes ------------------
  ];
}
