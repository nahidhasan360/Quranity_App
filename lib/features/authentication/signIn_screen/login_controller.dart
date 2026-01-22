import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import '../../../core/constants/ app_strings.dart';
import 'after_success_success_dialog/success_dialog.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isRememberMe = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  Future<void> signIn() async {
    // Validation
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        AppStrings.errorTitle,
        AppStrings.enterEmailError,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        AppStrings.errorTitle,
        AppStrings.enterPasswordError,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Replace with your actual API call
      // Example:
      // final response = await authService.login(
      //   email: emailController.text.trim(),
      //   password: passwordController.text.trim(),
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success - Show dialog with disclaimer
      Get.dialog(
        SuccessDialog(
          onPressed: () {
            Get.back();
            Get.offAllNamed(AppRoutes.home);
          },
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.75),
      );
    } catch (e) {
      // Error handling
      Get.snackbar(
        AppStrings.loginFailedTitle,
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    // TODO: Implement forgot password route
    // Get.toNamed(AppRoutes.forgotPassword);
  }

  void navigateToSignUp() {
    // TODO: Implement sign up route
    // Get.toNamed(AppRoutes.signUp);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}