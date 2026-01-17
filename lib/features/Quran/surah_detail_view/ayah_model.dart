// ============================================================================
// AYAH MODEL
// Location: lib/features/Quran/models/ayah_model.dart
// ============================================================================

class Ayah {
  final int number;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final String textArabic;
  final String translationEnglish;
  final String transliteration;
  final bool isSajdah;

  Ayah({
    required this.number,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.textArabic,
    required this.translationEnglish,
    required this.transliteration,
    this.isSajdah = false,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'] ?? 0,
      numberInSurah: json['numberInSurah'] ?? 0,
      juz: json['juz'] ?? 0,
      manzil: json['manzil'] ?? 0,
      page: json['page'] ?? 0,
      ruku: json['ruku'] ?? 0,
      hizbQuarter: json['hizbQuarter'] ?? 0,
      textArabic: json['text'] ?? json['textArabic'] ?? '',
      translationEnglish: json['translation'] ?? json['translationEnglish'] ?? '',
      transliteration: json['transliteration'] ?? '',
      isSajdah: json['sajda'] ?? json['isSajdah'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'text': textArabic,
      'translation': translationEnglish,
      'transliteration': transliteration,
      'sajda': isSajdah,
    };
  }

  Ayah copyWith({
    int? number,
    int? numberInSurah,
    int? juz,
    int? manzil,
    int? page,
    int? ruku,
    int? hizbQuarter,
    String? textArabic,
    String? translationEnglish,
    String? transliteration,
    bool? isSajdah,
  }) {
    return Ayah(
      number: number ?? this.number,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      juz: juz ?? this.juz,
      manzil: manzil ?? this.manzil,
      page: page ?? this.page,
      ruku: ruku ?? this.ruku,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      textArabic: textArabic ?? this.textArabic,
      translationEnglish: translationEnglish ?? this.translationEnglish,
      transliteration: transliteration ?? this.transliteration,
      isSajdah: isSajdah ?? this.isSajdah,
    );
  }

  @override
  String toString() {
    return 'Ayah(number: $number, numberInSurah: $numberInSurah, page: $page)';
  }
}