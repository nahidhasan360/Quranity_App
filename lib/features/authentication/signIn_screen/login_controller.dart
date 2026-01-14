import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import '../../../core/constants/ app_strings.dart';

class LoginController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable Variables
  final isPasswordHidden = true.obs;
  final isRememberMe = false.obs;
  final isLoading = false.obs;

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Toggle Remember Me
  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  // Validation Methods
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 8) {
      return AppStrings.passwordMinLength;
    }
    return null;
  }

  // Sign In Method
  void signIn() async {
    // Validate fields
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);

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

    if (passwordError != null) {
      Get.snackbar(
        'Validation Error',
        passwordError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Start Loading
    isLoading.value = true;

    try {
      // ✅ TODO: Implement your login API call here
      // Example:
      // final response = await AuthService.login(
      //   email: emailController.text.trim(),
      //   password: passwordController.text,
      //   rememberMe: isRememberMe.value,
      // );

      await Future.delayed(const Duration(seconds: 2)); // Simulated API call

      // Success
      Get.snackbar(
        'Success',
        AppStrings.loginSuccess,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to Home
      await Future.delayed(const Duration(milliseconds: 400));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        AppStrings.loginFailed,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Sign Up
  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signup);
  }

  // Navigate to Forgot Password
  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
