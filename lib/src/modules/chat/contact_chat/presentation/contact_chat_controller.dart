import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/chat/chat_service.dart';

class ContactChatController {
  final ChatService _chatService = GetIt.instance<ChatService>();

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int lastUnreadCount = 0;

  final ValueNotifier<bool> fabVisibility = ValueNotifier(false);
  final FocusNode messageFieldFocusNode = FocusNode();

  Stream<List<MessageModel>> getMessages(String targetId) {
    return _chatService.getUserMessages(targetId);
  }

  Future<void> markMessagesAsRead(
    String? currentUserId,
    String otherUserId,
  ) async {
    lastUnreadCount = 0;
    await _chatService.markMessagesAsRead(currentUserId, otherUserId);
  }

  Future<void> sendMessage({
    required String? currentUserId,
    required String targetId,
  }) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    try {
      textController.clear();
      await _chatService.sendMessage(
        currentUserId: currentUserId,
        targetId: targetId,
        text: text,
      );
    } catch (e) {
      rethrow;
    } finally {
      jumpToBottom();
    }
  }

  void jumpToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void handleUserScrollNotification({
    required UserScrollNotification notification,
    required VoidCallback markMessagesAsReadCallback,
    required VoidCallback onStartScroll,
    required VoidCallback onStopScroll,
  }) {
    if (notification.direction != ScrollDirection.idle) {
      onStartScroll();

      if (lastUnreadCount > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          markMessagesAsReadCallback();
        });
      }
    } else {
      onStopScroll();
    }
  }

  void handleFABVisibility() {
    if (!scrollController.hasClients) return;
    final controllerPosition = scrollController.position;
    if (!controllerPosition.hasContentDimensions) return;

    final distanceFromBottom =
        controllerPosition.maxScrollExtent - controllerPosition.pixels;

    const minDistanceToShowFAB = 300;

    fabVisibility.value = distanceFromBottom > minDistanceToShowFAB;
  }

  void handleScrollToBottomWhenKeayboardAppears() {
    if (!scrollController.hasClients) return;

    final controllerPosition = scrollController.position;
    if (!controllerPosition.hasContentDimensions) return;

    final distanceFromBottom =
        controllerPosition.maxScrollExtent - controllerPosition.pixels;

    const minDistanceToScrollDown = 300;

    final canScrollDown = distanceFromBottom < minDistanceToScrollDown;

    if (messageFieldFocusNode.hasFocus && canScrollDown) {
      Future.delayed(const Duration(milliseconds: 280), () {
        jumpToBottom();
      });
    }
  }

  void scrollToBottomIfNeeded({
    required BuildContext context,
    required bool isUserScrolling,
    required bool isFirstScroll,
    required VoidCallback onFirstScrollHandled,
  }) {
    if (isUserScrolling) return;

    if (!scrollController.hasClients) return;

    final position = scrollController.position;
    final isNearBottom = position.hasContentDimensions &&
        (position.maxScrollExtent - position.pixels) <
            MediaQuery.sizeOf(context).height / 3;

    if (isFirstScroll) {
      jumpToBottom();
      onFirstScrollHandled();
    } else if (isNearBottom) {
      animateToBottom();
    }
  }

  void animateToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void dispose() {
    fabVisibility.dispose();
    messageFieldFocusNode.dispose();
    textController.dispose();
    scrollController.dispose();
  }
}
