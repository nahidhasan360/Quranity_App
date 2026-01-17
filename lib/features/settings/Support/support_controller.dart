import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/features/settings/Support/support_strings.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // TODO: Navigate to Help & FAQ screen
    // Get.toNamed('/help-faq');

    Get.snackbar(
      'Help & FAQ',
      'Navigate to Help & FAQ screen',
      backgroundColor: Colors.blue.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );

    print('📚 Navigate to Help & FAQ');
  }

  /// ============================================================================
  /// CONTACT SUPPORT
  /// ============================================================================
  void openContactSupport() async {
    // Open email client
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: SupportStrings.supportEmail,
      queryParameters: {
        'subject': SupportStrings.emailSubject,
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        print('📧 Email client opened');
      } else {
        _showErrorSnackbar(
          title: 'Error',
          message: 'Could not open email client',
        );
      }
    } catch (e) {
      print('❌ Error opening email: $e');
      _showErrorSnackbar(
        title: 'Error',
        message: 'Failed to open email client',
      );
    }
  }

  /// ============================================================================
  /// SHARE YOUR THOUGHTS
  /// ============================================================================
  void openShareYourThoughts() {
    // TODO: Navigate to Feedback screen
    // Get.toNamed('/feedback');

    Get.snackbar(
      'Share Your Thoughts',
      'Navigate to Feedback screen',
      backgroundColor: Colors.purple.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );

    print('💭 Navigate to Share Your Thoughts');
  }

  /// ============================================================================
  /// SNACKBAR HELPERS
  /// ============================================================================
  void _showErrorSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}