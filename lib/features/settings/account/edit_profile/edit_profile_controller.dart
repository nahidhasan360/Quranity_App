import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'edit_profile_strings.dart';

class EditProfileController extends GetxController {
  // Form Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  // Observable States
  final isLoading = false.obs;
  final selectedImagePath = ''.obs;

  // Image Picker
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  /// Load user data (from API or local storage)
  void _loadUserData() {
    // TODO: Load from API or local storage
    fullNameController.text = 'John Doe';
    emailController.text = 'john@example.com';
  }

  /// Change Profile Photo
  void changePhoto() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              EditProfileStrings.selectPhotoSource,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Camera Option
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primaryGold),
              title: const Text(
                EditProfileStrings.camera,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),

            // Gallery Option
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primaryGold),
              title: const Text(
                EditProfileStrings.gallery,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),

            const SizedBox(height: 10),

            // Cancel Button
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                EditProfileStrings.cancel,
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (image != null) {
        selectedImagePath.value = image.path;
        print('✅ Image selected: ${image.path}');
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      _showErrorSnackbar(
        title: EditProfileStrings.profileUpdatedTitle,
        message: 'Failed to pick image',
      );
    }
  }

  /// Validate Form
  bool _validateForm() {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: EditProfileStrings.emptyNameError,
      );
      return false;
    }

    if (email.isEmpty) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: EditProfileStrings.emptyEmailError,
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      _showErrorSnackbar(
        title: 'Validation Error',
        message: EditProfileStrings.invalidEmailError,
      );
      return false;
    }

    return true;
  }

  /// Save Profile Changes
  Future<void> saveChanges() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Call API to update profile
      // await profileApi.updateProfile(
      //   name: fullNameController.text,
      //   email: emailController.text,
      //   image: selectedImagePath.value,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Show success message
      _showSuccessSnackbar(
        title: EditProfileStrings.profileUpdatedTitle,
        message: EditProfileStrings.profileUpdatedMessage,
      );

      // Go back to previous screen
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();

      print('✅ Profile updated successfully');

    } catch (e) {
      isLoading.value = false;

      _showErrorSnackbar(
        title: 'Error',
        message: EditProfileStrings.updateFailedError,
      );

      print('❌ Error updating profile: $e');
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
}