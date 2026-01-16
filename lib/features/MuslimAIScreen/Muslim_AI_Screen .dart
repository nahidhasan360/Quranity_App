import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/widgets/custom_navigation_bar.dart';

import 'package:get/get.dart';
import '../../core/constants/ app_strings.dart';
import '../../widgets/reusable_gradient.dart';

class MuslimAIScreen extends StatelessWidget {
  const MuslimAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildCategoryGrid(),
                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomNavbar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.muslimAI,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro',
            ),
          ),
          _buildPlanBadge(),
        ],
      ),
    );
  }

  Widget _buildPlanBadge() {
    const questionsLeft = 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            AppStrings.freePlan,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$questionsLeft ${AppStrings.questionsLeft}',
            style: const TextStyle(
              color: Color(0xFFFFB800),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = _getCategories();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }

  List<CategoryModel> _getCategories() {
    return [
      CategoryModel(
        title: AppStrings.categoryWisdom,
        subtitle: AppStrings.categoryWisdomSubtitle,
        svgIcon: 'assets/icons/wisdom.svg',
        fallbackIcon: Icons.menu_book_outlined,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D7A6E), Color(0xFF1F5347)],
        ),
      ),
      CategoryModel(
        title: AppStrings.categoryChallenges,
        subtitle: AppStrings.categoryChallengesSubtitle,
        svgIcon: 'assets/icons/challenges.svg',
        fallbackIcon: Icons.calendar_today_outlined,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A5F7A), Color(0xFF2F3E51)],
        ),
      ),
      CategoryModel(
        title: AppStrings.categorySpirituality,
        subtitle: AppStrings.categorySpiritualitySubtitle,
        svgIcon: 'assets/icons/spirituality.svg',
        fallbackIcon: Icons.favorite_outline,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B4963), Color(0xFF4A2F43)],
        ),
      ),
      CategoryModel(
        title: AppStrings.categoryCharacter,
        subtitle: AppStrings.categoryCharacterSubtitle,
        svgIcon: 'assets/icons/character.svg',
        fallbackIcon: Icons.self_improvement_outlined,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B5B9A), Color(0xFF4A3D6B)],
        ),
      ),
      CategoryModel(
        title: AppStrings.categoryKnowledge,
        subtitle: AppStrings.categoryKnowledgeSubtitle,
        svgIcon: 'assets/icons/knowledge.svg',
        fallbackIcon: Icons.school_outlined,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B5B4A), Color(0xFF4A3D32)],
        ),
      ),
      CategoryModel(
        title: AppStrings.categoryRelationship,
        subtitle: AppStrings.categoryRelationshipSubtitle,
        svgIcon: 'assets/icons/relationship.svg',
        fallbackIcon: Icons.people_outline,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A4A4A), Color(0xFF2F2F2F)],
        ),
      ),
    ];
  }

  Widget _buildBottomButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFBE9751), // Gold
            Color(0xFFB7A688), // Lighter gold
            Color(0xFFBE9751), // Lighter gold
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.medGrey.withOpacity(0.9),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: -20,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.chat);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome, size: 20, color: Colors.black),
                const SizedBox(width: 10),
                // Text
                const Text(
                  AppStrings.askToMuslimAI,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CATEGORY CARD WIDGET
// ============================================================================

class CategoryCard extends StatefulWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to category detail
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: widget.category.gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                widget.category.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro',
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.category.subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: 'SF Pro',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return FutureBuilder<bool>(
      future: _checkAssetExists(widget.category.svgIcon),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        }

        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: snapshot.hasData && snapshot.data == true
                ? SvgPicture.asset(
                    widget.category.svgIcon,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(
                    widget.category.fallbackIcon,
                    size: 22,
                    color: Colors.white,
                  ),
          ),
        );
      },
    );
  }

  Future<bool> _checkAssetExists(String path) async {
    try {
      await DefaultAssetBundle.of(context).load(path);
      return true;
    } catch (e) {
      debugPrint('Asset not found: $path');
      return false;
    }
  }
}

// ============================================================================
// CATEGORY MODEL
// ============================================================================

class CategoryModel {
  final String title;
  final String subtitle;
  final String svgIcon;
  final IconData fallbackIcon;
  final Gradient gradient;

  const CategoryModel({
    required this.title,
    required this.subtitle,
    required this.svgIcon,
    required this.fallbackIcon,
    required this.gradient,
  });
}
