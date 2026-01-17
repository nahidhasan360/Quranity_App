// ============================================================================
// SURAH MODEL - Data model for Surah
// Location: lib/app/data/models/surah_model.dart
// ============================================================================

class Surah {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String nameBengali;
  final int numberOfAyahs;
  final String revelationType; // 'Meccan' or 'Medinan'
  final bool isSaved;

  Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameBengali,
    required this.numberOfAyahs,
    required this.revelationType,
    this.isSaved = false,
  });

  // From JSON
  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'] ?? 0,
      nameArabic: json['name_arabic'] ?? json['nameArabic'] ?? '',
      nameEnglish: json['name_english'] ?? json['nameEnglish'] ?? '',
      nameBengali: json['name_bengali'] ?? json['nameBengali'] ?? '',
      numberOfAyahs: json['number_of_ayahs'] ?? json['numberOfAyahs'] ?? json['ayahs'] ?? 0,
      revelationType: json['revelation_type'] ?? json['revelationType'] ?? json['type'] ?? 'Meccan',
      isSaved: json['is_saved'] ?? json['isSaved'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name_arabic': nameArabic,
      'name_english': nameEnglish,
      'name_bengali': nameBengali,
      'number_of_ayahs': numberOfAyahs,
      'revelation_type': revelationType,
      'is_saved': isSaved,
    };
  }

  // Copy with (for updating fields)
  Surah copyWith({
    int? number,
    String? nameArabic,
    String? nameEnglish,
    String? nameBengali,
    int? numberOfAyahs,
    String? revelationType,
    bool? isSaved,
  }) {
    return Surah(
      number: number ?? this.number,
      nameArabic: nameArabic ?? this.nameArabic,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      nameBengali: nameBengali ?? this.nameBengali,
      numberOfAyahs: numberOfAyahs ?? this.numberOfAyahs,
      revelationType: revelationType ?? this.revelationType,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  // toString for debugging
  @override
  String toString() {
    return 'Surah(number: $number, nameEnglish: $nameEnglish, nameArabic: $nameArabic, ayahs: $numberOfAyahs, type: $revelationType)';
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Surah &&
        other.number == number &&
        other.nameArabic == nameArabic &&
        other.nameEnglish == nameEnglish &&
        other.nameBengali == nameBengali &&
        other.numberOfAyahs == numberOfAyahs &&
        other.revelationType == revelationType &&
        other.isSaved == isSaved;
  }

  @override
  int get hashCode {
    return number.hashCode ^
    nameArabic.hashCode ^
    nameEnglish.hashCode ^
    nameBengali.hashCode ^
    numberOfAyahs.hashCode ^
    revelationType.hashCode ^
    isSaved.hashCode;
  }
}