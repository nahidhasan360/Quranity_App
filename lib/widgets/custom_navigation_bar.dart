// custom_navbar.dart (FINAL FIXED VERSION - CONSISTENT HEIGHT & NO OVERFLOW)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../app/routes/app_routes.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController(), permanent: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateFromCurrentRoute();
    });

    return GetBuilder<NavController>(
      id: NavController.updateId,
      builder: (controller) {
        return Container(
          // ✅ সব পেজে হাইট ফিক্সড রাখার জন্য 85.h ব্যবহার করা হয়েছে
          height: 85.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C0C),
            border: Border(
              top: BorderSide(
                color: AppColors.borderColor,
                width: 0.2.w,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            // ✅ bottom: false কারণ আমরা Container height দিয়ে নিচের প্যাডিং কন্ট্রোল করছি
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: controller.navItems
                  .asMap()
                  .entries
                  .map((entry) => Expanded(
                child: _NavItem(
                  index: entry.key,
                  item: entry.value,
                  isSelected: controller.selectedIndex.value == entry.key,
                  onTap: () => controller.navigateTo(entry.key, entry.value.route),
                ),
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final NavItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    super.key,
    required this.index,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = AppColors.primaryGold;
    const unselectedColor = Colors.white;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: FittedBox(
          // ✅ FittedBox কন্টেন্টকে ওভারফ্লো হতে দেবে না, প্রয়োজনে ছোট করে জায়গা করে নেবে
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Section
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 24.w,
                  height: 24.h,
                  child: SvgPicture.asset(
                    item.svgIcon,
                    colorFilter: ColorFilter.mode(
                      isSelected ? selectedColor : unselectedColor,
                      BlendMode.srcIn,
                    ),
                    placeholderBuilder: (context) => Icon(
                      item.fallbackIcon,
                      size: 20.sp,
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                  ),
                ),

                SizedBox(height: 6.h),

                // Label Section
                Text(
                  item.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 10.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Data Models and NavController ---

class NavItemModel {
  final String svgIcon;
  final IconData fallbackIcon;
  final String label;
  final String route;
  const NavItemModel({
    required this.svgIcon,
    required this.fallbackIcon,
    required this.label,
    required this.route,
  });
}

class NavController extends GetxController {
  static const String updateId = 'navbar';
  final RxInt selectedIndex = 0.obs;

  final List<NavItemModel> navItems = const [
    NavItemModel(svgIcon: "assets/icons/home.svg", fallbackIcon: Icons.home_outlined, label: "Home", route: AppRoutes.home),
    NavItemModel(svgIcon: "assets/icons/ask.svg", fallbackIcon: Icons.chat_bubble_outline, label: "Ask", route: AppRoutes.muslimAI),
    NavItemModel(svgIcon: "assets/icons/shorts.svg", fallbackIcon: Icons.play_circle_outline, label: "Shorts", route: AppRoutes.shorts),
    NavItemModel(svgIcon: "assets/icons/stories.svg", fallbackIcon: Icons.video_library_outlined, label: "Stories", route: AppRoutes.stories),
    NavItemModel(svgIcon: "assets/icons/quran.svg", fallbackIcon: Icons.menu_book_outlined, label: "Qur'an", route: AppRoutes.quranScreen),
  ];

  late final Map<String, int> _routeToIndex = {for (var i = 0; i < navItems.length; i++) navItems[i].route: i};

  @override
  void onInit() {
    super.onInit();
    _initializeNavbar();
  }

  void _initializeNavbar() {
    final currentRoute = Get.currentRoute;
    if (_routeToIndex.containsKey(currentRoute)) {
      selectedIndex.value = _routeToIndex[currentRoute]!;
    }
    update([updateId]);
  }

  void navigateTo(int index, String route) {
    if (Get.currentRoute == route) return;
    selectedIndex.value = index;
    update([updateId]);
    Get.offAllNamed(route);
  }

  void updateFromCurrentRoute() {
    final currentRoute = Get.currentRoute;
    if (_routeToIndex.containsKey(currentRoute)) {
      int index = _routeToIndex[currentRoute]!;
      if (selectedIndex.value != index) {
        selectedIndex.value = index;
        update([updateId]);
      }
    }
  }
}