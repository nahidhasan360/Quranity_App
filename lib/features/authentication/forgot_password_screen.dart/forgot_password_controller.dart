import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/custom_otp/otp_helper.dart';

import '../../../core/constants/ app_strings.dart' show AppStrings;

class ForgotPasswordController extends GetxController {
  // Text Controller
  final emailController = TextEditingController();

  // Observable Variables
  final isLoading = false.obs;

  // Email Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  // Send Reset Link
  void sendResetLink() async {
    // Validate email
    final emailError = validateEmail(emailController.text);

    if (emailError != null) {
      Get.snackbar(
        'Validation Error',
        emailError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    isLoading.value = true;

    try {
      // ✅ TODO: Replace with your actual API call
      // Example:
      // await AuthService.sendPasswordResetLink(
      //   email: emailController.text.trim(),
      // );

      await Future.delayed(const Duration(seconds: 2)); // Simulated API call

      // Success
      Get.snackbar(
        'Success',
        AppStrings.resetLinkSentSuccess,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      // ✅ Navigate to OTP Screen (if using OTP instead of email link)
      OTPHelper.navigateToForgotPasswordOTP(
        emailController.text.trim(),
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        AppStrings.resetLinkSendFailed,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate back to Sign In
  void navigateToSignIn() {
    Get.back();
  }

  @override
  void onClose() {
    // emailController.dispose();
    super.onClose();
  }
}