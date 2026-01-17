import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranity/app/theme/app_colors.dart';

// Menu Header Widget
class MenuHeaderWidget extends StatelessWidget {
  final String userName;
  final String userRole;

  const MenuHeaderWidget({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Icon
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.primaryGold,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.person,
              color: AppColors.textBlack,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                userRole,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Menu Item Widget
class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.h),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.medGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.iconWhite,
              size: 20.sp,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              fontFamily: 'SF Pro',
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.iconWhite,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}

// Logout Button Widget
class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButtonWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      margin: EdgeInsets.only(top: 20.h, bottom: 16.h),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              color: AppColors.textBlack,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
                fontFamily: 'SF Pro',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Version Info Widget
class VersionInfoWidget extends StatelessWidget {
  final String versionText;

  const VersionInfoWidget({
    super.key,
    required this.versionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        versionText,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          fontFamily: 'SF Pro',
        ),
      ),
    );
  }
}