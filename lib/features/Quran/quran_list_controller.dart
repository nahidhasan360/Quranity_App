// ============================================================================
// QURAN LIST CONTROLLER - WITH SELECTION
// Location: lib/features/Quran/quran_list_controller.dart
// ============================================================================

import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import 'models/surah_model.dart';

class QuranListController extends GetxController {
  // Observable list of all Surahs
  final RxList<Surah> surahList = <Surah>[].obs;
  final RxList<Surah> filteredSurahList = <Surah>[].obs;

  // Selection state
  final RxSet<int> selectedSurahs = <int>{}.obs; // Store selected surah numbers
  final RxBool isSelectionMode = false.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Selected tab (0 for Qur'an, 1 for Hadith)
  final RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    try {
      isLoading.value = true;

      // Load all 114 Surahs
      final surahs = _getAllSurahs();

      surahList.value = surahs;
      filteredSurahList.value = surahs;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load Surahs: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Toggle selection for a Surah
  void toggleSelection(Surah surah) {
    if (selectedSurahs.contains(surah.number)) {
      selectedSurahs.remove(surah.number);
      if (selectedSurahs.isEmpty) {
        isSelectionMode.value = false;
      }
    } else {
      selectedSurahs.add(surah.number);
      isSelectionMode.value = true;
    }
  }

  // Check if a Surah is selected
  bool isSelected(int surahNumber) {
    return selectedSurahs.contains(surahNumber);
  }

  // Clear all selections
  void clearSelection() {
    selectedSurahs.clear();
    isSelectionMode.value = false;
  }

  // Select all Surahs
  void selectAll() {
    selectedSurahs.addAll(
      filteredSurahList.map((surah) => surah.number),
    );
    isSelectionMode.value = true;
  }

  // Navigate to Surah detail
  void navigateToSurahDetail(Surah surah) {
    if (isSelectionMode.value) {
      // If in selection mode, toggle selection
      toggleSelection(surah);
    } else {
      // Otherwise navigate to detail
      Get.toNamed(
        AppRoutes.surahDetail,
        arguments: surah,
      );
    }
  }

  // Long press to enter selection mode
  void onLongPress(Surah surah) {
    isSelectionMode.value = true;
    toggleSelection(surah);
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index == 1) {
      Get.toNamed(AppRoutes.hadithList);
    }
  }

  // Sample data - Replace with API call
  List<Surah> _getAllSurahs() {
    return [
      Surah(
        number: 1,
        nameArabic: 'ٱلْفَاتِحَة',
        nameEnglish: 'Al-Fatiha',
        numberOfAyahs: 7,
        revelationType: 'Meccan', nameBengali: '',
      ),
      Surah(
        number: 2,
        nameArabic: 'ٱلْبَقَرَة',
        nameEnglish: 'Al-Baqarah',
        numberOfAyahs: 286,
        revelationType: 'Medinan', nameBengali: '',
      ),
      Surah(
        number: 3,
        nameArabic: 'آل عِمْرَان',
        nameEnglish: 'Ali \'Imran',
        numberOfAyahs: 200,
        revelationType: 'Medinan', nameBengali: '',
      ),
      Surah(
        number: 4,
        nameArabic: 'ٱلنِّسَاء',
        nameEnglish: 'An-Nisa',
        numberOfAyahs: 176,
        revelationType: 'Medinan', nameBengali: '',
      ),
      Surah(
        number: 5,
        nameArabic: 'ٱلْمَائِدَة',
        nameEnglish: 'Al-Ma\'idah',
        numberOfAyahs: 120,
        revelationType: 'Medinan', nameBengali: '',
      ),
      // Add all 114 Surahs...
      // This is sample data
    ];
  }

  @override
  void onClose() {
    surahList.clear();
    filteredSurahList.clear();
    selectedSurahs.clear();
    super.onClose();
  }
}