import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // Observable Toggle States
  final prayerTimesEnabled = true.obs;
  final dailyVerseEnabled = true.obs;
  final readingRemindersEnabled = false.obs;
  final newVideoReleasesEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationSettings();
  }

  /// Load saved notification settings
  void _loadNotificationSettings() {
    // TODO: Load from SharedPreferences or local storage
    // For now, use defaults
    prayerTimesEnabled.value = true;
    dailyVerseEnabled.value = true;
    readingRemindersEnabled.value = false;
    newVideoReleasesEnabled.value = false;

    print('🔔 Notification settings loaded');
  }

  /// ============================================================================
  /// TOGGLE METHODS
  /// ============================================================================

  /// Toggle Prayer Times Notifications
  void togglePrayerTimes(bool value) {
    prayerTimesEnabled.value = value;
    _saveSettings();
    print('🕌 Prayer Times: ${value ? "ON" : "OFF"}');
  }

  /// Toggle Daily Verse Notifications
  void toggleDailyVerse(bool value) {
    dailyVerseEnabled.value = value;
    _saveSettings();
    print('📖 Daily Verse: ${value ? "ON" : "OFF"}');
  }

  /// Toggle Reading Reminders
  void toggleReadingReminders(bool value) {
    readingRemindersEnabled.value = value;
    _saveSettings();
    print('📚 Reading Reminders: ${value ? "ON" : "OFF"}');
  }

  /// Toggle New Video Releases Notifications
  void toggleNewVideoReleases(bool value) {
    newVideoReleasesEnabled.value = value;
    _saveSettings();
    print('🎥 New Video Releases: ${value ? "ON" : "OFF"}');
  }

  /// ============================================================================
  /// SAVE SETTINGS
  /// ============================================================================
  void _saveSettings() {
    // TODO: Save to SharedPreferences or local storage
    // await prefs.setBool('prayerTimes', prayerTimesEnabled.value);
    // await prefs.setBool('dailyVerse', dailyVerseEnabled.value);
    // await prefs.setBool('readingReminders', readingRemindersEnabled.value);
    // await prefs.setBool('newVideoReleases', newVideoReleasesEnabled.value);

    print('💾 Notification settings saved');
  }
}