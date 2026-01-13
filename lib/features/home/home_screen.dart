import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/core/constants/app_assets.dart';

import '../../widgets/reusable_gradient.dart';


// ============================================================================
// PRAYER TIMES CONTROLLER - FIXED
// ============================================================================

class PrayerTimesController extends GetxController {
  // Time Cards
  var sunriseTime = '06:45 AM'.obs;
  var sunsetTime = '07:00 PM'.obs;
  var makkahTime = '12:30'.obs;
  var makkahPeriod = 'PM'.obs;
  var localTime = '04:00'.obs;
  var localPeriod = 'PM'.obs;

  // Daily Verse
  var arabicVerse = 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ'.obs;
  var verseTranslation = '"All praise is due to Allah,\nLord of all the worlds."'.obs;
  var surahInfo = 'SURAH AL-FATIHA • AYAH 1'.obs;

  // Next Prayer
  var nextPrayerName = 'Asr'.obs;
  var nextPrayerTime = '03:45 PM'.obs;
  var nextPrayerCountdown = '1h 23m'.obs;
  var location = 'Makkah, SA'.obs;
  var asrMethod = 'Asr Method: Standard'.obs;

  // Prayer Times
  var activePrayer = 'ASR'.obs;
  var prayerTimes = <Map<String, String>>[
    {'name': 'FAJR', 'time': '05:23', 'period': 'AM'},
    {'name': 'DHUHR', 'time': '12:30', 'period': 'PM'},
    {'name': 'ASR', 'time': '03:45', 'period': 'PM'},
    {'name': 'MAGHRIB', 'time': '06:32', 'period': 'PM'},
    {'name': 'ISHA', 'time': '08:02', 'period': 'PM'},
  ].obs;

  // Makruh Times
  var makruhTimes = <Map<String, String>>[
    {'label': 'Sunrise:', 'time': '06:45 - 07:00 AM'},
    {'label': 'Zawal:', 'time': '12:15 - 12:30 PM'},
    {'label': 'Sunset:', 'time': '17:55 - 18:12 PM'},
  ].obs;

  // Nafal Prayers
  var nafalPrayers = <Map<String, String>>[
    {'label': 'Ishraq:', 'time': '07:15 AM'},
    {'label': 'Chasht:', 'time': '09:00 AM'},
    {'label': 'Tahajjud:', 'time': '03:00 AM'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    updateCurrentTimes();
    startTimeUpdater();
  }

  void startTimeUpdater() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      updateCurrentTimes();
    });
  }

  void updateCurrentTimes() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');

    localTime.value = '$hour:$minute';
    localPeriod.value = now.hour >= 12 ? 'PM' : 'AM';
  }
}

// ============================================================================
// MAIN PAGE
// ============================================================================

