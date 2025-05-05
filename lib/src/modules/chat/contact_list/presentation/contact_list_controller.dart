import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/src/modules/chat/contact_list/model/contact_model.dart';
import 'contact_list_state.dart';

class ContactListController extends ChangeNotifier {
  final ChatService _chatService = GetIt.instance<ChatService>();
  final AuthService _authService = GetIt.instance<AuthService>();

  ContactListState _state = ContactListInitial();

  ContactListState get state => _state;

  void _emitState(ContactListState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchContacts() async {
    _emitState(ContactListLoading());

    try {
      final usersIdsWithWhomUserHasChated =
          await _chatService.getUsersIdsContacts();

      if (usersIdsWithWhomUserHasChated.isEmpty) {
        _emitState(ContactListSuccess(const []));
        return;
      }

      final users = await _authService.getUsersInfo();

      final filteredUsers = users.users
          .where(
            (user) =>
                usersIdsWithWhomUserHasChated.contains(user.id.toString()),
          )
          .toList();

      _emitState(
          ContactListSuccess(ContactModel.fromUserDTOList(filteredUsers)));
    } catch (e) {
      _emitState(ContactListFailure('Erro ao obter as últimas conversas: $e'));
    }
  }
}
