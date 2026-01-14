import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';

import '../../core/constants/ app_strings.dart';

enum OTPType {
  emailVerification,
  forgotPassword,
  phoneVerification,
}

class GenericOTPController extends GetxController {
  final OTPType otpType;
  final String identifier;

  GenericOTPController({
    required this.otpType,
    required this.identifier,
  });

  final otpController = TextEditingController();
  final otpCode = ''.obs;
  final isLoading = false.obs;
  final canResend = false.obs;
  final resendTimer = AppStrings.resendTimerSeconds.obs;
  final maskedIdentifier = ''.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    maskedIdentifier.value = _maskIdentifier(identifier);
    startResendTimer();
  }

  String _maskIdentifier(String value) {
    if (otpType == OTPType.emailVerification ||
        otpType == OTPType.forgotPassword) {
      if (!value.contains('@')) return value;
      final parts = value.split('@');
      final username = parts[0];
      final domain = parts[1];
      if (username.length <= 1) return value;
      final maskedUsername = '${username[0]}${'*' * 6}';
      return '$maskedUsername@$domain';
    } else {
      if (value.length < 4) return value;
      return '****${value.substring(value.length - 4)}';
    }
  }

  void startResendTimer() {
    canResend.value = false;
    resendTimer.value = AppStrings.resendTimerSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyOTP(String code) async {
    if (code.length != AppStrings.otpLength) {
      Get.snackbar(AppStrings.invalidCodeTitle, AppStrings.invalidCodeError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isLoading.value = true;
    try {
      switch (otpType) {
        case OTPType.emailVerification:
          await _verifyEmailOTP(code);
          break;
        case OTPType.forgotPassword:
          await _verifyForgotPasswordOTP(code);
          break;
        case OTPType.phoneVerification:
          await _verifyPhoneOTP(code);
          break;
      }
      Get.snackbar(AppStrings.successTitle, _getSuccessMessage(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green, colorText: Colors.white);
      await Future.delayed(const Duration(milliseconds: 500));
      _handleSuccessNavigation();
    } catch (e) {
      Get.snackbar(AppStrings.verificationFailedTitle, AppStrings.verificationFailedError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red, colorText: Colors.white);
      otpCode.value = '';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _verifyEmailOTP(String code) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _verifyForgotPasswordOTP(String code) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _verifyPhoneOTP(String code) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  String _getSuccessMessage() {
    switch (otpType) {
      case OTPType.emailVerification:
        return AppStrings.verifyEmailSuccess;
      case OTPType.forgotPassword:
        return 'OTP verified! Reset your password.';
      case OTPType.phoneVerification:
        return 'Phone number verified successfully!';
    }
  }

  void _handleSuccessNavigation() {
    switch (otpType) {
      case OTPType.emailVerification:
        Get.offAllNamed(AppRoutes.login);
        break;
      case OTPType.forgotPassword:
        Get.toNamed(AppRoutes.resetPassword,
            arguments: {'email': identifier, 'otp': otpCode.value});
        break;
      case OTPType.phoneVerification:
        Get.back();
        break;
    }
  }

  Future<void> resendOTP() async {
    if (!canResend.value) return;
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(AppStrings.codeSentTitle,
          AppStrings.resendCodeSuccess + maskedIdentifier.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green, colorText: Colors.white);
      startResendTimer();
      otpCode.value = '';
    } catch (e) {
      Get.snackbar(AppStrings.resendFailedTitle, AppStrings.resendFailedError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void backToPrevious() {
    switch (otpType) {
      case OTPType.emailVerification:
        Get.offAllNamed(AppRoutes.login);
        break;
      case OTPType.forgotPassword:
        Get.back();
        break;
      case OTPType.phoneVerification:
        Get.back();
        break;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    // ✅ DON'T DISPOSE - Let garbage collector handle it
    super.onClose();
  }
}