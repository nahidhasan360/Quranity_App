
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../widgets/custom_otp/otp_helper.dart';
class SignupController extends GetxController {
  // Text Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable Variables
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isTermsAccepted = false.obs;
  final isLoading = false.obs;

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Toggle Terms Acceptance
  void toggleTermsAccepted() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }

  // Validation
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Sign Up Method
  void signUp() async {
    // Validate all fields
    final fullNameError = validateFullName(fullNameController.text);
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);
    final confirmPasswordError = validateConfirmPassword(confirmPasswordController.text);

    if (fullNameError != null) {
      Get.snackbar(
        'Validation Error',
        fullNameError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (emailError != null) {
      Get.snackbar(
        'Validation Error',
        emailError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
      );
      return;
    }

    if (confirmPasswordError != null) {
      Get.snackbar(
        'Validation Error',
        confirmPasswordError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isTermsAccepted.value) {
      Get.snackbar(
        'Terms Required',
        'Please accept the Terms and Conditions',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Start Loading
    isLoading.value = true;

    try {
      // Implement your sign up API call here
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call

      // Success
      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      //Navigate to home or verification screen
      OTPHelper.navigateToEmailVerification(
        emailController.text.trim(),
      );


      //
      // Get.toNamed(
      //       //   AppRoutes.verifyEmail,
      //       //   arguments: {
      //       //     'email': emailController.text.trim(),
      //       //   },
      //       // );


    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Sign In
  void navigateToSignIn() {
 Get.toNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    // fullNameController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }
}