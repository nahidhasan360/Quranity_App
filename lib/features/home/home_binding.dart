import 'package:get/get.dart';
import 'home_controller.dart';
import 'menu_drawer_Screen/menu_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MenuDrawerController>(() => MenuDrawerController());
  }
}