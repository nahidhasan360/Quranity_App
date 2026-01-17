// ============================================================================
// SURAH DETAIL CONTROLLER - WITH AYAH SELECTION
// Location: lib/features/Quran/controllers/surah_detail_controller.dart
// ============================================================================
import 'package:get/get.dart';
import '../models/surah_model.dart';
import 'ayah_model.dart';

class SurahDetailController extends GetxController {
  // Observables
  final RxList<Ayah> ayahs = <Ayah>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxString surahName = ''.obs;

  // Ayah selection
  final RxSet<int> selectedAyahs = <int>{}.obs; // Store selected ayah numbers
  final Rx<Ayah?> currentSelectedAyah = Rx<Ayah?>(null);

  // Surah data
  Surah? surah;

  @override
  void onInit() {
    super.onInit();
    // Get Surah from arguments
    surah = Get.arguments as Surah?;
    if (surah != null) {
      surahName.value = surah!.nameEnglish;
      loadAyahs();
    }
  }

  Future<void> loadAyahs() async {
    try {
      isLoading.value = true;

      // Sample data for Al-Fatiha (Surah 1)
      // Replace with API call
      if (surah?.number == 1) {
        ayahs.value = _getAlFatihaAyahs();
      } else {
        // Load other Surahs from API
        ayahs.value = [];
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load ayahs: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Toggle ayah selection
  void toggleAyahSelection(Ayah ayah) {
    if (selectedAyahs.contains(ayah.numberInSurah)) {
      selectedAyahs.remove(ayah.numberInSurah);
      currentSelectedAyah.value = null;
    } else {
      selectedAyahs.add(ayah.numberInSurah);
      currentSelectedAyah.value = ayah;

      // Show selection feedback
      Get.snackbar(
        'Ayah ${ayah.numberInSurah} Selected',
        ayah.translationEnglish,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onPrimary,
      );
    }
  }

  // Check if ayah is selected
  bool isAyahSelected(int ayahNumber) {
    return selectedAyahs.contains(ayahNumber);
  }

  // Clear all selections
  void clearSelection() {
    selectedAyahs.clear();
    currentSelectedAyah.value = null;
  }

  // Select all ayahs
  void selectAllAyahs() {
    selectedAyahs.addAll(
      ayahs.map((ayah) => ayah.numberInSurah),
    );
  }

  List<Ayah> _getAlFatihaAyahs() {
    return [
      Ayah(
        number: 1,
        numberInSurah: 1,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
        translationEnglish: '[All] praise is [due] to Allah, Lord of the worlds -',
        transliteration: 'Alhamdu lillahi rabbil \'alamin',
      ),
      Ayah(
        number: 2,
        numberInSurah: 2,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        translationEnglish: 'The Entirely Merciful, the Especially Merciful,',
        transliteration: 'Ar-Rahmanir-Rahim',
      ),
      Ayah(
        number: 3,
        numberInSurah: 3,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'مَـٰلِكِ يَوْمِ ٱلدِّينِ',
        translationEnglish: 'Sovereign of the Day of Recompense.',
        transliteration: 'Maliki yawmid-din',
      ),
      Ayah(
        number: 4,
        numberInSurah: 4,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
        translationEnglish: 'It is You we worship and You we ask for help.',
        transliteration: 'Iyyaka na\'budu wa iyyaka nasta\'in',
      ),
      Ayah(
        number: 5,
        numberInSurah: 5,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ',
        translationEnglish: 'Guide us to the straight path -',
        transliteration: 'Ihdinas-siratal-mustaqim',
      ),
      Ayah(
        number: 6,
        numberInSurah: 6,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ',
        translationEnglish: 'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.',
        transliteration: 'Siratal-ladhina an\'amta \'alayhim ghayril-maghdubi \'alayhim wa lad-dallin',
      ),
      Ayah(
        number: 7,
        numberInSurah: 7,
        juz: 1,
        manzil: 1,
        page: 1,
        ruku: 1,
        hizbQuarter: 1,
        textArabic: 'ٱلضَّآلِّينَ',
        translationEnglish: '',
        transliteration: 'Ad-dallin',
      ),
    ];
  }

  @override
  void onClose() {
    ayahs.clear();
    selectedAyahs.clear();
    super.onClose();
  }
}