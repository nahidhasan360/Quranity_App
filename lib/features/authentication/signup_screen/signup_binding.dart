import 'package:get/get.dart';
import 'package:quranity/features/authentication/signup_screen/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}