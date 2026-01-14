
import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFilled;
  final double? width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final double? textHeight;
  final Color filledBackgroundColor;
  final Color filledTextColor;
  final Color outlinedBorderColor;
  final Color outlinedTextColor;
  final Color? outlinedBackgroundColor;
  final double borderRadius;
  final double borderWidth;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
    this.width,
    this.height = 56,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
    this.fontFamily = 'SF Pro',
    this.textHeight,
    this.filledBackgroundColor = AppColors.primaryGold,
    this.filledTextColor = Colors.black,
    this.outlinedBorderColor = AppColors.primaryGold,
    this.outlinedTextColor = Colors.white,
    this.outlinedBackgroundColor,
    this.borderRadius = 16,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isFilled ? _buildFilledButton() : _buildOutlinedButton(),
    );
  }

  Widget _buildFilledButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: filledBackgroundColor,
        foregroundColor: filledTextColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          height: textHeight,
        ),
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: outlinedTextColor,
        side: BorderSide(
          color: outlinedBorderColor,
          width: borderWidth,
        ),
        backgroundColor: outlinedBackgroundColor ?? Colors.black.withValues(alpha: 0.3),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}