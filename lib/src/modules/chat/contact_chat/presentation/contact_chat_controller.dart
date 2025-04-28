import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'contact_chat_state.dart';

class ContactChatController extends ChangeNotifier {
  ContactChatState _state = ContactChatInitial();
  final TextEditingController textController = TextEditingController();
  final ChatService _chatService = GetIt.instance<ChatService>();
  final AuthService _authService = GetIt.instance<AuthService>();

  ContactChatState get state => _state;

  void _emitState(ContactChatState newState) {
    _state = newState;
    notifyListeners();
  }

  // Future<void> loadMessages(String contactUser) async {
  //   _emitState(ContactChatLoading());

  //   final logedUser = await _authService.getUserId();

  //   _chatService
  //       .getMessages(
  //     logedUser.toString(),
  //     contactUser,
  //   )
  //       .listen((messages) {
  //     _emitState(ContactChatSuccess(messages));
  //   });
  // }

  Future<void> sendMessage({required String toId}) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final userId = await _authService.getUserId();

    await _chatService.sendMessage(
      fromId: userId.toString(),
      toId: toId,
      text: text,
    );

    textController.clear();
  }
}
