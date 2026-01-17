// ============================================================================
// SURAH DETAIL VIEW - WITH AYAH SELECTION
// Location: lib/features/Quran/views/surah_detail_view.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/features/Quran/surah_detail_view/surah_detail_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../widgets/reusable_gradient.dart';
import 'ayah_model.dart';

class SurahDetailView extends GetView<SurahDetailController> {
  const SurahDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GradientBackground(
        useRadialGradient: true,
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGold,
                      ),
                    );
                  }
                  return _buildAyahList();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Surah Info Pill
          Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Surah ${controller.surahName.value} • Page ${controller.currentPage.value}',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
                height: 1.2,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAyahList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: controller.ayahs.length + 1, // +1 for Bismillah
      itemBuilder: (context, index) {
        if (index == 0) {
          // Bismillah at top
          return _buildBismillah();
        }
        final ayah = controller.ayahs[index - 1];
        return Obx(() => _buildAyahItem(ayah, index));
      },
    );
  }

  Widget _buildBismillah() {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Text(
        'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 2.0,
        ),
      ),
    );
  }

  Widget _buildAyahItem(Ayah ayah, int index) {
    final isSelected = controller.isAyahSelected(ayah.numberInSurah);

    return GestureDetector(
      onTap: () => controller.toggleAyahSelection(ayah),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGold.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGold
                : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic Text with Verse Number
            _buildArabicText(ayah),
            SizedBox(height: 12.h),
            // English Translation
            _buildTranslation(ayah),
          ],
        ),
      ),
    );
  }

  Widget _buildArabicText(Ayah ayah) {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: [
          // Arabic verse text
          TextSpan(
            text: ayah.textArabic,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 2.0,
            ),
          ),
          // Verse number in circle
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: _buildVerseNumber(ayah.numberInSurah),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseNumber(int number) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        color: const Color(0xFFD14D72), // Pink/Red color
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _convertToArabicNumber(number),
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildTranslation(Ayah ayah) {
    return Text(
      ayah.translationEnglish,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey.withOpacity(0.7),
        height: 1.6,
      ),
    );
  }

  String _convertToArabicNumber(int number) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((digit) => arabicNumbers[int.parse(digit)])
        .join();
  }
}