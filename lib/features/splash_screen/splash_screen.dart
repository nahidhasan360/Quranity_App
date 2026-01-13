import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranity/app/routes/app_routes.dart';
import 'package:quranity/core/constants/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.onboarding);
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0.0),
            radius: 1.2,
            colors: [
              Color(0xFFB3A386),
              Color(0xFF3A352D),
              Color(0xFF000000),
            ],
            stops: [0.0, 0.52, 0.9],
          ),
        ),
        child: Image.asset(
          AppAssets.appLogo,
          width: 4,
          height: 4,
        ),
      ),
    );
  }
}