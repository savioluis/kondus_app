import 'package:flutter/material.dart';
import 'contact_chat_state.dart';

class ContactChatController extends ChangeNotifier {
  ContactChatState _state = ContactChatInitial();
  final TextEditingController textController = TextEditingController();

  ContactChatState get state => _state;

  void _setState(ContactChatState newState) {
    _state = newState;
    notifyListeners();
  }

  void loadMessages(String uid) async {
    _setState(ContactChatLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final messages = [
        {'text': 'Ola, vi que está precisando de um martelo. Posso ajudá-lo com isso.\n\n[MENSÁGEM AUTOMÁTICA]', 'isUserMessage': false},
        {'text': 'Oi, muito obrigado. Eu posso ir ai buscar ?', 'isUserMessage': true},
        {'text': 'Pode sim. Estarei disponível pela tarde', 'isUserMessage': false},
        {'text': 'Ok', 'isUserMessage': true},
      ];
      _setState(ContactChatSuccess(messages));
    } catch (e) {
      _setState(ContactChatFailure('Erro ao carregar mensagens: $e'));
    }
  }

  void sendMessage(String uid) {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    if (state is ContactChatSuccess) {
      final currentMessages = (state as ContactChatSuccess).messages;
      final newMessage = {'text': text, 'isUserMessage': true};
      _setState(ContactChatSuccess([...currentMessages, newMessage]));
      textController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        final replyMessage = {'text': 'Resposta automática', 'isUserMessage': false};
        _setState(ContactChatSuccess([...currentMessages, newMessage, replyMessage]));
      });
    }
  }
}
