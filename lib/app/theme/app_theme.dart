import 'package:flutter/material.dart';
import 'package:quranity/app/theme/app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryGold,
    scaffoldBackgroundColor: AppColors.primaryGoldDark,

    // ✅ Set SF Pro as default font
    fontFamily: 'SF Pro',

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryGoldDark,
    scaffoldBackgroundColor: Colors.black,

    // ✅ Set SF Pro as default font
    fontFamily: 'SF Pro',

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'SF Pro',
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}