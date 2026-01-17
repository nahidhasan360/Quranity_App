// ============================================================================
// HADITH LIST VIEW - NO LOCALIZATION (CLEAN)
// Location: lib/app/modules/hadith/views/hadith_list_view.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../widgets/custom_navigation_bar.dart';
import '../../../widgets/reusable_gradient.dart';
import 'hadith_collection_model.dart';
import 'hadith_list_controller.dart';

class HadithListView extends GetView<HadithListController> {
  const HadithListView({super.key});

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
                  return _buildCollectionList();
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavbar(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hadith Collections',
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
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.white,
              size: 24.sp,
            ),
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

  Widget _buildCollectionList() {
    return Obx(() {
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        itemCount: controller.filteredCollections.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final collection = controller.filteredCollections[index];
          return _HadithCollectionCard(
            collection: collection,
            onTap: () => controller.navigateToCollection(collection),
          );
        },
      );
    });
  }
}

// ============================================================================
// HADITH COLLECTION CARD WIDGET
// ============================================================================

class _HadithCollectionCard extends StatelessWidget {
  final HadithCollection collection;
  final VoidCallback onTap;

  const _HadithCollectionCard({
    required this.collection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(collection.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            // Colored Icon Circle
            _buildIconCircle(color),
            SizedBox(width: 16.w),
            // Collection Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.nameEnglish,
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
                      Icon(
                        Icons.menu_book,
                        color: color,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${collection.totalHadiths} Hadiths',
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
                  SizedBox(height: 4.h),
                  Text(
                    collection.narrator,
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: color.withOpacity(0.7),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Arrow Icon
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

  Widget _buildIconCircle(Color color) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 2.w,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.book,
          color: color,
          size: 24.sp,
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return AppColors.primaryGold;
    }
  }
}