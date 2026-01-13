// ============================================================================
// APP GRADIENTS - REUSABLE GRADIENTS
// All gradients in one place for consistency
// ============================================================================

import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

class AppGradients {
  // Main background gradient (dark to black)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3E3931),  // Top - Charcoal gray
      Color(0xFF2D2B27),  // Upper middle
      Color(0xFF1A1916),  // Lower middle
      Color(0xFF0D0C0B),  // Near bottom
      Color(0xFF000000),  // Bottom - Pure black
    ],
    stops: [0.0, 0.3, 0.5, 0.75, 1.0],
  );

  // Gold gradient (for next prayer card)
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryGold,
      AppColors.primaryGoldLight,
    ],
  );

  // Card gradient (for daily verse card)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
    ],
  );
}

// ============================================================================
// REUSABLE GRADIENT CONTAINER WIDGET
// For wrapping content with gradient background
// ============================================================================

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;

  const GradientBackground({
    super.key,
    required this.child,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.backgroundGradient,
      ),
      child: child,
    );
  }
}