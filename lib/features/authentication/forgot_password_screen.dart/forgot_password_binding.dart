import 'package:get/get.dart';
import 'package:quranity/features/authentication/forgot_password_screen.dart/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}