import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';

import '../../../core/constants/ app_strings.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;
  String email = '';
  String otp = '';

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map) {
      email = arguments['email'] ?? '';
      otp = arguments['otp'] ?? '';
    }
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value.length < 8) return AppStrings.passwordTooShort;
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != newPasswordController.text) return AppStrings.passwordMismatch;
    return null;
  }

  void resetPassword() async {
    final passwordError = validatePassword(newPasswordController.text);
    final confirmPasswordError =
    validateConfirmPassword(confirmPasswordController.text);
    if (passwordError != null) {
      Get.snackbar('Validation Error', passwordError,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (confirmPasswordError != null) {
      Get.snackbar('Validation Error', confirmPasswordError,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      FocusScope.of(Get.context!).unfocus();
      Get.rawSnackbar(
          message: AppStrings.passwordResetSuccess,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 1000));
      await Future.delayed(const Duration(milliseconds: 1100));
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', AppStrings.passwordResetFailed,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // ✅ DON'T DISPOSE - Let garbage collector handle it
    super.onClose();
  }
}