import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import 'contract_screen/contract_screen.dart';
import 'feedback/feedback.dart';
import 'help_faq_screen/help_faq_screen.dart';

class SupportController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('💬 Support screen initialized');
  }

  /// ============================================================================
  /// HELP & FAQ
  /// ============================================================================
  void openHelpAndFaq() {
    // Use direct navigation until route is registered
    Get.to(() => const HelpFaqScreen());

    Get.toNamed(AppRoutes.helpFaq);

    print('📚 Navigate to Help & FAQ');
  }

  /// ============================================================================
  /// CONTACT SUPPORT
  /// ============================================================================
  void openContactSupport() {
    // // Use direct navigation until route is registered
    // Get.to(() => const ContactSupportScreen());
    //
    // // After adding route to app_pages.dart, use:
    Get.toNamed(AppRoutes.contactSupport);

    print('📧 Navigate to Contact Support');
  }

  /// ============================================================================
  /// SHARE YOUR THOUGHTS (FEEDBACK)
  /// ============================================================================
  void openShareYourThoughts() {
    // Show dialog directly (no route needed)
    FeedbackDialog.show();

    print('💭 Show Feedback Dialog');
  }
}
