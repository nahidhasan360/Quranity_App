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
                    'To use this option, your permit must be imported from your device storage or online storage such as iCloud, Google Drive or DropBox. The permit cannot be imported directly from your email attachment.\n\nYou can import multiple permits one at a time. Each permit must be processed and directions appear in the editing text field before importing the next.',
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