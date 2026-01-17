import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';
import '../../settings/RateAppDialog/RateAppDialog.dart';

class MenuDrawerController extends GetxController {
  // Observable for user data
  var userName = 'John Doe'.obs;
  var userRole = 'Default Member'.obs;

  // Navigate to Account Screen
  void navigateToAccount() {
    Get.toNamed(AppRoutes.accountScreen);
    print('Navigate to Account');
  }

  // Navigate to Settings Screen
  void navigateToSettings() {
    Get.toNamed(AppRoutes.settingsScreen);
    print('Navigate to Settings');
  }

  // Navigate to Support Screen
  void navigateToSupport() {
    Get.toNamed(AppRoutes.supportScreen);
    print('Navigate to Support');
  }

  // Navigate to About Quranity Screen
  void navigateToAboutQuranity() {
    Get.toNamed(AppRoutes.aboutQuranityScreen);
    print('Navigate to About Quranity');
  }

  // Navigate to Legal Screen
  void navigateToLegal() {
    Get.toNamed(AppRoutes.legalScreen);
    print('Navigate to Legal');
  }

  // Share Quranity App
  void shareApp() {
    Share.share(
      'Check out Quranity App! Download now from Play Store or App Store.',
      subject: 'Quranity App',
    );
  }

  // Rate Quranity App (Show Dialog First)
  void rateApp() {
    // Show rating dialog
    RateAppDialog.show();
    print('Show rating dialog');
  }

  // Logout
  void logout() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFFCCA766)),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Close drawer
              // Perform logout logic
              // Get.offAllNamed('/login');
              print('User logged out');
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Close drawer
  void closeDrawer() {
    Get.back();
  }
}