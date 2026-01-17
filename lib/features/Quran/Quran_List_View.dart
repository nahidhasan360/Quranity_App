// ============================================================================
// QURAN LIST VIEW - WITH SELECTION UI
// Location: lib/features/Quran/Quran_List_View.dart
// ============================================================================

import 'dart:math' show cos, sin, pi;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/features/Quran/quran_list_controller.dart';
import '../../app/theme/app_colors.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/reusable_gradient.dart';
import 'models/surah_model.dart';

class QuranListView extends GetView<QuranListController> {
  const QuranListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GradientBackground(
        useRadialGradient: true,
        child: SafeArea(
          child: Column(
            children: [
              Obx(() => controller.isSelectionMode.value
                  ? _buildSelectionAppBar()
                  : _buildAppBar()),
              _buildTabBar(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGold,
                      ),
                    );
                  }
                  return _buildSurahList();
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavbar(),
    );
  }

  // Regular AppBar
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Al-Qur\'an al-Kareem',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Read, Recite, Reflect',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.2,
                ),
              ),
            ],
          ),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Selection Mode AppBar
  Widget _buildSelectionAppBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Close selection mode
              GestureDetector(
                onTap: () => controller.clearSelection(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Selected count
              Obx(() => Text(
                '${controller.selectedSurahs.length} Selected',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              )),
            ],
          ),
          Row(
            children: [
              // Select All button
              GestureDetector(
                onTap: () {
                  if (controller.selectedSurahs.length ==
                      controller.filteredSurahList.length) {
                    controller.clearSelection();
                  } else {
                    controller.selectAll();
                  }
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Obx(() => Text(
                    controller.selectedSurahs.length ==
                        controller.filteredSurahList.length
                        ? 'Deselect All'
                        : 'Select All',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => _buildTab(
              label: 'Qur\'an',
              isSelected: controller.selectedTab.value == 0,
              onTap: () => controller.changeTab(0),
            )),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Obx(() => _buildTab(
              label: 'Hadith',
              isSelected: controller.selectedTab.value == 1,
              onTap: () => controller.changeTab(1),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.white,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahList() {
    return Obx(() {
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        itemCount: controller.filteredSurahList.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final surah = controller.filteredSurahList[index];
          return Obx(() => _SurahCard(
            surah: surah,
            isSelected: controller.isSelected(surah.number),
            isSelectionMode: controller.isSelectionMode.value,
            onTap: () => controller.navigateToSurahDetail(surah),
            onLongPress: () => controller.onLongPress(surah),
          ));
        },
      );
    });
  }
}

// ============================================================================
// SURAH CARD WIDGET - WITH SELECTION STATE
// ============================================================================

class _SurahCard extends StatelessWidget {
  final Surah surah;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _SurahCard({
    required this.surah,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasGoldenBorder = surah.number == 1;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGold.withOpacity(0.2)
              : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGold
                : hasGoldenBorder
                ? AppColors.primaryGold.withOpacity(0.4)
                : Colors.transparent,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            // Selection indicator or Hexagon
            if (isSelectionMode)
              _buildSelectionIndicator(isSelected)
            else
              _HexagonBadge(number: surah.number),
            SizedBox(width: 16.w),
            // Surah Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameEnglish,
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      _buildRevelationTag(surah.revelationType),
                      SizedBox(width: 8.w),
                      Text(
                        '${surah.numberOfAyahs} Verses',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.5),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arabic Name
            Text(
              surah.nameArabic,
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            SizedBox(width: 12.w),
            // Arrow Icon (hidden in selection mode)
            if (!isSelectionMode)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.3),
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryGold
            : Colors.grey.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryGold
              : Colors.white.withOpacity(0.3),
          width: 2.w,
        ),
      ),
      child: Icon(
        isSelected ? Icons.check : null,
        color: Colors.black,
        size: 24.sp,
      ),
    );
  }

  Widget _buildRevelationTag(String revelationType) {
    final isMakki = revelationType.toLowerCase() == 'meccan';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isMakki
            ? const Color(0xFF8B7355).withOpacity(0.2)
            : const Color(0xFF4A9B6E).withOpacity(0.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        isMakki ? 'MAKKI' : 'MADANI',
        style: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: isMakki ? const Color(0xFFD4A574) : const Color(0xFF4CAF50),
          height: 1.2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ============================================================================
// HEXAGON BADGE WIDGET
// ============================================================================

class _HexagonBadge extends StatelessWidget {
  final int number;

  const _HexagonBadge({required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      height: 48.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(48.w, 48.h),
            painter: _HexagonPainter(
              color: const Color(0xFF2A2A2A),
              borderColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Text(
            '$number',
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HEXAGON PAINTER
// ============================================================================

class _HexagonPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  _HexagonPainter({
    required this.color,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = _createHexagonPath(size);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  Path _createHexagonPath(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (60 * i - 30) * pi / 180;
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}