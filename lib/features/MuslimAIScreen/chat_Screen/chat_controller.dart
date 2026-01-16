import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/constants/ app_strings.dart';


class ChatController extends GetxController {
  // Text editing controller
  final TextEditingController messageController = TextEditingController();

  // Focus node for text field
  final FocusNode messageFocusNode = FocusNode();

  // Scroll controller for chat list
  final ScrollController scrollController = ScrollController();

  // Loading state
  RxBool isLoading = false.obs;
  RxBool isSending = false.obs;

  // User plan and message limits
  RxBool isPremiumUser = false.obs;
  RxInt messagesLeft = 10.obs;
  final int freeMessageLimit = 10;

  // Chat messages
  RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      id: '1',
      text: 'Can you explain some effective time management strategies for study, but please include the most practical ones that I can start applying today.',
      isUser: true,
      isSent: true,
      isDelivered: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage(
      id: '2',
      text: 'Effective time management starts with prioritization: use the Eisenhower Matrix to separate urgent vs important tasks. Try the Pomodoro Technique to stay focused in short sprints. Always set clear, achievable goals. Stay organized, stay motivated, reward yourself for completing tasks and keep track.',
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    ChatMessage(
      id: '3',
      text: 'Those sound useful! Can you give me an example of how to use the Pomodoro Technique in a typical weekday?',
      isUser: true,
      isSent: true,
      isDelivered: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage(
      id: '4',
      text: 'Effective time management starts with prioritization: use the Eisenhower Matrix to separate urgent vs important tasks. Try the Pomodoro Technique to stay focused in short sprints. Always plan your day ahead and set realistic goals. To stay motivated, reward yourself for completing tasks and keep track.',
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Scroll to bottom when opening
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // ============================================================================
  // GET PLAN TEXT
  // ============================================================================

  String get planText {
    return isPremiumUser.value ? AppStrings.premiumPlan : AppStrings.freePlan;
  }

  String get planBadgeText {
    if (isPremiumUser.value) {
      return 'Unlimited';
    } else {
      return '${messagesLeft.value} ${AppStrings.questionsLeft}';
    }
  }

  // ============================================================================
  // SEND MESSAGE
  // ============================================================================

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // Check if user has messages left (only for free users)
    if (!isPremiumUser.value && messagesLeft.value <= 0) {
      _showDailyLimitDialog();
      return;
    }

    // Decrease message count for free users
    if (!isPremiumUser.value) {
      messagesLeft.value--;
    }

    // Add user message with "sending" status
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      isSent: false,
      isDelivered: false,
      timestamp: DateTime.now(),
    );

    messages.add(userMessage);
    messageController.clear();
    _scrollToBottom();

    // Show single check after 500ms (sent)
    Future.delayed(const Duration(milliseconds: 500), () {
      final index = messages.indexWhere((msg) => msg.id == userMessage.id);
      if (index != -1) {
        messages[index] = messages[index].copyWith(isSent: true);
        messages.refresh();
      }
    });

    // Show double check after 1.5 seconds (delivered)
    Future.delayed(const Duration(milliseconds: 1500), () {
      final index = messages.indexWhere((msg) => msg.id == userMessage.id);
      if (index != -1) {
        messages[index] = messages[index].copyWith(
          isSent: true,
          isDelivered: true,
        );
        messages.refresh();
      }
    });

    // Simulate AI response
    isSending.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'This is a simulated AI response to: $text',
        isUser: false,
        timestamp: DateTime.now(),
      );
      messages.add(aiMessage);
      isSending.value = false;
      _scrollToBottom();
    });
  }

  // ============================================================================
  // SHOW DAILY LIMIT DIALOG
  // ============================================================================

  void _showDailyLimitDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF3A3A3A),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lock Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock,
                  color: const Color(0xFFCCA766),
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                AppStrings.dailyLimitReached,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Message
              Text(
                AppStrings.dailyLimitMessage,
                style: TextStyle(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SF Pro',
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Upgrade Button
              InkWell(
                onTap: () {
                  Get.back();
                  _upgradeToPremium();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB8955C),
                        Color(0xFFfee685),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.upgradeToPremium,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  // ============================================================================
  // UPGRADE TO PREMIUM
  // ============================================================================

  void _upgradeToPremium() {
    // TODO: Navigate to premium subscription screen
    // For now, just simulate upgrade
    isPremiumUser.value = true;
    messagesLeft.value = -1; // Unlimited

    Get.snackbar(
      'Success',
      'Upgraded to Premium! Enjoy unlimited messages.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF2A2A2A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  // ============================================================================
  // COPY MESSAGE
  // ============================================================================

  void copyMessage(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      AppStrings.copied,
      AppStrings.messageCopied,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
      backgroundColor: const Color(0xFF2A2A2A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  // ============================================================================
  // SCROLL TO BOTTOM
  // ============================================================================

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

// ============================================================================
// CHAT MESSAGE MODEL
// ============================================================================

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isLiked;
  final bool isDisliked;
  final bool isSent;
  final bool isDelivered;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isLiked = false,
    this.isDisliked = false,
    this.isSent = false,
    this.isDelivered = false,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    bool? isLiked,
    bool? isDisliked,
    bool? isSent,
    bool? isDelivered,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      isDisliked: isDisliked ?? this.isDisliked,
      isSent: isSent ?? this.isSent,
      isDelivered: isDelivered ?? this.isDelivered,
    );
  }
}