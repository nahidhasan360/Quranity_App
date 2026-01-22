import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranity/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    // Animation complete হলে next screen এ যাবে
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAllNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Lottie.asset(
            'assets/animations/animation.json',
            controller: _controller,
            width: 450,
            height: 390,
            fit: BoxFit.contain,
            repeat: false,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
              _controller.forward();
            },
          ),
        ),
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:quranity/app/routes/app_routes.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Future.delayed(const Duration(seconds: 3), () {
//     //   Get.offAllNamed(AppRoutes.onboarding);
//     // });
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0, 0.0),
//             radius: 1.2,
//             colors: [
//               Color(0xFFB3A386),
//               Color(0xFF3A352D),
//               Color(0xFF000000),
//             ],
//             stops: [0.0, 0.52, 0.9],
//           ),
//         ),
//         child: Center(
//           child: Lottie.asset(
//             'assets/animations/animation.json',
//             width: 250,
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//



















// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:quranity/app/routes/app_routes.dart';
// import 'package:quranity/core/constants/app_assets.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.offAllNamed(AppRoutes.onboarding);
//     });
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0, 0.0),
//             radius: 1.2,
//             colors: [
//               Color(0xFFB3A386),
//               Color(0xFF3A352D),
//               Color(0xFF000000),
//             ],
//             stops: [0.0, 0.52, 0.9],
//           ),
//         ),
//         child: Image.asset(
//           AppAssets.appLogo,
//           width: 4,
//           height: 4,
//         ),
//       ),
//     );
//   }
// }