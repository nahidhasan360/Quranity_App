import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'menu_controller.dart';
import 'menu_drawer_widgets.dart';
import 'menustrings.dart';

class MenuDrawerScreen extends GetView<MenuDrawerController> {
  const MenuDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildMenuHeader(),
                        SizedBox(height: 20.h),
                        _buildMenuItems(),
                      ],
                    ),
                  ),
                ),
                _buildLogoutSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header with title and close button
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          MenuDrawerStrings.menuTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontFamily: 'SF Pro',
          ),
        ),
        GestureDetector(
          onTap: controller.closeDrawer,
          child: Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.iconWhite,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }

  // Menu Header (Profile Section)
  Widget _buildMenuHeader() {
    return Obx(
          () => MenuHeaderWidget(
        userName: controller.userName.value,
        userRole: controller.userRole.value,
      ),
    );
  }

  // All Menu Items
  Widget _buildMenuItems() {
    return Column(
      children: [
        MenuItemWidget(
          icon: Icons.person_outline,
          title: MenuDrawerStrings.account,
          onTap: controller.navigateToAccount,
        ),
        MenuItemWidget(
          icon: Icons.settings_outlined,
          title: MenuDrawerStrings.settings,
          onTap: controller.navigateToSettings,
        ),
        MenuItemWidget(
          icon: Icons.headset_mic_outlined,
          title: MenuDrawerStrings.support,
          onTap: controller.navigateToSupport,
        ),
        MenuItemWidget(
          icon: Icons.info_outline,
          title: MenuDrawerStrings.aboutQuranity,
          onTap: controller.navigateToAboutQuranity,
        ),
        MenuItemWidget(
          icon: Icons.description_outlined,
          title: MenuDrawerStrings.legal,
          onTap: controller.navigateToLegal,
        ),
        MenuItemWidget(
          icon: Icons.share_outlined,
          title: MenuDrawerStrings.shareQuranityApp,
          onTap: controller.shareApp,
        ),
        MenuItemWidget(
          icon: Icons.star_outline,
          title: MenuDrawerStrings.rateQuranityApp,
          onTap: controller.rateApp,
        ),
      ],
    );
  }

  // Logout Section (Button + Version)
  Widget _buildLogoutSection() {
    return Column(
      children: [
        LogoutButtonWidget(
          onTap: controller.logout,
        ),
        VersionInfoWidget(
          versionText: MenuDrawerStrings.versionInfo,
        ),
      ],
    );
  }
}