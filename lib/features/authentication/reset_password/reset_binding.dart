import 'package:get/get.dart';
import 'package:quranity/features/authentication/reset_password/reset_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}