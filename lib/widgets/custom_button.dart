import 'package:flutter/material.dart';
import 'package:quranity/app/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final IconData? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.suffixIcon,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                   color: AppColors.arrowBackgroundColor,
                  borderRadius:BorderRadius.circular(50),
                ),
                child: Icon(
                  suffixIcon,
                  size: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}