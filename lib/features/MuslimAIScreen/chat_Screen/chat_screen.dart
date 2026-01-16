import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../../../core/constants/ app_strings.dart';
import '../../../widgets/reusable_gradient.dart';
import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(controller),
              Expanded(
                child: _buildChatList(controller),
              ),
              _buildMessageInput(controller),
            ],
          ),
        ),
      ),
    );
  }

// ============================================================================
// APP BAR
// ============================================================================

  Widget _buildAppBar(ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.all(8.r),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Title
          const Expanded(
            child: Text(
              AppStrings.muslimAI,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
          // Plan badge
          Obx(() {
            // Check if messages left is 0 for free users
            final isZeroLeft = !controller.isPremiumUser.value &&
                controller.messagesLeft.value == 0;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.planText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    controller.planBadgeText,
                    style: TextStyle(
                      // Red color when 0 left, otherwise gold/yellow
                      color: isZeroLeft
                          ? Colors.red
                          : controller.isPremiumUser.value
                          ? AppColors.primaryGoldLight
                          : const Color(0xFFFFB800),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ============================================================================
  // CHAT LIST
  // ============================================================================

  Widget _buildChatList(ChatController controller) {
    return Obx(() {
      return ListView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          return _buildMessageBubble(message, controller);
        },
      );
    });
  }

  // ============================================================================
  // MESSAGE BUBBLE
  // ============================================================================

  Widget _buildMessageBubble(ChatMessage message, ChatController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAIAvatar(),
          if (!message.isUser) SizedBox(width: 8.w),
          if (message.isUser)
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: _buildUserMessage(message)),
                  SizedBox(width: 8.w),
                  _buildUserAvatar(),
                ],
              ),
            )
          else
            Expanded(
              child: _buildAIMessage(message, controller),
            ),
        ],
      ),
    );
  }

  // ============================================================================
  // USER MESSAGE
  // ============================================================================

  Widget _buildUserMessage(ChatMessage message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(4.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              message.text,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'SF Pro',
                height: 1.3,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Icon(
            !message.isSent
                ? Icons.access_time
                : message.isDelivered
                ? Icons.done_all
                : Icons.done,
            size: 14.sp,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // AI MESSAGE
  // ============================================================================

  Widget _buildAIMessage(ChatMessage message, ChatController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(4.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'SF Pro',
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        _buildMessageActions(message, controller),
      ],
    );
  }

  // ============================================================================
  // MESSAGE ACTIONS (ONLY COPY BUTTON)
  // ============================================================================

  Widget _buildMessageActions(ChatMessage message, ChatController controller) {
    return InkWell(
      onTap: () => controller.copyMessage(message.text),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(6.r),
        child: Icon(
          Icons.content_copy,
          color: const Color(0xFF6B6B6B),
          size: 18.sp,
        ),
      ),
    );
  }

  // ============================================================================
  // AI AVATAR (NETWORK IMAGE)
  // ============================================================================

  Widget _buildAIAvatar() {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          'https://i.ibb.co/YQs3L6j/muslim-ai-avatar.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF2A2A2A),
              child: Icon(
                Icons.mosque,
                color: AppColors.primaryGold,
                size: 20.sp,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: const Color(0xFF2A2A2A),
              child: Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryGold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================================
  // USER AVATAR
  // ============================================================================

  Widget _buildUserAvatar() {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        color: const Color(0xFF9E9E9E),
        size: 18.sp,
      ),
    );
  }

  // ============================================================================
  // MESSAGE INPUT
  // ============================================================================

  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF3A3A3A),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: controller.messageController,
                focusNode: controller.messageFocusNode,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'SF Pro',
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.sendMessage,
                  hintStyle: TextStyle(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(() {
            return InkWell(
              onTap: controller.isSending.value ? null : controller.sendMessage,
              borderRadius: BorderRadius.circular(24.r),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: controller.isSending.value
                        ? [
                      const Color(0xFF6B6B6B),
                      const Color(0xFF6B6B6B),
                    ]
                        : [
                      AppColors.primaryGoldDark,
                      AppColors.primaryGoldLight,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: AppColors.black,
                  size: 20.sp,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}