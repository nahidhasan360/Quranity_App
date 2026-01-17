// ============================================================================
// HADITH LIST CONTROLLER
// Location: lib/app/modules/hadith/controllers/hadith_list_controller.dart
// ============================================================================

import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import 'hadith_collection_model.dart';

class HadithListController extends GetxController {
  // Observable list of hadith collections
  final RxList<HadithCollection> hadithCollections = <HadithCollection>[].obs;
  final RxList<HadithCollection> filteredCollections = <HadithCollection>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Selected tab (0 for Qur'an, 1 for Hadith)
  final RxInt selectedTab = 1.obs; // Default to Hadith tab

  @override
  void onInit() {
    super.onInit();
    loadHadithCollections();
  }

  Future<void> loadHadithCollections() async {
    try {
      isLoading.value = true;

      // Sample data - Replace with API call
      final collections = _getAllHadithCollections();

      hadithCollections.value = collections;
      filteredCollections.value = collections;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'error'.tr,
        'Failed to load hadith collections: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index == 0) {
      // Navigate to Quran screen
      Get.offAllNamed(AppRoutes.quranScreen);
    }
  }

  void navigateToCollection(HadithCollection collection) {
    Get.toNamed(AppRoutes.hadithCollection, arguments: collection);
  }

  // All 6 major Hadith collections
  List<HadithCollection> _getAllHadithCollections() {
    return [
      HadithCollection(
        id: 1,
        nameEnglish: 'Sahih al-Bukhari',
        nameArabic: 'صحيح البخاري',
        narrator: 'Imam al-Bukhari',
        totalHadiths: 7563,
        color: '#4CAF50', // Green
      ),
      HadithCollection(
        id: 2,
        nameEnglish: 'Sahih Muslim',
        nameArabic: 'صحيح مسلم',
        narrator: 'Imam Muslim',
        totalHadiths: 7190,
        color: '#2196F3', // Blue
      ),
      HadithCollection(
        id: 3,
        nameEnglish: 'Jami\' at-Tirmidhi',
        nameArabic: 'جامع الترمذي',
        narrator: 'Imam at-Tirmidhi',
        totalHadiths: 3956,
        color: '#FF9800', // Orange
      ),
      HadithCollection(
        id: 4,
        nameEnglish: 'Sunan Abu Dawud',
        nameArabic: 'سنن أبو داود',
        narrator: 'Imam Abu Dawud',
        totalHadiths: 5274,
        color: '#E91E63', // Pink
      ),
      HadithCollection(
        id: 5,
        nameEnglish: 'Sunan an-Nasa\'i',
        nameArabic: 'سنن النسائي',
        narrator: 'Imam an-Nasa\'i',
        totalHadiths: 5758,
        color: '#9C27B0', // Purple
      ),
      HadithCollection(
        id: 6,
        nameEnglish: 'Sunan Ibn Majah',
        nameArabic: 'سنن ابن ماجه',
        narrator: 'Imam Ibn Majah',
        totalHadiths: 4341,
        color: '#00BCD4', // Cyan
      ),
    ];
  }

  @override
  void onClose() {
    // Clear lists
    hadithCollections.clear();
    filteredCollections.clear();
    super.onClose();
  }
}
