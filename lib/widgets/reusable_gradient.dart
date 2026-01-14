// ============================================================================
// APP GRADIENTS - REUSABLE GRADIENTS
// All gradients in one place for consistency
// ============================================================================

import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

class AppGradients {
  static const RadialGradient backgroundRadialGradient = RadialGradient(
    center: Alignment(0.0, -0.8),
    radius: 1.2,
    colors: [
      Color(0xFF4D4943),
      Color(0xFF3F3C38),
      Color(0xFF33302C),
      Color(0xFF272420),
      Color(0xFF1C1916),
      Color(0xFF11100E),
      Color(0xFF000000),
    ],
    stops: [0.0, 0.14, 0.3, 0.5, 0.65, 0.82, 1.0],
    tileMode: TileMode.clamp,
  );

  // Main background gradient (linear - backup)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4D4943), // Top
      Color(0xFF3F3C38),
      Color(0xFF33302C),
      Color(0xFF272420),
      Color(0xFF1C1916),
      Color(0xFF11100E),
      Color(0xFF000000), // Bottom
    ],
    stops: [0.0, 0.15, 0.3, 0.5, 0.65, 0.82, 1.0],
  );

  // Gold gradient (for next prayer card)
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryGold, AppColors.primaryGoldLight],
  );

  // Card gradient (for daily verse card)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A4A4A), Color(0xFF3A3A3A)],
  );
}

// ============================================================================
// REUSABLE GRADIENT CONTAINER WIDGET
// For wrapping content with gradient background
// ============================================================================

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final bool useRadialGradient;

  const GradientBackground({
    super.key,
    required this.child,
    this.gradient,
    this.useRadialGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        gradient:
            gradient ??
            (useRadialGradient
                ? AppGradients.backgroundRadialGradient
                : AppGradients.backgroundGradient),
      ),
      child: child,
    );
  }
}
