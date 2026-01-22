import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════
/// Muslim AI Info Dialog
/// ═══════════════════════════════════════════════════════════
void muslimAiDialogForShorts(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder:  (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF4A4A4A), // medGrey
            borderRadius:  BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color:  Colors.white,
                    size: 28,
                  ),
                  GestureDetector(
                    onTap:  () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    'By using this feature, you acknowledge that the content provided is for educational and reflective purposes only. It is not intended as religious rulings or fatwas. For specific religious guidance, please consult a qualified scholar. Additionally, the creation, generation, or copying of videos is prohibited. This feature is intended solely for educational purposes, and we remind you to use it mindfully, avoiding excessive use and focusing on its intended educational value',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}