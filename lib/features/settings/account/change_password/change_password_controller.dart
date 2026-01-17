import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'change_password_strings.dart';

class ChangePasswordController extends GetxController {
  // Form Controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable States
  final isLoading = false.obs;
  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle Current Password Visibility
  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  /// Toggle New Password Visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  /// Toggle Confirm Password Visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Validate Form
  bool _validateForm() {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Check current password
    if (currentPassword.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ChangePasswordStrings.currentPasswordRequired,
      );
      return false;
    }

    // Check new password
    if (newPassword.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ChangePasswordStrings.newPasswordRequired,
      );
      return false;
    }

    // Check password length
    if (newPassword.length < 6) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ChangePasswordStrings.passwordTooShort,
      );
      return false;
    }

    // Check confirm password
    if (confirmPassword.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ChangePasswordStrings.confirmPasswordRequired,
      );
      return false;
    }

    // Check passwords match
    if (newPassword != confirmPassword) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: ChangePasswordStrings.passwordsDoNotMatch,
      );
      return false;
    }

    return true;
  }

  /// Change Password
  Future<void> changePassword() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Call API to change password
      // final response = await authApi.changePassword(
      //   currentPassword: currentPasswordController.text,
      //   newPassword: newPasswordController.text,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Show success message
      _showSuccessSnackbar(
        title: ChangePasswordStrings.passwordChangedTitle,
        message: ChangePasswordStrings.passwordChangedMessage,
      );

      // Clear fields
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      // Go back after delay
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();

      print('✅ Password changed successfully');

    } catch (e) {
      isLoading.value = false;

      _showErrorSnackbar(
        title: 'Error',
        message: ChangePasswordStrings.changePasswordFailed,
      );

      print('❌ Error changing password: $e');
    }
  }

  /// Forgot Password
  void forgotPassword() {
    // TODO: Navigate to forgot password screen
    // Get.toNamed('/forgot-password');

    Get.snackbar(
      'Forgot Password',
      'Navigate to Forgot Password screen',
      backgroundColor: Colors.orange.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );

    print('✅ Navigate to Forgot Password');
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

  @override
  void onInit() {
    super.onInit();
    print('📱 ChangePasswordController initialized');
  }
}