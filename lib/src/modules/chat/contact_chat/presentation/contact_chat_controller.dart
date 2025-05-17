import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/chat/chat_service.dart';

class ContactChatController {
  final ChatService _chatService = GetIt.instance<ChatService>();

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int lastUnreadCount = 0;

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

  void animateToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
