import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contact_strings.dart';

class ContactSupportController extends GetxController {
  // Form Controllers
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  // Observable States
  final isLoading = false.obs;

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  /// Validate Form
  bool _validateForm() {
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    if (subject.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: 'Please enter a subject',
      );
      return false;
    }

    if (message.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ContactSupportStrings.messageRequired,
      );
      return false;
    }

    if (message.length < 10) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ContactSupportStrings.messageTooShort,
      );
      return false;
    }

    return true;
  }

  /// Send Message
  Future<void> sendMessage() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Call API to send support message
      // await supportApi.sendMessage(
      //   subject: subjectController.text,
      //   message: messageController.text,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Show success message
      _showSuccessSnackbar(
        title: ContactSupportStrings.messageSentTitle,
        message: ContactSupportStrings.messageSentMessage,
      );

      // Clear fields
      subjectController.clear();
      messageController.clear();

      // Go back after delay
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();

      print('✅ Support message sent');

    } catch (e) {
      isLoading.value = false;

      _showErrorSnackbar(
        title: ContactSupportStrings.sendFailedTitle,
        message: ContactSupportStrings.sendFailedMessage,
      );

      print('❌ Error sending message: $e');
    }
  }

  /// Show Success Snackbar
  void _showSuccessSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show Error Snackbar
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