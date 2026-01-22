import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            image:  AssetImage(AppAssets. registration),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child:   Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children:  [
                const SizedBox(height: 40),

                // App Icon
                Image. asset(
                  AppAssets.appLogo,
                  width: 180,
                  height: 180,
                ),

                const Spacer(),
                const SizedBox(height:  40),

                SizedBox(
                  width: double. infinity,
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Text
                      const Text(
                        'Welcome!  ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color:   Color(0xFFF4F4F4),
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

                // Sign In Button
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

                // Sign Up Button
                CustomPrimaryButton(
                  text: 'Sign Up',
                  isFilled: false,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro',
                  textHeight: 1.56,
                  onPressed:  () {
                    Get.  toNamed(AppRoutes.  signup);
                  },
                ),

                const SizedBox(height: 15),

                // Divider with Text
                _buildDividerWithText(),

                const SizedBox(height: 15),

                // Social Login Buttons
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Google Login
                    Expanded(
                      child: _buildSocialLoginButton(
                        svgPath: 'assets/icons/google.svg',
                        label: 'Login with Google',
                        backgroundColor: const Color(0xFF1F2937),
                        borderColor: AppColors.medGrey,
                        onPressed: () {
                          _handleGoogleSignIn(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Apple Login
                    Expanded(
                      child: _buildSocialLoginButton(
                        svgPath: 'assets/icons/apple.svg',
                        label: 'Login with Apple',
                        backgroundColor: const Color(0xFF1F2937),
                        borderColor: AppColors.medGrey,
                        onPressed: () {
                          _handleAppleSignIn(context);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height:  30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // DIVIDER WITH TEXT
  // ============================================================================
  Widget _buildDividerWithText() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF3F3F3F),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: AppColors.subtitle,
              fontSize: 12,
              fontFamily: 'SF Pro',
              fontWeight:  FontWeight.w400,
              height: 1.33,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color:  const Color(0xFF3F3F3F),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // SOCIAL LOGIN BUTTON WITH SVG ICON
  // ============================================================================
  Widget _buildSocialLoginButton({
    required String svgPath,
    required String label,
    required Color backgroundColor,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:  onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius. circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Icon
              SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  svgPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 8),
              // Label
              Text(
                label,
                style: const TextStyle(
                  color:  Color(0xFFF4F4F4),
                  fontSize:  14,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // GOOGLE SIGN IN HANDLER
  // ============================================================================
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      // TODO: Implement Google Sign In logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign In coming soon...  ')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // ============================================================================
  // APPLE SIGN IN HANDLER
  // ============================================================================
  Future<void> _handleAppleSignIn(BuildContext context) async {
    try {
      // TODO: Implement Apple Sign In logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text('Apple Sign In coming soon.. .')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}