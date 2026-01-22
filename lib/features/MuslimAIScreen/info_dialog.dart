import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════
/// Muslim AI Info Dialog
/// ═══════════════════════════════════════════════════════════
void muslimAiDialog(BuildContext context) {
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
                    'Muslim AI is not a mufti and does not issue religious rulings or fatwas. It offers answers based on authentic Quranic teachings and Hadith, but should not be considered a substitute for advice from qualified scholars. For specific religious guidance, please consult a qualified scholar. By using Muslim AI, you acknowledge that the responses provided are for informational and reflective purposes only.',
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