import 'package:get/get.dart';
import 'package:quranity/features/splash_screen/splash_screen.dart';
import 'package:quranity/features/splash_screen/onboarding_screen.dart';
import 'package:quranity/features/home/home_screen.dart';

import '../../features/MuslimAIScreen/Muslim_AI_Screen .dart';
import '../../features/MuslimAIScreen/chat_Screen/chat_binding.dart';
import '../../features/MuslimAIScreen/chat_Screen/chat_screen.dart';
import '../../features/Quran/Quran_List_View.dart';
import '../../features/Quran/hadith/hadith_list_binding.dart';
import '../../features/Quran/hadith/hadith_list_view.dart';
import '../../features/Quran/quran_list_binding.dart';
import '../../features/Quran/surah_detail_view/surah_detail_binding.dart';
import '../../features/Quran/surah_detail_view/surah_detail_view.dart';
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
import '../../features/settings/Support/contract_screen/contact_controller.dart';
import '../../features/settings/Support/contract_screen/contract_screen.dart';
import '../../features/settings/Support/feedback/feedback.dart';
import '../../features/settings/Support/help_faq_screen/faq_controller.dart';
import '../../features/settings/Support/help_faq_screen/help_faq_screen.dart';
import '../../features/settings/Support/support_screen.dart';
import '../../features/settings/about_quranity/about_quranity.dart';
import '../../features/settings/account/account_binding.dart';
import '../../features/settings/account/account_screen.dart';
import '../../features/settings/account/change_password/change_password.dart';
import '../../features/settings/account/edit_profile/edit_profile_screen.dart';
import '../../features/settings/account/subscription_screen/subscription_screen.dart';
import '../../features/settings/legal_screen/legal_screen.dart';
import '../../features/settings/settings/settings.dart';
import '../../features/splash_screen/onboarding_binding/onboarding_binding.dart';
import '../../features/stories_screen/playing_videos/playing_videos.dart';
import '../../features/stories_screen/playing_videos/playing_videos_binding.dart';
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
  static const quranScreen = '/quran-list'; // ✅ Surah list
  static const surahDetail = '/surah-detail'; // ✅ Surah detail

  // quran
  static const String muslimAI = '/MuslimAIScreen';
  static const String chat = '/chat';
  static const String shorts = '/shorts';
  static const String stories = '/stories';
  static const String videoPlayer = '/PlayingVideos';

  // HADITH ROUTES
  static const hadith = '/hadith';
  static const hadithList = '/hadith-list'; // ✅
  static const hadithCollection = '/hadith-collection';
  static const hadithDetail = '/hadith-detail';

  // =============================================================================
  static const accountScreen = '/AccountScreen';
  static const editProfileScreen = '/EditProfileScreen';
  static const changePasswordScreen = '/ChangePasswordScreen';
  static const subscriptionScreen = '/SubscriptionScreen';

  // =========================== settings =================================
  static const settingsScreen = '/SettingsScreen';
  static const supportScreen = '/SupportScreen';
  static const feedbackDialog = '/FeedbackDialog';


  // Support System Routes
  static const String helpFaq = '/help-faq';
  static const String contactSupport = '/contact-support';
  static const String feedback = '/feedback';


  //=======================  about quranity ========================


  static const String aboutQuranityScreen = '/AboutQuranityScreen';

  // ==========================   legal =========================
  static const String legalScreen = '/LegalScreen';



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
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //--------------------------------- stories screen routes ------------------
    GetPage(
      name: AppRoutes.stories,
      page: () => StoriesScreen(),
      binding: StoriesBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const PlayingVideos(), // ✅ Add const
      binding: PlayingVideosBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // --------------------------------- quran screen routes ------------------

    // Quran List Route
    GetPage(
      name: AppRoutes.quranScreen, // ✅ Route name
      page: () => const QuranListView(), // ✅ View widget
      binding: QuranListBinding(), // ✅ Binding (IMPORTANT!)
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300), // ✅ Animation
    ),

    GetPage(
      name: AppRoutes.hadith,
      page: () => const HadithListView(),
      binding: HadithListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.surahDetail,
      page: () => const SurahDetailView(),
      binding: SurahDetailBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.accountScreen,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
      transition: Transition.rightToLeft,
    ),

    //==============================   account screen ar child ===================
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: changePasswordScreen,
      page: () => const ChangePasswordScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: subscriptionScreen,
      page: () => const SubscriptionScreen(),
      transition: Transition.rightToLeft,
    ),



    GetPage(
      name: settingsScreen,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeft,
    ),


    // ============================== support screen  ======================
    GetPage(
      name: supportScreen,
      page: () => const SupportScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.helpFaq,
      page: () => const HelpFaqScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.contactSupport,
      page: () => const ContactSupportScreen(),
      transition: Transition.rightToLeft,
    ),


    //============================  about quranity ===================================

    GetPage(
      name: AppRoutes.aboutQuranityScreen,
      page: () => const AboutQuranityScreen(),
      transition: Transition.rightToLeft,
    ),


    //============================  legal quranity ===================================
    GetPage(
      name: AppRoutes.legalScreen,
      page: () => const LegalScreen(),
      transition: Transition.rightToLeft,
    ),



    // =========================== menu section ===========================
    // GetPage(name: '/account', page: () => AccountScreen()),
    // GetPage(name: '/settings', page: () => SettingsScreen()),
    // GetPage(name: '/support', page: () => SupportScreen()),
    // GetPage(name: '/about', page: () => AboutQuranityScreen()),
    // GetPage(name: '/legal', page: () => LegalScreen()),
    //
  ];
}
