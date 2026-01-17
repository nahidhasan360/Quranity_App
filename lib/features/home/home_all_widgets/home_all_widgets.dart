import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/core/constants/app_assets.dart';
import '../home_controller.dart';
import '../home_strings.dart';

// ============================================================================
// TIME CARDS WIDGET (Sunrise/Sunset + Mecca/Local)
// ============================================================================
// ============================================================================
// TIME CARDS WIDGET (Sunrise/Sunset + Mecca/Local)
// ============================================================================

class TimeCardsWidget extends GetView<HomeController> {
  const TimeCardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSunriseSunsetCard()),
        SizedBox(width: 12.w),
        Expanded(child: _buildMeccaLocalCard()),
      ],
    );
  }

  Widget _buildSunriseSunsetCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.homeBoxColor3,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.sunrise,width: 36,height: 36,

                ),
                SizedBox(height: 16.h),
                Text(
                  HomeStrings.sunrise,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(
                  controller.sunriseTime.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                )),
              ],
            ),
          ),
          Container(
            width: 1.5.w,
            height: 110.h,
            color:AppColors.medGrey,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.sunset,width: 36,height: 36,

                ),
                SizedBox(height: 16.h),
                Text(
                  HomeStrings.sunset,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(
                  controller.sunsetTime.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeccaLocalCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.homeBoxColor3,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      color: const Color(0xFF9E9E9E),
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      HomeStrings.mecca,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(
                  controller.meccaTime.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: -1,
                  ),
                )),
                SizedBox(height: 2.h),
                Obx(() => Text(
                  controller.meccaPeriod.value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF808080),
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ],
            ),
          ),
          Container(
            width: 1.5.w,
            height: 110.h,
            color: AppColors.medGrey,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      HomeStrings.local,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.location_on,
                      color: const Color(0xFF9E9E9E),
                      size: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(
                  controller.localTime.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: -1,
                  ),
                )),
                SizedBox(height: 2.h),
                Obx(() => Text(
                  controller.localPeriod.value,
                  style: TextStyle(
                    fontSize: 13.sp,
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



///// ===============================  start dailyVerseCard ===========================

// ============================================================================
// DAILY VERSE CARD
// ============================================================================

class DailyVerseCard extends GetView<HomeController> {
  const DailyVerseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF45413B), Color(0xFF45413B)],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w,),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.primaryGold.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.primaryGold,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  HomeStrings.dailyVerse,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primaryGoldLight,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                    letterSpacing: 1.20,

                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Center(
            child: Obx(() => Text(
              controller.arabicVerse.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.8,
                letterSpacing: 1,
              ),
            )),
          ),
          SizedBox(height: 30.h),
          Obx(() => Center(
            child: Text(
              controller.verseTranslation.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFFAAAAAA),
                fontStyle: FontStyle.italic,
                height: 1.6,
                letterSpacing: 0.3,
              ),
            ),
          )),
          SizedBox(height: 24.h),
          Container(
            height: 1.h,
            color: const Color(0xFF5A5A5A),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Obx(() => Text(
              controller.surahInfo.value,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.primaryGold,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
// ============================================================================
// NEXT PRAYER CARD
// ============================================================================

class NextPrayerCard extends GetView<HomeController> {
  const NextPrayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD4AF87), Color(0xFFC9A766)],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 20.h),
          _buildMainContent(),
          SizedBox(height: 20.h),
          Container(height: 1.h, color: const Color(0xFF000000).withOpacity(0.1)),
          SizedBox(height: 16.h),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.access_time, color: const Color(0xFF2A2A2A), size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          'NEXT PRAYER',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF2A2A2A),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                controller.nextPrayerName.value,
                style: TextStyle(
                  fontSize: 52.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: -1,
                ),
              )),
              SizedBox(height: 8.h),
              Obx(() => Text(
                controller.nextPrayerTime.value,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xFF2A2A2A),
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ),
        ),
        _buildCircularCountdown(),
      ],
    );
  }

  Widget _buildCircularCountdown() {
    return Obx(() {
      final countdown = controller.nextPrayerCountdown.value;
      final progress = _calculateProgress(countdown);

      return SizedBox(
        width: 110.w,
        height: 110.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 110.w,
              height: 110.h,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 6.w,
                valueColor: const AlwaysStoppedAnimation(Color(0xFFB19668)),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              width: 110.w,
              height: 110.h,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6.w,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF8B7355)),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'in',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF4A4A4A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  countdown,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  double _calculateProgress(String countdown) {
    try {
      final parts = countdown.split(' ');
      int totalMinutes = 0;

      for (var part in parts) {
        if (part.contains('h')) {
          totalMinutes += int.parse(part.replaceAll('h', '')) * 60;
        } else if (part.contains('m')) {
          totalMinutes += int.parse(part.replaceAll('m', ''));
        }
      }

      const maxMinutes = 300;
      return (1 - (totalMinutes / maxMinutes)).clamp(0.0, 1.0);
    } catch (e) {
      return 0.0;
    }
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: const Color(0xFF2A2A2A), size: 16.sp),
            SizedBox(width: 6.w),
            Obx(() => Text(
              '${controller.currentCity.value}, ${controller.currentCountry.value}',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF2A2A2A),
                fontWeight: FontWeight.w500,
              ),
            )),
          ],
        ),
        Obx(() => Text(
          'Asr Method: ${controller.asrMethod.value}',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF2A2A2A),
            fontWeight: FontWeight.w500,
          ),
        )),
      ],
    );
  }
}

