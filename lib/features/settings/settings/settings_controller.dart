import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'settings_strings.dart';

class SettingsController extends GetxController {
  // Observable Settings
  final selectedLanguage = SettingsStrings.english.obs;
  final selectedTheme = SettingsStrings.dark.obs;
  final selectedVideoQuality = SettingsStrings.comingSoon.obs;
  final notificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  /// Load saved settings
  void _loadSettings() {
    // TODO: Load from SharedPreferences or local storage
    // For now, use defaults
    selectedLanguage.value = SettingsStrings.english;
    selectedTheme.value = SettingsStrings.dark;
    selectedVideoQuality.value = SettingsStrings.comingSoon;
    notificationsEnabled.value = true;

    print('📱 Settings loaded');
  }

  /// Get notification status text
  String get notificationStatus => notificationsEnabled.value
      ? SettingsStrings.on
      : SettingsStrings.off;

  /// ============================================================================
  /// LANGUAGE SETTING
  /// ============================================================================
  void openLanguageSettings() {
    _showOptionsDialog(
      title: SettingsStrings.selectLanguageTitle,
      options: const [
        SettingsStrings.english,
        SettingsStrings.arabic,
      ],
      currentValue: selectedLanguage.value,
      onSelect: (value) {
        selectedLanguage.value = value;
        _saveSettings();
      },
    );
  }

  /// ============================================================================
  /// THEME SETTING
  /// ============================================================================
  void openThemeSettings() {
    _showOptionsDialog(
      title: SettingsStrings.selectThemeTitle,
      options: const [
        SettingsStrings.dark,
        SettingsStrings.light,
      ],
      currentValue: selectedTheme.value,
      onSelect: (value) {
        selectedTheme.value = value;
        _saveSettings();
        // TODO: Apply theme change
        // Get.changeTheme(value == 'Dark' ? darkTheme : lightTheme);
      },
    );
  }

  /// ============================================================================
  /// VIDEO QUALITY SETTING (Coming Soon - Non-functional)
  /// ============================================================================
  void openVideoQualitySettings() {
    // Coming soon - do nothing
    print('📹 Video Quality: Coming soon');
  }

  /// ============================================================================
  /// NOTIFICATIONS SETTING
  /// ============================================================================
  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
    _saveSettings();

    final status = notificationsEnabled.value ? 'on' : 'off';
    print('✅ Notifications $status');
  }

  /// ============================================================================
  /// OPTIONS DIALOG
  /// ============================================================================
  void _showOptionsDialog({
    required String title,
    required List<String> options,
    required String currentValue,
    required Function(String) onSelect,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'SF Pro',
                ),
              ),

              const SizedBox(height: 20),

              // Options
              ...options.map((option) => _buildOptionItem(
                option: option,
                isSelected: option == currentValue,
                onTap: () {
                  Get.back();
                  onSelect(option);
                },
              )),

              const SizedBox(height: 12),

              // Cancel Button
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Option Item Widget
  Widget _buildOptionItem({
    required String option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGold.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.primaryGold, width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.primaryGold : Colors.white,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryGold,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  /// ============================================================================
  /// SAVE SETTINGS
  /// ============================================================================
  void _saveSettings() {
    // TODO: Save to SharedPreferences or local storage
    // await prefs.setString('language', selectedLanguage.value);
    // await prefs.setString('theme', selectedTheme.value);
    // await prefs.setString('videoQuality', selectedVideoQuality.value);
    // await prefs.setBool('notifications', notificationsEnabled.value);

    print('💾 Settings saved');
  }
}