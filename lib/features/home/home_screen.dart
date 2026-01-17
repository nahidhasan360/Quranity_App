import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/core/constants/app_assets.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/widgets/custom_navigation_bar.dart';
import 'home_all_widgets/home_all_widgets.dart';
import 'home_controller.dart';
import 'home_strings.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody:true,
      body: GradientBackground(
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return _buildLoadingState();
            }

            if (controller.hasError.value) {
              return _buildErrorState();
            }

            return RefreshIndicator(
              onRefresh: () => controller.refreshPrayerTimes(),
              color: const Color(0xFFD4AF37),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.h), // Global 10.w padding
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildTopBar(),
                      SizedBox(height: 20.h),
                      const TimeCardsWidget(),
                      SizedBox(height: 20.h),
                      const DailyVerseCard(),
                      SizedBox(height: 20.h),
                      _buildPrayerTimesLabel(),
                      SizedBox(height: 20.h),
                      const NextPrayerCard(),
                      SizedBox(height: 20.h),
                      const PrayerTimesGrid(),
                      SizedBox(height: 20.h),
                      const MakruhAndNafalSection(),
                      SizedBox(height: 90.h),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFFD4AF37)),
          SizedBox(height: 16.h),
          Text(
            HomeStrings.loadingPrayerTimes,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => controller.refreshPrayerTimes(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              ),
              child: Text(
                HomeStrings.retryButton,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        // ⭐ Menu Icon - GestureDetector দিয়ে wrap করুন
        GestureDetector(
          onTap: controller.openMenuDrawer, // এই line add করুন
          child: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.medGrey,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
        ),
        SizedBox(width: 12.w),

        // বাকি সব same থাকবে...
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.medGrey,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textWhite, size: 20),
                SizedBox(width: 8.w),
                Text(
                  HomeStrings.searchHint,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.hintText),
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
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.notification,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
            Positioned(
              top: 9,
              right: 14,
              child: Container(
                width: 6.w,
                height: 6.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildPrayerTimesLabel() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Horizontal line (left + right)
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1.h,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
              SizedBox(width: 16.w), // Gap for label
              Expanded(
                child: Container(
                  height: 1.h,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
            ],
          ),
          // Label with white background and shadow
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              HomeStrings.prayerTimes,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
                height: 1.33,
                letterSpacing: 1.20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}