class IslamicPrayerTimesPage extends StatelessWidget {
  const IslamicPrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PrayerTimesController());


    return Scaffold(
      // Using reusable gradient
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildTopBar(),
                SizedBox(height: 20.h),
                const TimeCardsWidget(),
                SizedBox(height: 20.h),
                const DailyVerseCard(),
                SizedBox(height: 20.h),
                _buildPrayerTimesLabel(),
                SizedBox(height: 12.h),
                const NextPrayerCard(),
                SizedBox(height: 16.h),
                const PrayerTimesGrid(),
                SizedBox(height: 20.h),
                const MakruhAndNafalSection(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================  top searchbar and this is heading section ========================

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.medGrey,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              width: 256.w,
              height: 50.h,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.medGrey,
                borderRadius: BorderRadius.circular(37170400),
              ),
              child: Row(
                children: [

                  SizedBox(width: 12.w),
                  const Icon(Icons.search, color:AppColors.textWhite, size: 20),
                  SizedBox(width: 8.w),
                  Text(
                    'Search Qur\'an, Hadith...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.hintText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Stack(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.medGrey,
                  borderRadius: BorderRadius.circular(37170400),
                ),
                child:  SvgPicture.asset(
                    AppAssets.notification,
                    width: 20.w,
                    height: 20.h,
                    // colorFilter: ColorFilter.mode(
                    //   AppColors.primaryGold,
                    //   BlendMode.srcIn,
                    // ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  // ======================== end header section ====================

  Widget _buildPrayerTimesLabel() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'PRAYER TIMES',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TIME CARDS WIDGET
// ============================================================================

class TimeCardsWidget extends GetView<PrayerTimesController> {
  const TimeCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(child: _buildSunriseSunsetCard()),
          SizedBox(width: 12.w),
          Expanded(child: _buildMakkahLocalCard()),
        ],
      ),
    );
  }

  Widget _buildSunriseSunsetCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: const Color(0xFF424242),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.wb_sunny_outlined,
                    color: const Color(0xFFD4AF37),
                    size: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'SUNRISE',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFFAAAAAA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Obx(() => Text(
                  controller.sunriseTime.value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ],
            ),
          ),
          Container(width: 1.w, height: 70.h, color: const Color(0xFF333333)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.nightlight_outlined,
                    color: const Color(0xFF7B68EE),
                    size: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'SUNSET',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFFAAAAAA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Obx(() => Text(
                  controller.sunsetTime.value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMakkahLocalCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: const Color(0xFF424242),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.language,
                    color: const Color(0xFFD4AF37),
                    size: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language, color: const Color(0xFFAAAAAA), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'MACCA',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFFAAAAAA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Obx(() => Text(
                  controller.makkahTime.value,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                )),
                Obx(() => Text(
                  controller.makkahPeriod.value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF808080),
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ],
            ),
          ),
          Container(
            width: 1.5.w,
            height: 85.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: const Color(0xFFD4AF37),
                    size: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOCAL',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFFAAAAAA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.location_on, color: const Color(0xFFAAAAAA), size: 12.sp),
                  ],
                ),
                SizedBox(height: 6.h),
                Obx(() => Text(
                  controller.localTime.value,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                )),
                Obx(() => Text(
                  controller.localPeriod.value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF808080),
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// DAILY VERSE CARD
// ============================================================================

class DailyVerseCard extends GetView<PrayerTimesController> {
  const DailyVerseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A4A4A), Color(0xFF3A3A3A)],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: const Color(0xFFD4AF37), size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  'DAILY VERSE',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFFD4AF37),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Center(
              child: Obx(() => Text(
                controller.arabicVerse.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.8,
                ),
              )),
            ),
            SizedBox(height: 16.h),
            Obx(() => Text(
              controller.verseTranslation.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFB0B0B0),
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            )),
            SizedBox(height: 16.h),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Obx(() => Text(
                  controller.surahInfo.value,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF808080),
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// NEXT PRAYER CARD
// ============================================================================

class NextPrayerCard extends GetView<PrayerTimesController> {
  const NextPrayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFD4AF37), Color(0xFFC9A961)],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: const Color(0xFF2A2A2A), size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  'NEXT PRAYER',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF2A2A2A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(() => Text(
                  controller.nextPrayerName.value,
                  style: TextStyle(
                    fontSize: 36.sp,
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w700,
                  ),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Obx(() => Text(
                    controller.nextPrayerCountdown.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Obx(() => Text(
              controller.nextPrayerTime.value,
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xFF2A2A2A),
                fontWeight: FontWeight.w600,
              ),
            )),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.location_on, color: const Color(0xFF2A2A2A), size: 14.sp),
                SizedBox(width: 4.w),
                Obx(() => Text(
                  controller.location.value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF2A2A2A),
                    fontWeight: FontWeight.w500,
                  ),
                )),
                SizedBox(width: 16.w),
                Expanded(
                  child: Obx(() => Text(
                    controller.asrMethod.value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF2A2A2A),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// PRAYER TIMES GRID
// ============================================================================

class PrayerTimesGrid extends GetView<PrayerTimesController> {
  const PrayerTimesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() => Row(
        children: controller.prayerTimes.map((prayer) {
          final isActive = prayer['name'] == controller.activePrayer.value;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFD4AF37).withOpacity(0.2)
                    : const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(12.r),
                border: isActive
                    ? Border.all(color: const Color(0xFFD4AF37), width: 1.5)
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    prayer['name']!,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isActive
                          ? const Color(0xFFD4AF37)
                          : const Color(0xFF808080),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    prayer['time']!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    prayer['period']!,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: const Color(0xFF808080),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}

// ============================================================================
// MAKRUH & NAFAL SECTION
// ============================================================================

class MakruhAndNafalSection extends GetView<PrayerTimesController> {
  const MakruhAndNafalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildMakruhCard()),
          SizedBox(width: 12.w),
          Expanded(child: _buildNafalCard()),
        ],
      ),
    );
  }

  Widget _buildMakruhCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled, color: const Color(0xFFFF6B6B), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'MAKRUH TIMES',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFFFF6B6B),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children: controller.makruhTimes.asMap().entries.map((entry) {
              final index = entry.key;
              final time = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < controller.makruhTimes.length - 1 ? 12.h : 0,
                ),
                child: Row(
                  children: [
                    Text(
                      time['label']!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        time['time']!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildNafalCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: const Color(0xFF6B9FFF), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'NAFAL PRAYERS',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF6B9FFF),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children: controller.nafalPrayers.asMap().entries.map((entry) {
              final index = entry.key;
              final prayer = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < controller.nafalPrayers.length - 1 ? 12.h : 0,
                ),
                child: Row(
                  children: [
                    Text(
                      prayer['label']!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        prayer['time']!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}