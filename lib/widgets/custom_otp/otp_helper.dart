import 'package:get/get.dart';
import 'package:quranity/widgets/custom_otp/generic_otp_screen.dart';
import 'package:quranity/widgets/custom_otp/generic_otp_controller.dart';

class OTPHelper {
  static void navigateToEmailVerification(String email) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.to(
            () => const GenericOTPScreen(
          title: 'Verify Email',
          subtitle1: "We've sent a 4-digit code to ",
          subtitle2: '.',
          instruction: 'Please enter it below.',
          buttonText: 'Verify & Create Account',
          backButtonText: 'Back to Sign Up',
        ),
        binding: BindingsBuilder(() {
          Get.delete<GenericOTPController>(force: true);

          Get.put(
            GenericOTPController(
              otpType: OTPType.emailVerification,
              identifier: email,
            ),
            permanent: false,
          );
        }),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    });
  }






  // ✅ Forgot Password =========================================================================================
  static void navigateToForgotPasswordOTP(String email) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.to(
            () => const GenericOTPScreen(
          title: 'Verify Code',
          subtitle1: "We've sent a verification code to ",
          subtitle2: '.',
          instruction: 'Enter the code to reset your password.',
          buttonText: 'Verify Code',
          backButtonText: 'Back to Forgot Password',
        ),
        binding: BindingsBuilder(() {
          Get.delete<GenericOTPController>(force: true);

          Get.put(
            GenericOTPController(
              otpType: OTPType.forgotPassword,
              identifier: email,
            ),
            permanent: false,
          );
        }),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  // ✅ Phone Verification
  static void navigateToPhoneVerification(String phone) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.to(
            () => const GenericOTPScreen(
          title: 'Verify Phone',
          subtitle1: "We've sent a code to ",
          subtitle2: '.',
          instruction: 'Please enter it below.',
          buttonText: 'Verify Phone',
          backButtonText: 'Back',
        ),
        binding: BindingsBuilder(() {
          Get.delete<GenericOTPController>(force: true);

          Get.put(
            GenericOTPController(
              otpType: OTPType.phoneVerification,
              identifier: phone,
            ),
            permanent: false,
          );
        }),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    });
  }
}