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

    // Mock data - Replace with API call
    stories.value = [
      StoryModel(
        id: '1',
        title: 'Understanding Salah: Step by Step',
        imageUrl: 'assets/images/story1.jpg',
        duration: '1M+ Views',
        views: '4M+ views',
        category: 'Quran Story',
        isNew: true,
      ),
      StoryModel(
        id: '2',
        title: 'Understanding Salah: Step by Step',
        imageUrl: 'assets/images/story2.jpg',
        duration: '1M+ Views',
        views: '4M+ views',
        category: 'Prophet Story',
        isNew: true,
      ),
      StoryModel(
        id: '3',
        title: 'Understanding Salah: Step by Step',
        imageUrl: 'assets/images/story3.jpg',
        duration: '1M+ Views',
        views: '4M+ views',
        category: 'Islamic Story',
        isNew: false,
      ),
    ];

    isLoading.value = false;
  }

  // ========== FILTER BY CATEGORY ==========
  void selectCategory(String category) {
    selectedCategory.value = category;
    // Filter stories based on category
    if (category == 'All') {
      _loadStories();
    } else {
      stories.value = stories.where((story) => story.category == category).toList();
    }
  }

  // ========== OPEN STORY ==========
  void openStory(String storyId) {
    // Navigate to story detail screen
    // Get.toNamed(AppRoutes.storyDetail, arguments: storyId);
    Get.snackbar(
      'Story',
      'Opening story: $storyId',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ========== SHOW CATEGORIES BOTTOM SHEET ==========
  void showCategoriesBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Category',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...categories.map((category) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  category,
                  style: const TextStyle(color: Colors.white),
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
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }
}

// ========== STORY MODEL ==========
class StoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String views;
  final String category;
  final bool isNew;

  StoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.views,
    required this.category,
    this.isNew = false,
  });
}