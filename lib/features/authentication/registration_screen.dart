import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quranity/core/constants/app_assets.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/customPrimaryButton.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.registration),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // App Icon
                Image.asset(
                  AppAssets.appLogo,
                  width: 180,
                  height: 180,
                ),

                const Spacer(),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Text
                      const Text(
                        'Welcome!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color:  Color(0xFFF4F4F4),
                          fontSize: 26,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w700,
                          height: 1.54,
                          letterSpacing: -0.90,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Subtitle
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Now continue after register in ',
                              style: TextStyle(
                                color: AppColors.subtitle,
                                fontSize: 14,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                            const TextSpan(
                              text: '"Quranity".',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryGold,
                                height: 1.43,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                CustomPrimaryButton(
                  text: 'Sign In',
                  isFilled: true,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro',
                  textHeight: 1.56,
                  onPressed: () {
                    Get.toNamed(AppRoutes.login);
                  },
                ),

                const SizedBox(height: 16),

                CustomPrimaryButton(
                  text: 'Sign Up',
                  isFilled: false,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro',
                  textHeight: 1.56,
                  onPressed: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}