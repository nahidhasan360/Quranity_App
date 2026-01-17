import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'subscription_strings.dart';

enum PlanType { basic, premium, ramadanSpecial }

class SubscriptionController extends GetxController {
  // Current plan (default: basic/free)
  final currentPlan = PlanType.basic.obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentPlan();
  }

  /// Load current subscription plan
  void _loadCurrentPlan() {
    // TODO: Load from API or local storage
    // For now, default is basic
    currentPlan.value = PlanType.basic;
    print('📱 Current plan: ${currentPlan.value}');
  }

  /// Check if plan is current
  bool isCurrentPlan(PlanType plan) {
    return currentPlan.value == plan;
  }

  /// Upgrade to Premium
  void upgradeToPremium() {
    _showUpgradeConfirmation(
      planType: PlanType.premium,
      planName: SubscriptionStrings.premiumPlan,
      price: SubscriptionStrings.premiumPlanPrice,
    );
  }

  /// Upgrade to Ramadan Special
  void upgradeToRamadanSpecial() {
    _showUpgradeConfirmation(
      planType: PlanType.ramadanSpecial,
      planName: SubscriptionStrings.ramadanSpecialPlan,
      price: SubscriptionStrings.ramadanSpecialPrice,
    );
  }

  /// Show upgrade confirmation dialog
  void _showUpgradeConfirmation({
    required PlanType planType,
    required String planName,
    required String price,
  }) {
    // Check if already on this plan
    if (isCurrentPlan(planType)) {
      _showInfoSnackbar(
        title: 'Info',
        message: SubscriptionStrings.alreadySubscribedMessage,
      );
      return;
    }

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
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: AppColors.primaryGold,
                  size: 30,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                SubscriptionStrings.confirmUpgradeTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'SF Pro',
                ),
              ),

              const SizedBox(height: 12),

              // Message
              Text(
                'Upgrade to $planName for $price/mo?',
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                        SubscriptionStrings.cancelButton,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Confirm Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _performUpgrade(planType);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        SubscriptionStrings.confirmButton,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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

  /// Perform subscription upgrade
  Future<void> _performUpgrade(PlanType planType) async {
    try {
      isLoading.value = true;

      // TODO: Call payment gateway / API
      // await subscriptionApi.upgrade(planType);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Update current plan
      currentPlan.value = planType;

      isLoading.value = false;

      // Show success message
      _showSuccessSnackbar(
        title: SubscriptionStrings.subscriptionSuccessTitle,
        message: SubscriptionStrings.subscriptionSuccessMessage,
      );

      print('✅ Upgraded to: $planType');

    } catch (e) {
      isLoading.value = false;

      _showErrorSnackbar(
        title: SubscriptionStrings.subscriptionFailedTitle,
        message: SubscriptionStrings.subscriptionFailedMessage,
      );

      print('❌ Error upgrading: $e');
    }
  }

  /// Show Success Snackbar
  void _showSuccessSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show Error Snackbar
  void _showErrorSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show Info Snackbar
  void _showInfoSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primaryGold.withOpacity(0.9),
      colorText: Colors.black,
      icon: const Icon(Icons.info, color: Colors.black),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}