// ============================================================================
// PRAYER TIMES GRID
// ============================================================================

class PrayerTimesGrid extends GetView<HomeController> {
  const PrayerTimesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.prayerTimes.isEmpty) {
        return const SizedBox.shrink();
      }

      return Row(
        children: controller.prayerTimes.map((prayer) {
          final isActive = prayer['name'] == controller.activePrayer.value;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFD4AF37).withOpacity(0.2)
                    : AppColors.homeBoxColor,
                borderRadius: BorderRadius.circular(12.r),
                border: isActive
                    ? Border.all(color: const Color(0xFFD4AF37), width: 1)
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    prayer['name'],
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
                    prayer['time'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    prayer['period'],
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
      );
    });
  }
}

// ============================================================================
// MAKRUH & NAFAL SECTION
// ============================================================================

class MakruhAndNafalSection extends GetView<HomeController> {
  const MakruhAndNafalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildMakruhCard()),
        SizedBox(width: 10.w),
        Expanded(child: _buildNafalCard()),
      ],
    );
  }

  Widget _buildMakruhCard() {
    return Container(
      padding: EdgeInsets.only(left: 9,right: 9, top: 16, bottom: 10, ),
      decoration: BoxDecoration(
        color: AppColors.homeBoxColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_rounded,color:Color(0xFFFF6B6B), size: 18,),
              SizedBox(width: 4.w),
              Text(
                HomeStrings.makruhTimes,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFFF6B6B),
                  fontWeight: FontWeight.w700,
                  height: 1.33,
                  letterSpacing: 1.20,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() {
            if (controller.makruhTimes.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: controller.makruhTimes.asMap().entries.map((entry) {
                final index = entry.key;
                final time = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < controller.makruhTimes.length - 1 ? 12.h : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        time['label']!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          time['time']!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNafalCard() {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10, top: 16, bottom: 10, ),
      decoration: BoxDecoration(
        color: AppColors.homeBoxColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: const Color(0xFF6B9FFF),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                HomeStrings.nafalPrayers,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF6B9FFF),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() {
            if (controller.nafalPrayers.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: controller.nafalPrayers.asMap().entries.map((entry) {
                final index = entry.key;
                final prayer = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < controller.nafalPrayers.length - 1 ? 12.h : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prayer['label']!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          prayer['time']!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}