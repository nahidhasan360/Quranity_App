import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final Color? color;
  final Color? color1;
  final Color? color2;
  final Color? color3;

  const PageIndicator({
    super.key,
    this.color,
    this.color1,
    this.color2,
    this.color3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First indicator - Rounded Rectangle (Active)
        Container(
          height: 6,
          width: 48, // Longer width for pill shape
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color ?? const Color(0xFFd4a574), // Golden color
            borderRadius: BorderRadius.circular(10), // Pill shape
          ),
        ),

        // Second indicator - Circle
        Container(
          height: 6,
          width: 22, // Longer width for pill shape
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color1 ?? const Color(0xffBFBFBF), // Golden color
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // Third indicator - Circle
        Container(
          height: 6,
          width: 22,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color2 ?? const Color(0xffBFBFBF),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Fourth indicator - Circle
        Container(
          height: 6,
          width: 22, // Longer width for pill shape
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color3 ?? const Color(0xffBFBFBF),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}