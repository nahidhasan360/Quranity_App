import 'package:get/get.dart';
import 'shorts_controller.dart';

class ShortsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortsController>(() => ShortsController());
  }
}