import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'AccountStrings.dart';

class AccountController extends GetxController {
  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editProfileScreen);

  }

  void navigateToChangePassword() {
    Get.toNamed(AppRoutes.changePasswordScreen);
  }

  /// Navigate to Subscription
  void navigateToSubscription() {
    Get.toNamed(AppRoutes.subscriptionScreen);

  }

  /// Delete Account with Confirmation
  void deleteAccount() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 30,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                AccountStrings.deleteDialogTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'SF Pro',
                ),
              ),

              const SizedBox(height: 12),

              // Message
              const Text(
                AccountStrings.deleteDialogMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontFamily: 'SF Pro',
                ),
              ),

              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.medGrey,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        AccountStrings.cancelButton,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Delete Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.registrationScreen);
                        // TODO: Implement actual delete logic
                        // await accountApi.deleteAccount();

                        Get.snackbar(
                          AccountStrings.deleteAccountSnackbarTitle,
                          AccountStrings.deleteAccountSnackbarMessage,
                          backgroundColor: Colors.red.withOpacity(0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 12,
                        );

                        print('✅ Account deleted');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        AccountStrings.deleteButton,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    print('📱 AccountController initialized');
  }

  @override
  void onClose() {
    print('📱 AccountController disposed');
    super.onClose();
  }
}