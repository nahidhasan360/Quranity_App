// ============================================================================
// SURAH DETAIL BINDING
// Location: lib/features/Quran/bindings/surah_detail_binding.dart
// ============================================================================

import 'package:get/get.dart';
import 'package:quranity/features/Quran/surah_detail_view/surah_detail_controller.dart';

class SurahDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahDetailController>(
          () => SurahDetailController(),
    );
  }
}