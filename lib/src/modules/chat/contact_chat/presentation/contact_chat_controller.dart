import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/chat/chat_service.dart';

class ContactChatController {
  final ChatService _chatService = GetIt.instance<ChatService>();

  final TextEditingController textController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  Stream<List<MessageModel>> getMessages(String targetId) {
    return _chatService.getUserMessages(targetId);
  }

  Future<void> sendMessage({required String targetId}) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    try {
      await _chatService.sendMessage(
        targetId: targetId,
        text: text,
      );
    } catch (e) {
      rethrow;
    } finally {
      scrollToBottom();
      textController.clear();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
}
