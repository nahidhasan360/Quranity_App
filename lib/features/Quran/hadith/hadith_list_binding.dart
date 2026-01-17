// ============================================================================
// HADITH LIST BINDING
// Location: lib/app/modules/hadith/bindings/hadith_list_binding.dart
// ============================================================================

import 'package:get/get.dart';
import 'hadith_list_controller.dart';

class HadithListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadithListController>(
          () => HadithListController(),
    );
  }
}