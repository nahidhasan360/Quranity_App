import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';

class StoriesController extends GetxController {
  // ========== OBSERVABLES ==========
  final RxBool isLoading = false.obs;
  final RxList<StoryModel> stories = <StoryModel>[].obs;
  final RxString selectedCategory = 'All'.obs;

  // ========== CATEGORIES ==========
  final List<String> categories = [
    'All',
    'Quran Story',
    'Prophet Story',
    'Islamic Story',
    'Hadith Story',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadStories();
  }

  // ========== LOAD STORIES ==========
  void _loadStories() {
    isLoading.value = true;

    // Sample data with network thumbnails and video URLs
    stories.value = [
      StoryModel(
        id: '1',
        title: 'Understanding Salah: Step by Step',
        thumbnailUrl: 'https://images.unsplash.com/photo-1591604466107-ec97de577aff?w=800',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        duration: '08:45',
        category: 'Faith Basics',
        channelName: 'Quranity',
        channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
        description: 'This video explores the profound meanings behind the verses. Join us as we delve into the history and context of this revelation.',
        isNew: true,
      ),
      StoryModel(
        id: '2',
        title: 'The Story of Prophet Ibrahim',
        thumbnailUrl: 'https://images.unsplash.com/photo-1609599006353-e629aaabfeae?w=800',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        duration: '10:30',
        category: 'Prophet Story',
        channelName: 'Quranity',
        channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
        description: 'Learn about the life and teachings of Prophet Ibrahim and his unwavering faith.',
        isNew: true,
      ),
      StoryModel(
        id: '3',
        title: 'The Importance of Ramadan',
        thumbnailUrl: 'https://images.unsplash.com/photo-1542816417-0983c9c9ad53?w=800',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        duration: '12:15',
        category: 'Islamic Story',
        channelName: 'Quranity',
        channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
        description: 'Discover the significance of Ramadan in Islam and its spiritual benefits.',
        isNew: false,
      ),
      StoryModel(
        id: '4',
        title: 'The Journey to Makkah',
        thumbnailUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        duration: '15:20',
        category: 'Quran Story',
        channelName: 'Quranity',
        channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
        description: 'Experience the spiritual journey of Hajj and its profound meaning.',
        isNew: false,
      ),
    ];

    isLoading.value = false;
  }

  // ========== FILTER BY CATEGORY ==========
  void selectCategory(String category) {
    selectedCategory.value = category;

    if (category == 'All') {
      _loadStories();
    } else {
      // Filter stories based on selected category
      final allStories = [
        StoryModel(
          id: '1',
          title: 'Understanding Salah: Step by Step',
          thumbnailUrl: 'https://images.unsplash.com/photo-1591604466107-ec97de577aff?w=800',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          duration: '08:45',
          category: 'Faith Basics',
          channelName: 'Quranity',
          channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
          description: 'This video explores the profound meanings behind the verses.',
          isNew: true,
        ),
        StoryModel(
          id: '2',
          title: 'The Story of Prophet Ibrahim',
          thumbnailUrl: 'https://images.unsplash.com/photo-1609599006353-e629aaabfeae?w=800',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          duration: '10:30',
          category: 'Prophet Story',
          channelName: 'Quranity',
          channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
          description: 'Learn about the life and teachings of Prophet Ibrahim.',
          isNew: true,
        ),
        StoryModel(
          id: '3',
          title: 'The Importance of Ramadan',
          thumbnailUrl: 'https://images.unsplash.com/photo-1542816417-0983c9c9ad53?w=800',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          duration: '12:15',
          category: 'Islamic Story',
          channelName: 'Quranity',
          channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
          description: 'Discover the significance of Ramadan in Islam.',
          isNew: false,
        ),
        StoryModel(
          id: '4',
          title: 'The Journey to Makkah',
          thumbnailUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          duration: '15:20',
          category: 'Quran Story',
          channelName: 'Quranity',
          channelLogo: 'https://ui-avatars.com/api/?name=Quranity&background=D4AF37&color=000',
          description: 'Experience the spiritual journey of Hajj.',
          isNew: false,
        ),
      ];

      stories.value = allStories.where((story) => story.category == category).toList();
    }
  }

  // ========== OPEN STORY - NAVIGATE TO VIDEO PLAYER ==========
  void openStory(StoryModel story) {
    // ⭐ Use Get.to() instead of Get.toNamed() to maintain back stack
    Get.toNamed(
      '/video-player',
      arguments: {
        'video': {
          'id': story.id,
          'title': story.title,
          'channelName': story.channelName,
          'channelLogo': story.channelLogo,
          'description': story.description,
          'videoUrl': story.videoUrl,
          'thumbnailUrl': story.thumbnailUrl,
        }
      },
    );
  }

  // ========== SHOW CATEGORIES BOTTOM SHEET ==========
  void showCategoriesBottomSheet() {
    Get.dialog(
      Stack(
        children: [
          // Transparent background to dismiss
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Dropdown menu - Full width with 16px padding
          Positioned(
            top: 120,
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3A).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: categories.map((category) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Obx(() => selectedCategory.value == category
                          ? Icon(Icons.check, color: AppColors.primaryGold)
                          : const SizedBox.shrink()),
                      onTap: () {
                        selectCategory(category);
                        Get.back();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: true,
    );
  }
}

// ========== STORY MODEL ==========
class StoryModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String duration;
  final String category;
  final String channelName;
  final String channelLogo;
  final String description;
  final bool isNew;

  StoryModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.category,
    required this.channelName,
    required this.channelLogo,
    required this.description,
    this.isNew = false,
  });

  // ========== TO MAP (For API integration) ==========
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'duration': duration,
      'category': category,
      'channelName': channelName,
      'channelLogo': channelLogo,
      'description': description,
      'isNew': isNew,
    };
  }

  // ========== FROM MAP (For API integration) ==========
  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      duration: map['duration'] ?? '00:00',
      category: map['category'] ?? '',
      channelName: map['channelName'] ?? '',
      channelLogo: map['channelLogo'] ?? '',
      description: map['description'] ?? '',
      isNew: map['isNew'] ?? false,
    );
  }

  // ========== COPY WITH ==========
  StoryModel copyWith({
    String? id,
    String? title,
    String? thumbnailUrl,
    String? videoUrl,
    String? duration,
    String? category,
    String? channelName,
    String? channelLogo,
    String? description,
    bool? isNew,
  }) {
    return StoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      channelName: channelName ?? this.channelName,
      channelLogo: channelLogo ?? this.channelLogo,
      description: description ?? this.description,
      isNew: isNew ?? this.isNew,
    );
  }
}