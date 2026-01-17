import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/widgets/reusable_gradient.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'AccountStrings.dart';
import 'account-controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: GradientBackground(
        useRadialGradient: true,
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(controller),
              SizedBox(height: 16.h),
              Expanded(child: _buildContent(controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AccountController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.iconWhite,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AccountStrings.screenTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ),
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildContent(AccountController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),

          // Edit Profile - SVG Icon example
          _buildMenuItem(
            svgIconPath: 'assets/icons/edit_icon.svg', // SVG path
            // icon: Icons.edit_outlined, // Or use Material icon
            title: AccountStrings.editProfile,
            onTap: controller.navigateToEditProfile,
          ),

          SizedBox(height: 12.h),

          // Change Password - SVG Icon example
          _buildMenuItem(
            svgIconPath: 'assets/icons/lock.svg', // SVG path
            // icon: Icons.lock_outline, // Or use Material icon
            title: AccountStrings.changePassword,
            onTap: controller.navigateToChangePassword,
          ),

          SizedBox(height: 12.h),

          // Subscription & Plan - SVG Icon example
          _buildMenuItem(
            svgIconPath: 'assets/icons/payments.svg', // SVG path
            // icon: Icons.credit_card_outlined, // Or use Material icon
            title: AccountStrings.subscriptionPlan,
            badge: AccountStrings.freeBadge,
            onTap: controller.navigateToSubscription,
          ),

          SizedBox(height: 12.h),

          // Delete Account - SVG Icon example
          _buildMenuItem(
            svgIconPath: 'assets/icons/delete.svg', // SVG path
            // icon: Icons.delete_outline, // Or use Material icon
            title: AccountStrings.deleteAccount,
            isDestructive: true,
            onTap: controller.deleteAccount,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    IconData? icon, // Material Icon (optional)
    String? svgIconPath, // SVG Icon path (optional)
    required String title,
    required VoidCallback onTap,
    String? badge,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withOpacity(0.1)
                    : AppColors.medGrey,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: _buildIcon(
                  icon: icon,
                  svgIconPath: svgIconPath,
                  isDestructive: isDestructive,
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),

            // Badge
            if (badge != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.primaryGold.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGold,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],

            // Arrow
            Icon(
              Icons.chevron_right,
              color: isDestructive
                  ? Colors.red.withOpacity(0.7)
                  : AppColors.iconWhite.withOpacity(0.6),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// Build Icon - Supports both Material Icons and SVG Icons
  Widget _buildIcon({
    IconData? icon,
    String? svgIconPath,
    required bool isDestructive,
  }) {
    final iconColor = isDestructive ? Colors.red : AppColors.primaryGold;

    // If SVG path is provided, use SVG icon
    if (svgIconPath != null && svgIconPath.isNotEmpty) {
      return SvgPicture.asset(
        svgIconPath,
        width: 22.w,
        height: 22.h,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      );
    }

    // Otherwise, use Material icon (or default)
    return Icon(
      icon ?? Icons.help_outline,
      color: iconColor,
      size: 22.sp,
    );
  }
}