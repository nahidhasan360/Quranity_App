import 'package:get/get.dart';
import 'package:quranity/features/Quran/quran_list_controller.dart';


class QuranListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranListController>(
          () => QuranListController(),
    );
  }
}