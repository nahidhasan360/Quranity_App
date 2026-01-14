import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranity/app/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? prefixIconPath;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool enabled; // ✅

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIconPath,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        enabled: enabled,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textWhite,
          fontFamily: 'SF Pro',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryGold,
            fontFamily: 'SF Pro',
          ),
          prefixIcon: prefixIconPath != null
              ? Padding(
            padding: EdgeInsets.all(14.w),
            child: _buildPrefixIcon(),
          )
              : null,
          suffixIcon: suffixIcon,
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.primaryGold,
              width: 0.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {

    IconData iconData;

    if (prefixIconPath?.contains('user') ?? false) {
      iconData = Icons.person_outline;
    } else if (prefixIconPath?.contains('email') ?? false) {
      iconData = Icons.email_outlined;
    } else if (prefixIconPath?.contains('lock') ?? false) {
      iconData = Icons.lock_outline;
    } else {
      iconData = Icons.help_outline;
    }

    return Icon(
      iconData,
      size: 20.sp,
      color: AppColors.primaryGold,
    );

    //  Use this when SVG icons are ready:
    // return SvgPicture.asset(
    //   prefixIconPath!,
    //   width: 20.w,
    //   height: 20.h,
    //   colorFilter: ColorFilter.mode(
    //     AppColors.primaryGold,
    //     BlendMode.srcIn,
    //   ),
    // );
  }
}