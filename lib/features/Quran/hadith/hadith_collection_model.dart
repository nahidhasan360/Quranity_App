// ============================================================================
// HADITH COLLECTION MODEL
// Location: lib/app/data/models/hadith_collection_model.dart
// ============================================================================

class HadithCollection {
  final int id;
  final String nameEnglish;
  final String nameArabic;
  final String narrator;
  final int totalHadiths;
  final String color; // Hex color
  final bool isSaved;

  HadithCollection({
    required this.id,
    required this.nameEnglish,
    required this.nameArabic,
    required this.narrator,
    required this.totalHadiths,
    required this.color,
    this.isSaved = false,
  });

  // From JSON
  factory HadithCollection.fromJson(Map<String, dynamic> json) {
    return HadithCollection(
      id: json['id'] ?? 0,
      nameEnglish: json['name_english'] ?? json['nameEnglish'] ?? '',
      nameArabic: json['name_arabic'] ?? json['nameArabic'] ?? '',
      narrator: json['narrator'] ?? '',
      totalHadiths: json['total_hadiths'] ?? json['totalHadiths'] ?? 0,
      color: json['color'] ?? '#D4A574',
      isSaved: json['is_saved'] ?? json['isSaved'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_english': nameEnglish,
      'name_arabic': nameArabic,
      'narrator': narrator,
      'total_hadiths': totalHadiths,
      'color': color,
      'is_saved': isSaved,
    };
  }

  // Copy with
  HadithCollection copyWith({
    int? id,
    String? nameEnglish,
    String? nameArabic,
    String? narrator,
    int? totalHadiths,
    String? color,
    bool? isSaved,
  }) {
    return HadithCollection(
      id: id ?? this.id,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      nameArabic: nameArabic ?? this.nameArabic,
      narrator: narrator ?? this.narrator,
      totalHadiths: totalHadiths ?? this.totalHadiths,
      color: color ?? this.color,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  String toString() {
    return 'HadithCollection(id: $id, nameEnglish: $nameEnglish, totalHadiths: $totalHadiths)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HadithCollection &&
        other.id == id &&
        other.nameEnglish == nameEnglish &&
        other.nameArabic == nameArabic;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nameEnglish.hashCode ^ nameArabic.hashCode;
  }
}