import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // Loading States
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  // Location
  final currentCity = 'Dhaka'.obs;
  final currentCountry = 'Bangladesh'.obs;
  final latitude = 23.8103.obs;
  final longitude = 90.4125.obs;

  // Current Time
  final localTime = ''.obs;
  final localPeriod = ''.obs;
  final meccaTime = ''.obs;
  final meccaPeriod = ''.obs;

  // Sunrise & Sunset
  final sunriseTime = ''.obs;
  final sunsetTime = ''.obs;

  // Daily Verse
  final arabicVerse = 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ'.obs;
  final verseTranslation = '"All praise is due to Allah,\nLord of all the worlds."'.obs;
  final surahInfo = 'SURAH AL-FATIHA • AYAH 1'.obs;

  // Next Prayer
  final nextPrayerName = 'Fajr'.obs;
  final nextPrayerTime = ''.obs;
  final nextPrayerCountdown = '0h 0m'.obs;
  final activePrayer = ''.obs;

  // Prayer Times
  final prayerTimes = <Map<String, dynamic>>[].obs;

  // Makruh & Nafal Times
  final makruhTimes = <Map<String, String>>[].obs;
  final nafalPrayers = <Map<String, String>>[].obs;

  // Asr Method
  final asrMethod = 'Standard'.obs;

  // Timer
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _initializePrayerTimes();
  }

  Future<void> _initializePrayerTimes() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      await _getCurrentLocation();
      await fetchPrayerTimes();
      _startTimeUpdater();

      isLoading.value = false;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
      print('❌ Error: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        currentCity.value = placemarks[0].locality ?? 'Unknown';
        currentCountry.value = placemarks[0].country ?? 'Unknown';
      }
    } catch (e) {
      currentCity.value = 'Dhaka';
      currentCountry.value = 'Bangladesh';
    }
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final now = DateTime.now();
      final dateString = DateFormat('dd-MM-yyyy').format(now);

      final url = 'http://api.aladhan.com/v1/timings/$dateString'
          '?latitude=${latitude.value}'
          '&longitude=${longitude.value}'
          '&method=2';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];
        _parsePrayerTimes(timings);
        _calculateNextPrayer();
      }
    } catch (e) {
      throw 'Failed to load prayer times';
    }
  }

  void _parsePrayerTimes(Map<String, dynamic> timings) {
    final fajr = _formatTime(timings['Fajr']);
    final dhuhr = _formatTime(timings['Dhuhr']);
    final asr = _formatTime(timings['Asr']);
    final maghrib = _formatTime(timings['Maghrib']);
    final isha = _formatTime(timings['Isha']);
    final sunrise = _formatTime(timings['Sunrise']);
    final sunset = _formatTime(timings['Sunset']);

    sunriseTime.value = sunrise['12h']!;
    sunsetTime.value = sunset['12h']!;

    prayerTimes.value = [
      {'name': 'FAJR', 'time': fajr['time'], 'period': fajr['period'], 'fullTime': fajr['24h']},
      {'name': 'DHUHR', 'time': dhuhr['time'], 'period': dhuhr['period'], 'fullTime': dhuhr['24h']},
      {'name': 'ASR', 'time': asr['time'], 'period': asr['period'], 'fullTime': asr['24h']},
      {'name': 'MAGHRIB', 'time': maghrib['time'], 'period': maghrib['period'], 'fullTime': maghrib['24h']},
      {'name': 'ISHA', 'time': isha['time'], 'period': isha['period'], 'fullTime': isha['24h']},
    ];

    _calculateMakruhTimes(sunrise, sunset, dhuhr);
    _calculateNafalTimes(sunrise);
  }

  Map<String, String> _formatTime(String time24) {
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];

    String period = hour >= 12 ? 'PM' : 'AM';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    return {
      '24h': time24,
      'time': '$hour:$minute',
      'period': period,
      '12h': '$hour:$minute $period',
    };
  }

  void _calculateMakruhTimes(
      Map<String, String> sunrise,
      Map<String, String> sunset,
      Map<String, String> dhuhr,
      ) {
    final sunriseEnd = _addMinutes(sunrise['24h']!, 15);
    final zawalStart = _subtractMinutes(dhuhr['24h']!, 15);
    final zawalEnd = dhuhr['12h'];
    final sunsetStart = _subtractMinutes(sunset['24h']!, 17);
    final sunsetEnd = _addMinutes(sunset['24h']!, 17);

    makruhTimes.value = [
      {'label': 'Sunrise:', 'time': '${sunrise['12h']} - $sunriseEnd'},
      {'label': 'Zawal:', 'time': '$zawalStart - $zawalEnd'},
      {'label': 'Sunset:', 'time': '$sunsetStart - $sunsetEnd'},
    ];
  }

  void _calculateNafalTimes(Map<String, String> sunrise) {
    final ishraq = _addMinutes(sunrise['24h']!, 15);

    nafalPrayers.value = [
      {'label': 'Ishraq:', 'time': ?ishraq},
      {'label': 'Chasht:', 'time': '09:00 AM'},
      {'label': 'Tahajjud:', 'time': '03:00 AM'},
    ];
  }

  String? _addMinutes(String time24, int minutes) {
    final parts = time24.split(':');
    var hour = int.parse(parts[0]);
    var minute = int.parse(parts[1]);

    minute += minutes;
    if (minute >= 60) {
      hour += minute ~/ 60;
      minute = minute % 60;
    }
    if (hour >= 24) hour -= 24;

    final formatted = _formatTime(
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
    );
    return formatted['12h'];
  }

  String? _subtractMinutes(String time24, int minutes) {
    final parts = time24.split(':');
    var hour = int.parse(parts[0]);
    var minute = int.parse(parts[1]);

    minute -= minutes;
    if (minute < 0) {
      hour -= 1;
      minute += 60;
    }
    if (hour < 0) hour += 24;

    final formatted = _formatTime(
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
    );
    return formatted['12h'];
  }

  void _calculateNextPrayer() {
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    for (var prayer in prayerTimes) {
      if (_compareTime(currentTime, prayer['fullTime']) < 0) {
        nextPrayerName.value = _capitalize(prayer['name']);
        nextPrayerTime.value = '${prayer['time']} ${prayer['period']}';
        activePrayer.value = prayer['name'];
        _calculateCountdown(prayer['fullTime']);
        return;
      }
    }

    if (prayerTimes.isNotEmpty) {
      nextPrayerName.value = 'Fajr';
      nextPrayerTime.value = '${prayerTimes[0]['time']} ${prayerTimes[0]['period']}';
      activePrayer.value = 'FAJR';
    }
  }

  int _compareTime(String time1, String time2) {
    final t1Parts = time1.split(':');
    final t2Parts = time2.split(':');
    final t1Hour = int.parse(t1Parts[0]);
    final t1Minute = int.parse(t1Parts[1]);
    final t2Hour = int.parse(t2Parts[0]);
    final t2Minute = int.parse(t2Parts[1]);

    if (t1Hour != t2Hour) return t1Hour.compareTo(t2Hour);
    return t1Minute.compareTo(t2Minute);
  }

  void _calculateCountdown(String targetTime) {
    final now = DateTime.now();
    final parts = targetTime.split(':');
    final targetHour = int.parse(parts[0]);
    final targetMinute = int.parse(parts[1]);

    var target = DateTime(now.year, now.month, now.day, targetHour, targetMinute);
    if (target.isBefore(now)) {
      target = target.add(const Duration(days: 1));
    }

    final difference = target.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    nextPrayerCountdown.value = '${hours}h ${minutes}m';
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void _startTimeUpdater() {
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCurrentTime();
      _calculateNextPrayer();
    });
  }

  void _updateCurrentTime() {
    final now = DateTime.now();

    int hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    localTime.value = '$hour:$minute';
    localPeriod.value = now.hour >= 12 ? 'PM' : 'AM';

    final meccaNow = now.add(const Duration(hours: 3));
    hour = meccaNow.hour > 12 ? meccaNow.hour - 12 : (meccaNow.hour == 0 ? 12 : meccaNow.hour);
    final meccaMinute = meccaNow.minute.toString().padLeft(2, '0');
    meccaTime.value = '$hour:$meccaMinute';
    meccaPeriod.value = meccaNow.hour >= 12 ? 'PM' : 'AM';
  }

  Future<void> refreshPrayerTimes() async {
    await _initializePrayerTimes();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}